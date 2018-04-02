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

import com.xiaotianbaiproject.po.UserInfo;
import com.xiaotianbaiproject.service.UserInfoService;
import com.xiaotianbaiproject.utils.ExportExcelUtil;
import com.xiaotianbaiproject.utils.UserException;

//UserInfoManage
@Controller
@RequestMapping("/UserInfo")
public class UserInfoController extends BaseController {

   
    @Resource UserInfoService userInfoService;

	@InitBinder("userInfo")
	public void initBinderUserInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userInfo.");
	}
	/*JumpToAddUserInfoView*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new UserInfo());
		return "UserInfo_add";
	}

	/*ClientajaxUploadAddUserInfo*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated UserInfo userInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "InputInfo Not Valid！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(userInfoService.getUserInfo(userInfo.getUser_name()) != null) {
			message = "UsernameAlready Exists！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			userInfo.setUserImage(this.handlePhotoUpload(request, "userImageFile"));
		} catch(UserException ex) {
			message = "Wrong Format！";
			writeJsonResponse(response, success, message);
			return ;
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		userInfo.setCreateTime(sdf.format(new java.util.Date()));
        userInfoService.addUserInfo(userInfo);
        message = "UserRegSuccessful!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax  SearchUserInfo*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String paypalAccount,String user_name,String name,String birthDate,String telephone,String city,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (paypalAccount == null) paypalAccount = "";
		if (user_name == null) user_name = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		if (city == null) city = "";
		if(rows != 0)userInfoService.setRows(rows);
		List<UserInfo> userInfoList = userInfoService.queryUserInfo(paypalAccount, user_name, name, birthDate, telephone, city, page);
	    /*Get total num of pages and records*/
	    userInfoService.queryTotalPageAndRecordNumber(paypalAccount, user_name, name, birthDate, telephone, city);
	    /*Get total num of pages*/
	    int totalPage = userInfoService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = userInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		 
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(UserInfo userInfo:userInfoList) {
			JSONObject jsonUserInfo = userInfo.getJsonObject();
			jsonArray.put(jsonUserInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax  SearchUserInfo*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(UserInfo userInfo:userInfoList) {
			JSONObject jsonUserInfo = new JSONObject();
			jsonUserInfo.accumulate("user_name", userInfo.getUser_name());
			jsonUserInfo.accumulate("name", userInfo.getName());
			jsonArray.put(jsonUserInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*FrontEnd  SearchUserInfo*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String paypalAccount,String user_name,String name,String birthDate,String telephone,String city,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (paypalAccount == null) paypalAccount = "";
		if (user_name == null) user_name = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		if (city == null) city = "";
		List<UserInfo> userInfoList = userInfoService.queryUserInfo(paypalAccount, user_name, name, birthDate, telephone, city, currentPage);
	    /*Get total num of pages and records*/
	    userInfoService.queryTotalPageAndRecordNumber(paypalAccount, user_name, name, birthDate, telephone, city);
	    /*Get total num of pages*/
	    int totalPage = userInfoService.getTotalPage();
	    /*Get num of records*/
	    int recordNumber = userInfoService.getRecordNumber();
	    request.setAttribute("userInfoList",  userInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("paypalAccount", paypalAccount);
	    request.setAttribute("user_name", user_name);
	    request.setAttribute("name", name);
	    request.setAttribute("birthDate", birthDate);
	    request.setAttribute("telephone", telephone);
	    request.setAttribute("city", city);
		return "UserInfo/userInfo_frontquery_result"; 
	}

     /*FrontEndSearchUserInfoInfo*/
	@RequestMapping(value="/{user_name}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String user_name,Model model,HttpServletRequest request) throws Exception {
		/*UseKeyuser_nameGetUserInfoObj*/
        UserInfo userInfo = userInfoService.getUserInfo(user_name);

        request.setAttribute("userInfo",  userInfo);
        return "UserInfo/userInfo_frontshow";
	}

	/*ajaxDisplayUserEditjspViewPage*/
	@RequestMapping(value="/{user_name}/update",method=RequestMethod.GET)
	public void update(@PathVariable String user_name,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*UseKeyuser_nameGetUserInfoObj*/
        UserInfo userInfo = userInfoService.getUserInfo(user_name);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		 
		JSONObject jsonUserInfo = userInfo.getJsonObject();
		out.println(jsonUserInfo.toString());
		out.flush();
		out.close();
	}

	/*ajaxUpdateUserInfo*/
	@RequestMapping(value = "/{user_name}/update", method = RequestMethod.POST)
	public void update(@Validated UserInfo userInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "Input Info Not Correct！";
			writeJsonResponse(response, success, message);
			return;
		}
		String userImageFileName = this.handlePhotoUpload(request, "userImageFile");
		if(!userImageFileName.equals("upload/NoImage.jpg"))userInfo.setUserImage(userImageFileName); 


		try {
			userInfoService.updateUserInfo(userInfo);
			message = "UserUpdateSuccessful!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "UserUpdateFailed!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*DeleteUserInfo*/
	@RequestMapping(value="/{user_name}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String user_name,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  userInfoService.deleteUserInfo(user_name);
	            request.setAttribute("message", "UserDeleteSuccessful!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "UserDeleteFailed!");
				return "error";

	        }

	}

	/*ajaxDeleteMultipleUserRecord*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String user_names,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = userInfoService.deleteUserInfos(user_names);
        	success = true;
        	message = count + "RecordDeleteSuccessful";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "Forein key constrains detected,DeleteFailed";
            writeJsonResponse(response, success, message);
        }
	}

	/* ExportUserInfoToExcel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String paypalAccount,String user_name,String name,String birthDate,String telephone,String city, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(paypalAccount == null) paypalAccount = "";
        if(user_name == null) user_name = "";
        if(name == null) name = "";
        if(birthDate == null) birthDate = "";
        if(telephone == null) telephone = "";
        if(city == null) city = "";
        List<UserInfo> userInfoList = userInfoService.queryUserInfo(paypalAccount,user_name,name,birthDate,telephone,city);
        ExportExcelUtil ex = new ExportExcelUtil();
        String title = "UserInfoInfoRecord"; 
        String[] headers = { "Username","Password","Name","Gender","BirthDate","Photo","Phone","City","PayPalAccount","CreateTime"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<userInfoList.size();i++) {
        	UserInfo userInfo = userInfoList.get(i); 
        	dataset.add(new String[]{userInfo.getUser_name(),userInfo.getPassword(),userInfo.getName(),userInfo.getGender(),userInfo.getBirthDate(),userInfo.getUserImage(),userInfo.getTelephone(),userInfo.getCity(),userInfo.getPaypalAccount(),userInfo.getCreateTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"UserInfo.xls"); 
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
