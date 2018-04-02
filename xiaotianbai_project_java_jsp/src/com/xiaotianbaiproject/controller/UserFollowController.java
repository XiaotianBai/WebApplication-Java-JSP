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

import com.xiaotianbaiproject.po.UserFollow;
import com.xiaotianbaiproject.po.UserInfo;
import com.xiaotianbaiproject.service.UserFollowService;
import com.xiaotianbaiproject.service.UserInfoService;
import com.xiaotianbaiproject.utils.ExportExcelUtil;
import com.xiaotianbaiproject.utils.UserException;

//UserFollowManage控制层
@Controller
@RequestMapping("/UserFollow")
public class UserFollowController extends BaseController {

    @Resource UserFollowService userFollowService;

    @Resource UserInfoService userInfoService;
	@InitBinder("userObj1")
	public void initBinderuserObj1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj1.");
	}
	@InitBinder("userObj2")
	public void initBinderuserObj2(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj2.");
	}
	@InitBinder("userFollow")
	public void initBinderUserFollow(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userFollow.");
	}
	/*JumpToAddUserFollowView*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new UserFollow());
		/*SearchAllUserInfoInfo*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "UserFollow_add";
	}

	/*ClientajaxUploadAddUserFollowerInfo*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated UserFollow userFollow, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "InputInfo Not Valid！";
			writeJsonResponse(response, success, message);
			return ;
		}
        userFollowService.addUserFollow(userFollow);
        message = "UserFollowerAddSuccessful!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*UserajaxUploadAddFollowerOtherUser*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(UserFollow userFollow,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		String userName = (String)session.getAttribute("user_name");
		if(userName == null) {
			message = "Please Login！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		if(userName.equals(userFollow.getUserObj1().getUser_name())) {
			message = "You cannot follow yourself！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		UserInfo userObj2 = new UserInfo();
		userObj2.setUser_name(userName);
		userFollow.setUserObj2(userObj2);
		
		
		int followSize = userFollowService.queryUserFollow(userFollow.getUserObj1(), userObj2, "").size();
		if( followSize > 0) {
			message = "You have already followed this user！";
			writeJsonResponse(response, success, message);
			return ;
		}
		 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		userFollow.setFollowTime(sdf.format(new java.util.Date()));
		
        userFollowService.addUserFollow(userFollow);
        message = "UserFollowerSuccessful!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	
	
	/*ajax  SearchUserFollowerInfo*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("userObj1") UserInfo userObj1,@ModelAttribute("userObj2") UserInfo userObj2,String followTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (followTime == null) followTime = "";
		if(rows != 0)userFollowService.setRows(rows);
		List<UserFollow> userFollowList = userFollowService.queryUserFollow(userObj1, userObj2, followTime, page);
	    /*Get total num of pages and records*/
	    userFollowService.queryTotalPageAndRecordNumber(userObj1, userObj2, followTime);
	    /*Get total num of pages*/
	    int totalPage = userFollowService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = userFollowService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		 
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(UserFollow userFollow:userFollowList) {
			JSONObject jsonUserFollow = userFollow.getJsonObject();
			jsonArray.put(jsonUserFollow);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax  SearchUserFollowerInfo*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<UserFollow> userFollowList = userFollowService.queryAllUserFollow();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(UserFollow userFollow:userFollowList) {
			JSONObject jsonUserFollow = new JSONObject();
			jsonUserFollow.accumulate("followId", userFollow.getFollowId());
			jsonArray.put(jsonUserFollow);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*FrontEnd  SearchUserFollowerInfo*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("userObj1") UserInfo userObj1,@ModelAttribute("userObj2") UserInfo userObj2,String followTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (followTime == null) followTime = "";
		List<UserFollow> userFollowList = userFollowService.queryUserFollow(userObj1, userObj2, followTime, currentPage);
	    /*Get total num of pages and records*/
	    userFollowService.queryTotalPageAndRecordNumber(userObj1, userObj2, followTime);
	    /*Get total num of pages*/
	    int totalPage = userFollowService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = userFollowService.getRecordNumber();
	    request.setAttribute("userFollowList",  userFollowList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj1", userObj1);
	    request.setAttribute("userObj2", userObj2);
	    request.setAttribute("followTime", followTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "UserFollow/userFollow_frontquery_result"; 
	}
	
	
	/*FrontEndUser  SearchOwnFollower*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("userObj1") UserInfo userObj1,@ModelAttribute("userObj2") UserInfo userObj2,String followTime,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (followTime == null) followTime = "";
		
		userObj2 = new UserInfo();
		userObj2.setUser_name(session.getAttribute("user_name").toString());
		
		List<UserFollow> userFollowList = userFollowService.queryUserFollow(userObj1, userObj2, followTime, currentPage);
	    /*Get total num of pages and records*/
	    userFollowService.queryTotalPageAndRecordNumber(userObj1, userObj2, followTime);
	    /*Get total num of pages*/
	    int totalPage = userFollowService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = userFollowService.getRecordNumber();
	    request.setAttribute("userFollowList",  userFollowList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj1", userObj1);
	    request.setAttribute("userObj2", userObj2);
	    request.setAttribute("followTime", followTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "UserFollow/userFollow_frontUserquery_result"; 
	}
	
	

     /*FrontEndSearchUserFollowInfo*/
	@RequestMapping(value="/{followId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer followId,Model model,HttpServletRequest request) throws Exception {
		/*UseKeyfollowIdGetUserFollowObj*/
        UserFollow userFollow = userFollowService.getUserFollow(followId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("userFollow",  userFollow);
        return "UserFollow/userFollow_frontshow";
	}

	/*ajaxDisplayUserFollowerEditjspViewPage*/
	@RequestMapping(value="/{followId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer followId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*UseKeyfollowIdGetUserFollowObj*/
        UserFollow userFollow = userFollowService.getUserFollow(followId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		 
		JSONObject jsonUserFollow = userFollow.getJsonObject();
		out.println(jsonUserFollow.toString());
		out.flush();
		out.close();
	}

	/*ajaxUpdateUserFollowerInfo*/
	@RequestMapping(value = "/{followId}/update", method = RequestMethod.POST)
	public void update(@Validated UserFollow userFollow, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "Input Info Not Correct！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			userFollowService.updateUserFollow(userFollow);
			message = "UserFollowerUpdateSuccessful!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "UserFollowerUpdateFailed!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*DeleteUserFollowerInfo*/
	@RequestMapping(value="/{followId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer followId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  userFollowService.deleteUserFollow(followId);
	            request.setAttribute("message", "UserFollowerDeleteSuccessful!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "UserFollowerDeleteFailed!");
				return "error";

	        }

	}

	/*ajaxDeleteMultipleUserFollowerRecord*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String followIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = userFollowService.deleteUserFollows(followIds);
        	success = true;
        	message = count + "RecordDeleteSuccessful";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "Forein key constrains detected,DeleteFailed";
            writeJsonResponse(response, success, message);
        }
	}

	/* ExportUserFollowerInfoToExcel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("userObj1") UserInfo userObj1,@ModelAttribute("userObj2") UserInfo userObj2,String followTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(followTime == null) followTime = "";
        List<UserFollow> userFollowList = userFollowService.queryUserFollow(userObj1,userObj2,followTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String title = "UserFollowInfoRecord"; 
        String[] headers = { "Recordid","Followed","Follower","FollowTime"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<userFollowList.size();i++) {
        	UserFollow userFollow = userFollowList.get(i); 
        	dataset.add(new String[]{userFollow.getFollowId() + "",userFollow.getUserObj1().getName(),userFollow.getUserObj2().getName(),userFollow.getFollowTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"UserFollow.xls"); 
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
