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

//ReplyManage控制层
@Controller
@RequestMapping("/Reply")
public class ReplyController extends BaseController {

    /*业务层Obj*/
    @Resource ReplyService replyService;

    @Resource PostInfoService postInfoService;
    @Resource UserInfoService userInfoService;
	@InitBinder("postInfoObj")
	public void initBinderpostInfoObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("postInfoObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("reply")
	public void initBinderReply(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("reply.");
	}
	/*JumpToAddReplyView*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Reply());
		/*SearchAllPostInfoInfo*/
		List<PostInfo> postInfoList = postInfoService.queryAllPostInfo();
		request.setAttribute("postInfoList", postInfoList);
		/*SearchAllUserInfoInfo*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Reply_add";
	}

	/*ClientajaxUploadAddReplyInfo*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Reply reply, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "InputInfo Not Valid！";
			writeJsonResponse(response, success, message);
			return ;
		}
        replyService.addReply(reply);
        message = "ReplyAddSuccessful!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	/*UserajaxUploadAddReplyInfo*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(Reply reply,
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
		reply.setUserObj(userObj);
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		reply.setReplyTime(sdf.format(new java.util.Date()));
		
        replyService.addReply(reply);
        message = "ReplyAddSuccessful!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	
	/*ajax  SearchReplyInfo*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("userObj") UserInfo userObj,String replyTime,@ModelAttribute("postInfoObj") PostInfo postInfoObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (replyTime == null) replyTime = "";
		if(rows != 0)replyService.setRows(rows);
		List<Reply> replyList = replyService.queryReply(userObj, replyTime, postInfoObj, page);
	    /*Get total num of pages and records*/
	    replyService.queryTotalPageAndRecordNumber(userObj, replyTime, postInfoObj);
	    /*Get total num of pages*/
	    int totalPage = replyService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = replyService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		 
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Reply reply:replyList) {
			JSONObject jsonReply = reply.getJsonObject();
			jsonArray.put(jsonReply);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax  SearchReplyInfo*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Reply> replyList = replyService.queryAllReply();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Reply reply:replyList) {
			JSONObject jsonReply = new JSONObject();
			jsonReply.accumulate("replyId", reply.getReplyId());
			jsonArray.put(jsonReply);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*FrontEnd  SearchReplyInfo*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("userObj") UserInfo userObj,String replyTime,@ModelAttribute("postInfoObj") PostInfo postInfoObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (replyTime == null) replyTime = "";
		List<Reply> replyList = replyService.queryReply(userObj, replyTime, postInfoObj, currentPage);
	    /*Get total num of pages and records*/
	    replyService.queryTotalPageAndRecordNumber(userObj, replyTime, postInfoObj);
	    /*Get total num of pages*/
	    int totalPage = replyService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = replyService.getRecordNumber();
	    request.setAttribute("replyList",  replyList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("replyTime", replyTime);
	    request.setAttribute("postInfoObj", postInfoObj);
	    List<PostInfo> postInfoList = postInfoService.queryAllPostInfo();
	    request.setAttribute("postInfoList", postInfoList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Reply/reply_frontquery_result"; 
	}

     /*FrontEndSearchReplyInfo*/
	@RequestMapping(value="/{replyId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer replyId,Model model,HttpServletRequest request) throws Exception {
		/*UseKeyreplyIdGetReplyObj*/
        Reply reply = replyService.getReply(replyId);

        List<PostInfo> postInfoList = postInfoService.queryAllPostInfo();
        request.setAttribute("postInfoList", postInfoList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("reply",  reply);
        return "Reply/reply_frontshow";
	}

	/*ajaxDisplayReplyEditjspViewPage*/
	@RequestMapping(value="/{replyId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer replyId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*UseKeyreplyIdGetReplyObj*/
        Reply reply = replyService.getReply(replyId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		 
		JSONObject jsonReply = reply.getJsonObject();
		out.println(jsonReply.toString());
		out.flush();
		out.close();
	}

	/*ajaxUpdateReplyInfo*/
	@RequestMapping(value = "/{replyId}/update", method = RequestMethod.POST)
	public void update(@Validated Reply reply, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "Input Info Not Correct！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			replyService.updateReply(reply);
			message = "ReplyUpdateSuccessful!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "ReplyUpdateFailed!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*DeleteReplyInfo*/
	@RequestMapping(value="/{replyId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer replyId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  replyService.deleteReply(replyId);
	            request.setAttribute("message", "ReplyDeleteSuccessful!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "ReplyDeleteFailed!");
				return "error";

	        }

	}

	/*ajaxDeleteMultipleReplyRecord*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String replyIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = replyService.deleteReplys(replyIds);
        	success = true;
        	message = count + "RecordDeleteSuccessful";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "Forein key constrains detected,DeleteFailed";
            writeJsonResponse(response, success, message);
        }
	}

	/* ExportReplyInfoToExcel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("userObj") UserInfo userObj,String replyTime,@ModelAttribute("postInfoObj") PostInfo postInfoObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(replyTime == null) replyTime = "";
        List<Reply> replyList = replyService.queryReply(userObj,replyTime,postInfoObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String title = "ReplyInfoRecord"; 
        String[] headers = { "Replyid","OriginalPost","ReplyContent","Replier","ReplyTime"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<replyList.size();i++) {
        	Reply reply = replyList.get(i); 
        	dataset.add(new String[]{reply.getReplyId() + "",reply.getPostInfoObj().getPTitle(),reply.getContent(),reply.getUserObj().getName(),reply.getReplyTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Reply.xls"); 
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
