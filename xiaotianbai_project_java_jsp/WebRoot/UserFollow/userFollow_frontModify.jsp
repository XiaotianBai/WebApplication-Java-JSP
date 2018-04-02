<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.UserFollow" %>
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //GetAlluserObj2Info
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    UserFollow userFollow = (UserFollow)request.getAttribute("userFollow");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>EditUserFollowerInfo</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">Index</a></li>
  		<li class="active">UserFollowerInfoEdit</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="userFollowEditForm" id="userFollowEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="userFollow_followId_edit" class="col-md-3 text-right">Recordid:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="userFollow_followId_edit" name="userFollow.followId" class="form-control" placeholder="Input Recordid" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="userFollow_userObj1_user_name_edit" class="col-md-3 text-right">Followed:</label>
		  	 <div class="col-md-9">
			    <select id="userFollow_userObj1_user_name_edit" name="userFollow.userObj1.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userFollow_userObj2_user_name_edit" class="col-md-3 text-right">Follower:</label>
		  	 <div class="col-md-9">
			    <select id="userFollow_userObj2_user_name_edit" name="userFollow.userObj2.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userFollow_followTime_edit" class="col-md-3 text-right">FollowTime:</label>
		  	 <div class="col-md-9">
                <div class="input-group date userFollow_followTime_edit col-md-12" data-link-field="userFollow_followTime_edit">
                    <input class="form-control" id="userFollow_followTime_edit" name="userFollow.followTime" size="16" type="text" value="" placeholder="Choose FollowTime" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxUserFollowModify();" class="btn btn-primary bottom5 top5">Edit</span>
			  </div>
		</form> 
	    <style>#userFollowEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.en-US.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出EditUserFollower界面并Initialize数据*/
function userFollowEdit(followId) {
	$.ajax({
		url :  basePath + "UserFollow/" + followId + "/update",
		type : "get",
		dataType: "json",
		success : function (userFollow, response, status) {
			if (userFollow) {
				$("#userFollow_followId_edit").val(userFollow.followId);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#userFollow_userObj1_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#userFollow_userObj1_user_name_edit").html(html);
		        		$("#userFollow_userObj1_user_name_edit").val(userFollow.userObj1Pri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#userFollow_userObj2_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#userFollow_userObj2_user_name_edit").html(html);
		        		$("#userFollow_userObj2_user_name_edit").val(userFollow.userObj2Pri);
					}
				});
				$("#userFollow_followTime_edit").val(userFollow.followTime);
			} else {
				alert("GetInfoFailed！");
			}
		}
	});
}

/*ajaxUploadUserFollowerInfo Edit*/
function ajaxUserFollowModify() {
	$.ajax({
		url :  basePath + "UserFollow/" + $("#userFollow_followId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#userFollowEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("InfoEditSuccessful！");
                location.reload(true);
                $("#userFollowQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*click hide*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*FollowTimePart*/
    $('.userFollow_followTime_edit').datetimepicker({
    	language:  'en-US',  //language
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    userFollowEdit("<%=request.getParameter("followId")%>");
 })
 </script> 
</body>
</html>

