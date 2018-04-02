package com.xiaotianbaiproject.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.xiaotianbaiproject.po.Item;
import com.xiaotianbaiproject.po.ProductBidding;
import com.xiaotianbaiproject.po.UserInfo;
import com.xiaotianbaiproject.service.ItemService;
import com.xiaotianbaiproject.service.ProductBiddingService;
import com.xiaotianbaiproject.service.UserInfoService;
import com.xiaotianbaiproject.utils.ExportExcelUtil;
import com.xiaotianbaiproject.utils.UserException;

//ProductBiddingManageControl
@Controller
@RequestMapping("/ProductBidding")
public class ProductBiddingController extends BaseController {

    /*业务层Obj*/
    @Resource ProductBiddingService productBiddingService;

    @Resource ItemService itemService;
    @Resource UserInfoService userInfoService;
	@InitBinder("itemObj")
	public void initBinderitemObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("itemObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("productBidding")
	public void initBinderProductBidding(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("productBidding.");
	}
	/*JumpToAddProductBiddingView*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ProductBidding());
		/*SearchAllItemInfo*/
		List<Item> itemList = itemService.queryAllItem();
		request.setAttribute("itemList", itemList);
		/*SearchAllUserInfoInfo*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "ProductBidding_add";
	}

	/*ClientajaxUploadAddBiddingInfo*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ProductBidding productBidding, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "InputInfo Not Valid！";
			writeJsonResponse(response, success, message);
			return ;
		}
        productBiddingService.addProductBidding(productBidding);
        message = "BiddingAddSuccessful!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*FrontEndUserajaxUploadAddBiddingInfo*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(ProductBidding productBidding,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		String userName = (String)session.getAttribute("user_name"); 
		if(userName == null) {
			message = "Please Login First ";
			writeJsonResponse(response, success, message);
			return;
		}
		UserInfo userObj = new UserInfo();
		userObj.setUser_name(userName);
		productBidding.setUserObj(userObj); 
		 
		int itemId = productBidding.getItemObj().getItemId();
		Item item = itemService.getItem(itemId);
		
		//Cannot Bid On Your Own Item
		if(item.getUserObj().getUser_name().equals(userName)) {
			message = "Cannot Bid On Your Own Item";
			writeJsonResponse(response, success, message);
			return;
		}
		
		//Judge if Bidding is Over
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String biddingTime = sdf.format(new java.util.Date());
		
		if(biddingTime.compareTo(item.getEndTime()) > 0) {
			message = "Bidding is Over";
			writeJsonResponse(response, success, message);
			return;
		} 
		
		productBidding.setBiddingTime(biddingTime);
		 
		
		float startPrice = item.getStartPrice(); //StartPrice
		ArrayList<ProductBidding> biddingList = productBiddingService.queryProductBidding(item, null, "");
		if(biddingList.size() > 0 ) //Get new price
			startPrice = biddingList.get(0).getBiddingPrice();
		
		//Exception
		if(productBidding.getBiddingPrice() <= startPrice) {
			message = "You have already placed a higher bid";
			writeJsonResponse(response, success, message);
			return;
		}
		   
		
        productBiddingService.addProductBidding(productBidding);
        message = "BiddingAddSuccessful!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	
	/*ajax  SearchBiddingInfo*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("itemObj") Item itemObj,@ModelAttribute("userObj") UserInfo userObj,String biddingTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (biddingTime == null) biddingTime = "";
		if(rows != 0)productBiddingService.setRows(rows);
		List<ProductBidding> productBiddingList = productBiddingService.queryProductBidding(itemObj, userObj, biddingTime, page);
	    /*Get total num of pages and records*/
	    productBiddingService.queryTotalPageAndRecordNumber(itemObj, userObj, biddingTime);
	    /*Get total num of pages*/
	    int totalPage = productBiddingService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = productBiddingService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		 
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ProductBidding productBidding:productBiddingList) {
			JSONObject jsonProductBidding = productBidding.getJsonObject();
			jsonArray.put(jsonProductBidding);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax  SearchBiddingInfo*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ProductBidding> productBiddingList = productBiddingService.queryAllProductBidding();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ProductBidding productBidding:productBiddingList) {
			JSONObject jsonProductBidding = new JSONObject();
			jsonProductBidding.accumulate("biddingId", productBidding.getBiddingId());
			jsonArray.put(jsonProductBidding);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*FrontEnd  SearchBiddingInfo*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("itemObj") Item itemObj,@ModelAttribute("userObj") UserInfo userObj,String biddingTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (biddingTime == null) biddingTime = "";
		List<ProductBidding> productBiddingList = productBiddingService.queryProductBidding(itemObj, userObj, biddingTime, currentPage);
	    /*Get total num of pages and records*/
	    productBiddingService.queryTotalPageAndRecordNumber(itemObj, userObj, biddingTime);
	    /*Get total num of pages*/
	    int totalPage = productBiddingService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = productBiddingService.getRecordNumber();
	    request.setAttribute("productBiddingList",  productBiddingList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("itemObj", itemObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("biddingTime", biddingTime);
	    List<Item> itemList = itemService.queryAllItem();
	    request.setAttribute("itemList", itemList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "ProductBidding/productBidding_frontquery_result"; 
	}
	
	
	/*UserFrontEnd  SearchOwnBiddingInfo*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("itemObj") Item itemObj,@ModelAttribute("userObj") UserInfo userObj,String biddingTime,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (biddingTime == null) biddingTime = "";
		userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		
		List<ProductBidding> productBiddingList = productBiddingService.queryProductBidding(itemObj, userObj, biddingTime, currentPage);
	    /*Get total num of pages and records*/
	    productBiddingService.queryTotalPageAndRecordNumber(itemObj, userObj, biddingTime);
	    /*Get total num of pages*/
	    int totalPage = productBiddingService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = productBiddingService.getRecordNumber();
	    request.setAttribute("productBiddingList",  productBiddingList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("itemObj", itemObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("biddingTime", biddingTime);
	    List<Item> itemList = itemService.queryAllItem();
	    request.setAttribute("itemList", itemList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "ProductBidding/productBidding_frontUserquery_result"; 
	}
	

     /*FrontEndSearchProductBiddingInfo*/
	@RequestMapping(value="/{biddingId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer biddingId,Model model,HttpServletRequest request) throws Exception {
		/*UseKeybiddingIdGetProductBiddingObj*/
        ProductBidding productBidding = productBiddingService.getProductBidding(biddingId);

        List<Item> itemList = itemService.queryAllItem();
        request.setAttribute("itemList", itemList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("productBidding",  productBidding);
        return "ProductBidding/productBidding_frontshow";
	}

	/*ajaxDisplayBiddingEditjspViewPage*/
	@RequestMapping(value="/{biddingId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer biddingId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*UseKeybiddingIdGetProductBiddingObj*/
        ProductBidding productBidding = productBiddingService.getProductBidding(biddingId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		 
		JSONObject jsonProductBidding = productBidding.getJsonObject();
		out.println(jsonProductBidding.toString());
		out.flush();
		out.close();
	}

	/*ajaxUpdateBiddingInfo*/
	@RequestMapping(value = "/{biddingId}/update", method = RequestMethod.POST)
	public void update(@Validated ProductBidding productBidding, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "Input Info Not Correct！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			productBiddingService.updateProductBidding(productBidding);
			message = "BiddingUpdateSuccessful!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "BiddingUpdateFailed!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*DeleteBiddingInfo*/
	@RequestMapping(value="/{biddingId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer biddingId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  productBiddingService.deleteProductBidding(biddingId);
	            request.setAttribute("message", "BiddingDeleteSuccessful!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "BiddingDeleteFailed!");
				return "error";

	        }

	}

	/*ajaxDeleteMultipleBiddingRecord*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String biddingIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = productBiddingService.deleteProductBiddings(biddingIds);
        	success = true;
        	message = count + "RecordDeleteSuccessful";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "Forein key constrains detected,DeleteFailed";
            writeJsonResponse(response, success, message);
        }
	}

	/* ExportBiddingInfoToExcel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("itemObj") Item itemObj,@ModelAttribute("userObj") UserInfo userObj,String biddingTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(biddingTime == null) biddingTime = "";
        List<ProductBidding> productBiddingList = productBiddingService.queryProductBidding(itemObj,userObj,biddingTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String title = "ProductBiddingInfoRecord"; 
        String[] headers = { "biddingId","Item","User","BiddingTime","BiddingPrice"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<productBiddingList.size();i++) {
        	ProductBidding productBidding = productBiddingList.get(i); 
        	dataset.add(new String[]{productBidding.getBiddingId() + "",productBidding.getItemObj().getPTitle(),productBidding.getUserObj().getName(),productBidding.getBiddingTime(),productBidding.getBiddingPrice() + ""});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//create an output stream
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"ProductBidding.xls"); 
			response.setContentType("application/msexcel;charset=UTF-8");//SetType 
			response.setHeader("Pragma","No-cache");//SetHead 
			response.setHeader("Cache-Control","no-cache");//SetHead 
			response.setDateHeader("Expires", 0);//SetDateHead 
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
