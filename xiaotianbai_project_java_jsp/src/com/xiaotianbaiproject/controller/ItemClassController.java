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

import com.xiaotianbaiproject.po.ItemClass;
import com.xiaotianbaiproject.service.ItemClassService;
import com.xiaotianbaiproject.utils.ExportExcelUtil;
import com.xiaotianbaiproject.utils.UserException;

//ItemClassManage Control Layer
@Controller
@RequestMapping("/ItemClass")
public class ItemClassController extends BaseController {

    /*service target*/
    @Resource ItemClassService itemClassService;

	@InitBinder("itemClass")
	public void initBinderItemClass(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("itemClass.");
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ItemClass());
		return "ItemClass_add";
	}

	/*client submit item class*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ItemClass itemClass, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "error:";
			writeJsonResponse(response, success, message);
			return ;
		}
        itemClassService.addItemClass(itemClass);
        message = "successfully added";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*query item class*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)itemClassService.setRows(rows);
		List<ItemClass> itemClassList = itemClassService.queryItemClass(page);

	    itemClassService.queryTotalPageAndRecordNumber();

	    int totalPage = itemClassService.getTotalPage();

	    int recordNumber = itemClassService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();

		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ItemClass itemClass:itemClassList) {
			JSONObject jsonItemClass = itemClass.getJsonObject();
			jsonArray.put(jsonItemClass);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*SearchItemClassInfo*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ItemClass> itemClassList = itemClassService.queryAllItemClass();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ItemClass itemClass:itemClassList) {
			JSONObject jsonItemClass = new JSONObject();
			jsonItemClass.accumulate("classId", itemClass.getClassId());
			jsonItemClass.accumulate("className", itemClass.getClassName());
			jsonArray.put(jsonItemClass);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*FrontEndSearchItemClassInfoByDescription*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<ItemClass> itemClassList = itemClassService.queryItemClass(currentPage);
	    /*Get total num of pages and records*/
	    itemClassService.queryTotalPageAndRecordNumber();
	    /*Get total num of pages*/
	    int totalPage = itemClassService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = itemClassService.getRecordNumber();
	    request.setAttribute("itemClassList",  itemClassList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "ItemClass/itemClass_frontquery_result"; 
	}

     /*FrontEndSearchItemClassInfo*/
	@RequestMapping(value="/{classId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer classId,Model model,HttpServletRequest request) throws Exception {
		/*UseKeyclassIdGetItemClassObj*/
        ItemClass itemClass = itemClassService.getItemClass(classId);

        request.setAttribute("itemClass",  itemClass);
        return "ItemClass/itemClass_frontshow";
	}

	/*ajaxDisplayItemClassEditjspViewPage*/
	@RequestMapping(value="/{classId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer classId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*UseKeyclassIdGetItemClassObj*/
        ItemClass itemClass = itemClassService.getItemClass(classId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		 
		JSONObject jsonItemClass = itemClass.getJsonObject();
		out.println(jsonItemClass.toString());
		out.flush();
		out.close();
	}

	/*ajaxUpdateItemInfo*/
	@RequestMapping(value = "/{classId}/update", method = RequestMethod.POST)
	public void update(@Validated ItemClass itemClass, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "Input Info Not Correct！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			itemClassService.updateItemClass(itemClass);
			message = "ItemClassUpdateSuccessful!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "ItemClassUpdateFailed!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*DeleteItemClassInfo*/
	@RequestMapping(value="/{classId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer classId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  itemClassService.deleteItemClass(classId);
	            request.setAttribute("message", "ItemClassDeleteSuccessful!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "ItemClassDeleteFailed!");
				return "error";

	        }

	}

	/*ajaxDeleteMultipleItemClassRecord*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String classIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = itemClassService.deleteItemClasss(classIds);
        	success = true;
        	message = count + "RecordDeleteSuccessful";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "Forein key constrains detected,DeleteFailed";
            writeJsonResponse(response, success, message);
        }
	}

	/* ExportItemClassInfoToExcel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<ItemClass> itemClassList = itemClassService.queryItemClass();
        ExportExcelUtil ex = new ExportExcelUtil();
        String title = "ItemClassInfoRecord"; 
        String[] headers = { "ItemClassid","ItemClassName"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<itemClassList.size();i++) {
        	ItemClass itemClass = itemClassList.get(i); 
        	dataset.add(new String[]{itemClass.getClassId() + "",itemClass.getClassName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"ItemClass.xls"); 
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
