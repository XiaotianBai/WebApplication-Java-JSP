<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.Item" %>
<%@ page import="com.xiaotianbaiproject.po.ItemClass" %>
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
<%@ page import="com.xiaotianbaiproject.po.ProductBidding" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //GetAllitemClassObjInfo
    List<ItemClass> itemClassList = (List<ItemClass>)request.getAttribute("itemClassList");
    //GetAlluserObjInfo
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Item item = (Item)request.getAttribute("item");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>InspectItemDetails</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
  <link href="<%=basePath %>css/item_frontshow.css" rel="stylesheet"> 
  
 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">Index</a></li>
  		<li><a href="<%=basePath %>Item/frontlist">ItemInfo</a></li>
  		<li class="active">DetailsInspect</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">Itemid:</div>
		<div class="col-md-10 col-xs-6"><%=item.getItemId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">ItemClass:</div>
		<div class="col-md-10 col-xs-6"><%=item.getItemClassObj().getClassName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">Item Title:</div>
		<div class="col-md-10 col-xs-6"><%=item.getPTitle()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">ItemPhoto:</div>
		<div class="col-md-10 col-xs-6"><img class="img-responsive" src="<%=basePath %><%=item.getItemPhoto() %>"  border="0px"/></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">ItemDescription:</div>
		<div class="col-md-10 col-xs-6"><%=item.getItemDesc()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">Poster:</div>
		<div class="col-md-10 col-xs-6"><%=item.getUserObj().getName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">StartPrice:</div>
		<div class="col-md-10 col-xs-6"><%=item.getStartPrice()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">Start Time:</div>
		<div class="col-md-10 col-xs-6"><%=item.getStartTime()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">EndTime:</div>
		<div class="col-md-10 col-xs-6"><%=item.getEndTime()%></div>
	</div>
	
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">BiddingPrice:</div>
		<div class="col-md-10 col-xs-6">
			<input type="text" name="biddingPrice" id="biddingPrice"/>
		</div>
	</div>
	
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="doBidding();" class="btn btn-primary">PlaceBid</button>
			<button onclick="doFollow();" class="btn btn-primary">FollowPoster</button>
			<button onclick="history.back();" class="btn btn-info">Return</button>
		</div>
	</div>
	
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		
		<div class="col-md-6 col-xs-6">
			 
			
			<div class="bidList">
			<%
				ArrayList<ProductBidding> biddingList = (ArrayList<ProductBidding>) request.getAttribute("biddingList");
				for(int i=0;i<biddingList.size();i++) {
					ProductBidding bidding = biddingList.get(i);
					String bidStateClass = "bidLeader";
					if(i > 0) bidStateClass = "bidOut";
				
			%>
				<div class="ddli">
					<div class="state">
						<div class="bidTime"><%=bidding.getBiddingTime() %></div>
						<div class="bidState">
							<span class="<%=bidStateClass %>"></span>
						</div>
					</div>
					<div class="avatar">
						<a href target="top"><img src="<%=basePath %><%=bidding.getUserObj().getUserImage() %>"/></a>
					</div>
					<div class="bidUser">
						<div class="name">
							<a href target="top"><%=bidding.getUserObj().getName() %></a>
						</div>
						<div class="price">$<%=bidding.getBiddingPrice() %> </div>
					</div>
				</div>
			<% } %>
				 
				
			</div>
			
		</div>
	</div>
	
</div> 
 
<br/><br/>
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
$(function(){
     
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 

function doBidding() { 
	var biddingPrice = $("#biddingPrice").val(); 
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	if(!reg.test(biddingPrice)) {
		alert("Input Correct Price!");
		return;
	}  
   
    $.ajax({
		url : basePath + "ProductBidding/userAdd",
		type : "post", 
		data: {
			"productBidding.itemObj.itemId": <%=item.getItemId() %>,
			"productBidding.biddingPrice": biddingPrice
		},
		success : function (data, response, status) {
			//var obj = jQuery.parseJSON(data); 
            if(data.success){
	            alert("Successful!");
	            location.reload(); 
        	}else{
            	alert(data.message);
        	}   
		}
	}); 
}



//Follow User
function doFollow(){ 
	$.ajax({
		url : basePath + "UserFollow/userAdd",
		type : "post", 
		data: {
			"userFollow.userObj1.user_name": "<%=item.getUserObj().getUser_name() %>"
		},
		success : function (data, response, status) { 
            if(data.success){ 
	            alert("Successful!"); 
        	}else{
            	alert(data.message);
        	}   
		}
	});
	 
}
 </script> 
</body>
</html>

