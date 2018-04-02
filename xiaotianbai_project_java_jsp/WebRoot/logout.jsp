<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 
	session.removeAttribute("user_name");	
	session.removeAttribute("user_name");
	session.invalidate();
	out.println("<script>top.location='" + basePath +"index.jsp';</script>");
%>