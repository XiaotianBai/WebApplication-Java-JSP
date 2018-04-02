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

import com.xiaotianbaiproject.po.PostInfo;
import com.xiaotianbaiproject.po.Reply;
import com.xiaotianbaiproject.po.UserInfo;
import com.xiaotianbaiproject.service.PostInfoService;
import com.xiaotianbaiproject.service.ReplyService;
import com.xiaotianbaiproject.service.UserInfoService;
import com.xiaotianbaiproject.utils.ExportExcelUtil;
import com.xiaotianbaiproject.utils.UserException;

//PostInfoManage控制层
@Controller
@RequestMapping("/PostInfo")
public class PostInfoController extends BaseController {

    /*businuess layer Obj*/
    @Resource PostInfoService postInfoService;
    @Resource ReplyService replyService;
    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("postInfo")
	public void initBinderPostInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("postInfo.");
	}
	/*JumpToAddPostInfoView*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new PostInfo());
		/*SearchAllUserInfoInfo*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "PostInfo_add";
	}

	/*ClientajaxUploadAddPostInfo*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated PostInfo postInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "InputInfo Not Valid！";
			writeJsonResponse(response, success, message);
			return ;
		}
        postInfoService.addPostInfo(postInfo);
        message = "PostAddSuccessful!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	/*FrontEndUserajaxUploadAddPostInfo*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(PostInfo postInfo,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		String userName = (String)session.getAttribute("user_name");
		if(userName == null) {
			message = "Please Login！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		UserInfo userObj = new UserInfo();
		userObj.setUser_name(userName);
		postInfo.setUserObj(userObj);
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		postInfo.setAddTime(sdf.format(new java.util.Date()));
		
		postInfo.setHitNum(0);
		 
        postInfoService.addPostInfo(postInfo);
        message = "PostAddSuccessful!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*ajax  SearchPostInfo*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String pTitle,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (pTitle == null) pTitle = "";
		if (addTime == null) addTime = "";
		if(rows != 0)postInfoService.setRows(rows);
		List<PostInfo> postInfoList = postInfoService.queryPostInfo(pTitle, userObj, addTime, page);
	    /*Get total num of pages and records*/
	    postInfoService.queryTotalPageAndRecordNumber(pTitle, userObj, addTime);
	    /*Get total num of pages*/
	    int totalPage = postInfoService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = postInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		 
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(PostInfo postInfo:postInfoList) {
			JSONObject jsonPostInfo = postInfo.getJsonObject();
			jsonArray.put(jsonPostInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax  SearchPostInfo*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<PostInfo> postInfoList = postInfoService.queryAllPostInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(PostInfo postInfo:postInfoList) {
			JSONObject jsonPostInfo = new JSONObject();
			jsonPostInfo.accumulate("postInfoId", postInfo.getPostInfoId());
			jsonPostInfo.accumulate("pTitle", postInfo.getPTitle());
			jsonArray.put(jsonPostInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*FrontEnd  SearchPostInfo*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String pTitle,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (pTitle == null) pTitle = "";
		if (addTime == null) addTime = "";
		List<PostInfo> postInfoList = postInfoService.queryPostInfo(pTitle, userObj, addTime, currentPage);
	    /*Get total num of pages and records*/
	    postInfoService.queryTotalPageAndRecordNumber(pTitle, userObj, addTime);
	    /*Get total num of pages*/
	    int totalPage = postInfoService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = postInfoService.getRecordNumber();
	    request.setAttribute("postInfoList",  postInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("pTitle", pTitle);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("addTime", addTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "PostInfo/postInfo_frontquery_result"; 
	}
	
	
	/*UserFrontEnd  SearchOwnPostInfo*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(String pTitle,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (pTitle == null) pTitle = "";
		if (addTime == null) addTime = "";
		userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		
		List<PostInfo> postInfoList = postInfoService.queryPostInfo(pTitle, userObj, addTime, currentPage);
	    /*Get total num of pages and records*/
	    postInfoService.queryTotalPageAndRecordNumber(pTitle, userObj, addTime);
	    /*Get total num of pages*/
	    int totalPage = postInfoService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = postInfoService.getRecordNumber();
	    request.setAttribute("postInfoList",  postInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("pTitle", pTitle);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("addTime", addTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "PostInfo/postInfo_frontUserquery_result"; 
	}
	

     /*FrontEndSearchPostInfoInfo*/
	@RequestMapping(value="/{postInfoId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer postInfoId,Model model,HttpServletRequest request) throws Exception {
		/*UseKeypostInfoIdGetPostInfoObj*/
        PostInfo postInfo = postInfoService.getPostInfo(postInfoId);
        postInfo.setHitNum(postInfo.getHitNum() + 1);
        postInfoService.updatePostInfo(postInfo);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        //Get到Post的AllReplyInfo
        ArrayList<Reply> replyList = replyService.queryReply(null, "", postInfo); 
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("postInfo",  postInfo);
        request.setAttribute("replyList", replyList);
        return "PostInfo/postInfo_frontshow";
	}

	/*ajaxDisplayPostEditjspViewPage*/
	@RequestMapping(value="/{postInfoId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer postInfoId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*UseKeypostInfoIdGetPostInfoObj*/
        PostInfo postInfo = postInfoService.getPostInfo(postInfoId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		 
		JSONObject jsonPostInfo = postInfo.getJsonObject();
		out.println(jsonPostInfo.toString());
		out.flush();
		out.close();
	}

	/*ajaxUpdatePostInfo*/
	@RequestMapping(value = "/{postInfoId}/update", method = RequestMethod.POST)
	public void update(@Validated PostInfo postInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "Input Info Not Correct！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			postInfoService.updatePostInfo(postInfo);
			message = "PostUpdateSuccessful!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "PostUpdateFailed!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*DeletePostInfo*/
	@RequestMapping(value="/{postInfoId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer postInfoId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  postInfoService.deletePostInfo(postInfoId);
	            request.setAttribute("message", "PostDeleteSuccessful!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "PostDeleteFailed!");
				return "error";

	        }

	}

	/*ajaxDeleteMultiplePostRecord*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String postInfoIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = postInfoService.deletePostInfos(postInfoIds);
        	success = true;
        	message = count + "RecordDeleteSuccessful";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "Forein key constrains detected,DeleteFailed";
            writeJsonResponse(response, success, message);
        }
	}

	/* ExportPostInfoToExcel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String pTitle,@ModelAttribute("userObj") UserInfo userObj,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(pTitle == null) pTitle = "";
        if(addTime == null) addTime = "";
        List<PostInfo> postInfoList = postInfoService.queryPostInfo(pTitle,userObj,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String title = "PostInfoInfoRecord"; 
        String[] headers = { "Postid","PostTitle","Poster","Post Time","Views"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<postInfoList.size();i++) {
        	PostInfo postInfo = postInfoList.get(i); 
        	dataset.add(new String[]{postInfo.getPostInfoId() + "",postInfo.getPTitle(),postInfo.getUserObj().getName(),postInfo.getAddTime(),postInfo.getHitNum() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"PostInfo.xls"); 
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
