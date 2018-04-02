<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.ProductBidding" %>
<%@ page import="com.xiaotianbaiproject.po.Item" %>
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //GetAllitemObjInfo
    List<Item> itemList = (List<Item>)request.getAttribute("itemList");
    //GetAlluserObjInfo
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    ProductBidding productBidding = (ProductBidding)request.getAttribute("productBidding");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>InspectBiddingDetails</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">Index</a></li>
  		<li><a href="<%=basePath %>ProductBidding/frontlist">BiddingInfo</a></li>
  		<li class="active">DetailsInspect</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">BiddingID:</div>
		<div class="col-md-10 col-xs-6"><%=productBidding.getBiddingId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">BiddingItem:</div>
		<div class="col-md-10 col-xs-6"><%=productBidding.getItemObj().getPTitle() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">BiddingUser:</div>
		<div class="col-md-10 col-xs-6"><%=productBidding.getUserObj().getName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">BiddingTime:</div>
		<div class="col-md-10 col-xs-6"><%=productBidding.getBiddingTime()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">BiddingPrice:</div>
		<div class="col-md-10 col-xs-6"><%=productBidding.getBiddingPrice()%></div>
	</div>
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="history.back();" class="btn btn-primary">Return</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
$(function(){
        /*click hide*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 </script> 
</body>
</html>

