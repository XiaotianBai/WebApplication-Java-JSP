package com.xiaotianbaiproject.controller;

import java.beans.PropertyEditorSupport;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.xiaotianbaiproject.utils.UserException;

public class BaseController {
	
	
	
	@InitBinder
	// WebDataBinder
	public void initBinder(WebDataBinder binder) {
		//System.out.println(binder.getFieldDefaultPrefix());
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				new SimpleDateFormat("yyyy-MM-dd"), false));
	 
		binder.registerCustomEditor(Integer.class, new PropertyEditorSupport() {
			@Override
			public String getAsText() { 
				return (getValue() == null) ? "" : getValue().toString();
			} 
			@Override
			public void setAsText(String text) {
				Integer value = null;
				if (null != text && !text.equals("")) {  
						try {
							value = Integer.valueOf(text);
						} catch(Exception ex)  { 
							throw new UserException("incorrect input format!"); 
						}  
				}
				setValue(value);
			} 
		});
	  
		//binder.registerCustomEditor(Integer.class, null,new CustomNumberEditor(Integer.class, null, true));
		
		binder.registerCustomEditor(Float.class, new PropertyEditorSupport() {
			@Override
			public String getAsText() { 
				return (getValue() == null)? "" : getValue().toString();
			} 
			@Override
			public void setAsText(String text)  {
				Float value = null;
				if (null != text && !text.equals("")) {
					try {
						value = Float.valueOf(text);
					} catch (Exception e) { 
						throw new UserException("incorrect input format!"); 
					}
				}
				setValue(value);
			}
		});
	}
 
	/** 
	 * upload images
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */ 
	public String handlePhotoUpload(HttpServletRequest request,String fileKeyName) throws IllegalStateException, IOException {
		String fileName = "upload/NoImage.jpg";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
        /**dir**/    
        String photoBookPathDir = "/upload";     
        /**real dir**/    
        String photoBookRealPathDir = request.getSession().getServletContext().getRealPath(photoBookPathDir);     
        /**mkdir**/    
        File photoBookSaveFile = new File(photoBookRealPathDir);     
        if(!photoBookSaveFile.exists())     
        	photoBookSaveFile.mkdirs();           
        /**file stream**/    
        MultipartFile multipartFile_photoBook = multipartRequest.getFile(fileKeyName);    
        if(!multipartFile_photoBook.isEmpty()) {
        	/**get suffix**/    
            String suffix = multipartFile_photoBook.getOriginalFilename().substring  
                            (multipartFile_photoBook.getOriginalFilename().lastIndexOf("."));  
            String smallSuffix = suffix.toLowerCase();
            if(!smallSuffix.equals(".jpg") && !smallSuffix.equals(".gif") && !smallSuffix.equals(".png") )
            	throw new UserException("incorrect image format");
            /**create filename**/    
            String photoBookFileName = UUID.randomUUID().toString()+ suffix; 
            //String logImageName = multipartFile.getOriginalFilename();  
            /**get file**/    
            String photoBookFilePath = photoBookRealPathDir + File.separator  + photoBookFileName;                
            File photoBookFile = new File(photoBookFilePath);          
           
            multipartFile_photoBook.transferTo(photoBookFile);     
            
            fileName = "upload/" + photoBookFileName;
        } 
		
		return fileName;
	}
	
	

	public String handleFileUpload(HttpServletRequest request,String fileKeyName) throws IllegalStateException, IOException {
		String fileName = "";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
        String photoBookPathDir = "/upload";     
        String photoBookRealPathDir = request.getSession().getServletContext().getRealPath(photoBookPathDir);       
        File photoBookSaveFile = new File(photoBookRealPathDir);     
        if(!photoBookSaveFile.exists())     
        	photoBookSaveFile.mkdirs();            
        MultipartFile multipartFile_photoBook = multipartRequest.getFile(fileKeyName);    
        if(!multipartFile_photoBook.isEmpty()) {    
            String suffix = multipartFile_photoBook.getOriginalFilename().substring  
                            (multipartFile_photoBook.getOriginalFilename().lastIndexOf("."));   
            String photoBookFileName = UUID.randomUUID().toString()+ suffix;//构建文件Name     
            //String logImageName = multipartFile.getOriginalFilename();  
            String photoBookFilePath = photoBookRealPathDir + File.separator  + photoBookFileName;                
            File photoBookFile = new File(photoBookFilePath);          
           
            multipartFile_photoBook.transferTo(photoBookFile);     
            
            fileName = "upload/" + photoBookFileName;
        } 
		
		return fileName;
	}
	
	
	/*throw success or exception*/
	public void writeJsonResponse(HttpServletResponse response,boolean success,String message)
			throws IOException, JSONException { 
		response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();  
		JSONObject json=new JSONObject();
		json.accumulate("success", success);
		json.accumulate("message", message);
		out.println(json.toString());
		out.flush(); 
		out.close();
	}


}
