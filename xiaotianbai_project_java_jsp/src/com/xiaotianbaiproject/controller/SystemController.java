package com.xiaotianbaiproject.controller;

import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import org.json.JSONObject;
import org.springframework.stereotype.Controller; 
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated; 
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.xiaotianbaiproject.po.Admin;
import com.xiaotianbaiproject.service.AdminService;
import com.xiaotianbaiproject.service.UserInfoService;
import com.xiaotianbaiproject.utils.UserException;

 
@Controller
@SessionAttributes("username")
public class SystemController { 
	
	@Resource AdminService adminService; 
	@Resource UserInfoService userInfoService;
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login(Model model) {
		model.addAttribute(new Admin());
		return "login";
	}

	//FrontEndUserLogin
	@RequestMapping(value="/frontLogin",method=RequestMethod.POST)
	public void frontLogin(@RequestParam("userName")String userName,@RequestParam("password")String password,HttpServletResponse response,HttpSession session) throws Exception { 
		boolean success = true;
		String msg = ""; 

		 
		if (!userInfoService.checkLogin(userName, password)) { 
			msg = userInfoService.getErrMessage();
			success = false; 
		} 
		if(success) {
			session.setAttribute("user_name", userName); 
		}
  
        response.setContentType("text/json;charset=UTF-8");  
        PrintWriter out = response.getWriter();  
           
        JSONObject json=new JSONObject();   
        json.accumulate("success", success);
        json.accumulate("msg", msg);
        out.println(json.toString());   
        out.flush();  
        out.close();  
	}


	@RequestMapping(value="/login",method=RequestMethod.POST)
	public void login(@Validated Admin admin,BindingResult br,Model model,HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception { 
		boolean success = true;
		String msg = ""; 
		if(br.hasErrors()) {
			msg = br.getAllErrors().toString();
			success = false;  
		} 
		if (!adminService.checkLogin(admin)) { 
			msg = adminService.getErrMessage();
			success = false; 
		} 
		if(success) {
			session.setAttribute("username", admin.getUsername()); 
		}  
        response.setContentType("text/json;charset=UTF-8");  
        PrintWriter out = response.getWriter();  
           
        JSONObject json=new JSONObject();   
        json.accumulate("success", success);
        json.accumulate("msg", msg);
        out.println(json.toString());   
        out.flush();  
        out.close();  
	}
	
	
	
	@RequestMapping("/logout")
	public String logout(Model model,HttpSession session) {
		model.asMap().remove("username"); 
		session.invalidate();
		return "redirect:/login";
	}
	
	
	@RequestMapping(value="/changePassword",method=RequestMethod.POST)
	public String ChangePassword(String oldPassword,String newPassword,String newPassword2,HttpServletRequest request,HttpSession session) throws Exception { 
		if(oldPassword.equals("")) throw new UserException("Input Old Password！");
		if(newPassword.equals("")) throw new UserException("Input New Password！");
		if(!newPassword.equals(newPassword2)) throw new UserException("两次新PasswordInput不一致"); 
		
		String username = (String)session.getAttribute("username");
		if(username == null) throw new UserException("session expired，please login again!");
		 
		
		Admin admin = adminService.findAdminByUserName(username); 
		if(!admin.getPassword().equals(oldPassword)) throw new UserException("Old Password Incorrect!");
		
		try { 
			adminService.changePassword(username,newPassword);
			request.setAttribute("message", java.net.URLEncoder.encode(
					"PasswordEditSuccessful!", "GBK"));
			return "message";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", java.net.URLEncoder
					.encode("PasswordEditFailed!","GBK"));
			return "error";
		}   
	}
	
	
	
	
}
