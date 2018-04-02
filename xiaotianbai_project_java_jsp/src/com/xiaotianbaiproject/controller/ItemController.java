package com.xiaotianbaiproject.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.xiaotianbaiproject.po.ItemClass;
import com.xiaotianbaiproject.po.ProductBidding;
import com.xiaotianbaiproject.po.UserInfo;
import com.xiaotianbaiproject.service.ItemClassService;
import com.xiaotianbaiproject.service.ItemService;
import com.xiaotianbaiproject.service.ProductBiddingService;
import com.xiaotianbaiproject.service.UserInfoService;
import com.xiaotianbaiproject.utils.ExportExcelUtil;
import com.xiaotianbaiproject.utils.UserException;

//ItemManage控制层
@Controller
@RequestMapping("/Item")
public class ItemController extends BaseController {

    @Resource ItemService itemService;

    @Resource ItemClassService itemClassService;
    @Resource UserInfoService userInfoService;
    @Resource ProductBiddingService biddingService;
	@InitBinder("itemClassObj")
	public void initBinderitemClassObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("itemClassObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("item")
	public void initBinderItem(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("item.");
	}
	/*JumpToAddItemView*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Item());
		/*SearchAllItemClassInfo*/
		List<ItemClass> itemClassList = itemClassService.queryAllItemClass();
		request.setAttribute("itemClassList", itemClassList);
		/*SearchAllUserInfoInfo*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Item_add";
	}

	/*ClientajaxUploadAddItemInfo*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Item item, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "InputInfo Not Valid！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			item.setItemPhoto(this.handlePhotoUpload(request, "itemPhotoFile"));
		} catch(UserException ex) {
			message = "Wrong Format！";
			writeJsonResponse(response, success, message);
			return ;
		}
        itemService.addItem(item);
        message = "ItemAddSuccessful!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*ClientajaxUploadAddItemInfo*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(Item item,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		 
		try {
			item.setItemPhoto(this.handlePhotoUpload(request, "itemPhotoFile"));
		} catch(UserException ex) {
			message = "Wrong Format！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		String userName =  session.getAttribute("user_name").toString();
		UserInfo userObj = new UserInfo();
		userObj.setUser_name(userName);
		item.setUserObj(userObj);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date startDate = new java.util.Date();
		//add 5mins for test only
		Date endDate = new java.util.Date(startDate.getTime() + (5*60*1000));
		String startTime = sdf.format(startDate);
		String endTime = sdf.format(endDate);
		
		item.setStartTime(startTime);
		item.setEndTime(endTime); 
		
        itemService.addItem(item);
        message = "ItemAddSuccessful!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	
	/*ajax  SearchItemInfo*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("itemClassObj") ItemClass itemClassObj,String pTitle,@ModelAttribute("userObj") UserInfo userObj,String startTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (pTitle == null) pTitle = "";
		if (startTime == null) startTime = "";
		if(rows != 0)itemService.setRows(rows);
		List<Item> itemList = itemService.queryItem(itemClassObj, pTitle, userObj, startTime, page);
	    /*Get total num of pages and records*/
	    itemService.queryTotalPageAndRecordNumber(itemClassObj, pTitle, userObj, startTime);
	    /*Get total num of pages*/
	    int totalPage = itemService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = itemService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		 
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Item item:itemList) {
			JSONObject jsonItem = item.getJsonObject();
			jsonArray.put(jsonItem);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax  SearchItemInfo*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Item> itemList = itemService.queryAllItem();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Item item:itemList) {
			JSONObject jsonItem = new JSONObject();
			jsonItem.accumulate("itemId", item.getItemId());
			jsonItem.accumulate("pTitle", item.getPTitle());
			jsonArray.put(jsonItem);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*FrontEndSearchByDescription*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("itemClassObj") ItemClass itemClassObj,String pTitle,@ModelAttribute("userObj") UserInfo userObj,String startTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (pTitle == null) pTitle = "";
		if (startTime == null) startTime = "";
		List<Item> itemList = itemService.queryItem(itemClassObj, pTitle, userObj, startTime, currentPage);
	    /*Get total num of pages and records*/
	    itemService.queryTotalPageAndRecordNumber(itemClassObj, pTitle, userObj, startTime);
	    /*Get total num of pages*/
	    int totalPage = itemService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = itemService.getRecordNumber();
	    request.setAttribute("itemList",  itemList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("itemClassObj", itemClassObj);
	    request.setAttribute("pTitle", pTitle);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("startTime", startTime);
	    List<ItemClass> itemClassList = itemClassService.queryAllItemClass();
	    request.setAttribute("itemClassList", itemClassList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Item/item_frontquery_result"; 
	}
	
	
	/*FrontEndSearchByDescription*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("itemClassObj") ItemClass itemClassObj,String pTitle,@ModelAttribute("userObj") UserInfo userObj,String startTime,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (pTitle == null) pTitle = "";
		if (startTime == null) startTime = "";
		userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		
		List<Item> itemList = itemService.queryItem(itemClassObj, pTitle, userObj, startTime, currentPage);
	    /*Get total num of pages and records*/
	    itemService.queryTotalPageAndRecordNumber(itemClassObj, pTitle, userObj, startTime);
	    /*Get total num of pages*/
	    int totalPage = itemService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = itemService.getRecordNumber();
	    request.setAttribute("itemList",  itemList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("itemClassObj", itemClassObj);
	    request.setAttribute("pTitle", pTitle);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("startTime", startTime);
	    List<ItemClass> itemClassList = itemClassService.queryAllItemClass();
	    request.setAttribute("itemClassList", itemClassList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Item/item_frontUserquery_result"; 
	}
	

     /*FrontEnd Search ItemInfo*/
	@RequestMapping(value="/{itemId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer itemId,Model model,HttpServletRequest request) throws Exception {
        Item item = itemService.getItem(itemId); 
        List<ItemClass> itemClassList = itemClassService.queryAllItemClass();
        request.setAttribute("itemClassList", itemClassList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        ArrayList<ProductBidding> biddingList = biddingService.queryProductBidding(item, null, "");
         
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("item",  item);
        request.setAttribute("biddingList", biddingList); 
        
        return "Item/item_frontshow";
	}

	/*ajax: Display Item and Edit jsp Page*/
	@RequestMapping(value="/{itemId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer itemId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*UseKeyitemIdGetItemObj*/
        Item item = itemService.getItem(itemId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		 
		JSONObject jsonItem = item.getJsonObject();
		out.println(jsonItem.toString());
		out.flush();
		out.close();
	}

	/*ajax: Update Item Info*/
	@RequestMapping(value = "/{itemId}/update", method = RequestMethod.POST)
	public void update(@Validated Item item, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "Input Info Not Correct！";
			writeJsonResponse(response, success, message);
			return;
		}
		String itemPhotoFileName = this.handlePhotoUpload(request, "itemPhotoFile");
		if(!itemPhotoFileName.equals("upload/NoImage.jpg"))item.setItemPhoto(itemPhotoFileName); 


		try {
			itemService.updateItem(item);
			message = "ItemUpdateSuccessful!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "ItemUpdateFailed!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*Delete Item Info*/
	@RequestMapping(value="/{itemId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer itemId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  itemService.deleteItem(itemId);
	            request.setAttribute("message", "ItemDeleteSuccessful!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "ItemDeleteFailed!");
				return "error";

	        }

	}

	/*ajaxDeleteMultipleItemRecord*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String itemIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = itemService.deleteItems(itemIds);
        	success = true;
        	message = count + "RecordDeleteSuccessful";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "Forein key constrains detected,DeleteFailed";
            writeJsonResponse(response, success, message);
        }
	}

	/* ExportItemInfoToExcel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("itemClassObj") ItemClass itemClassObj,String pTitle,@ModelAttribute("userObj") UserInfo userObj,String startTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(pTitle == null) pTitle = "";
        if(startTime == null) startTime = "";
        List<Item> itemList = itemService.queryItem(itemClassObj,pTitle,userObj,startTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String title = "ItemInfoRecord"; 
        String[] headers = { "ItemClass","Item Title","ItemPhoto","Poster","StartPrice","Start Time","EndTime"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<itemList.size();i++) {
        	Item item = itemList.get(i); 
        	dataset.add(new String[]{item.getItemClassObj().getClassName(),item.getPTitle(),item.getItemPhoto(),item.getUserObj().getName(),item.getStartPrice() + "",item.getStartTime(),item.getEndTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Item.xls"); 
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
