<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>UserFollowerSearch</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>UserFollow/frontlist">UserFollowerList</a></li>
			    	<li role="presentation" class="active"><a href="#userFollowAdd" aria-controls="userFollowAdd" role="tab" data-toggle="tab">AddUserFollower</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="userFollowList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="userFollowAdd"> 
				      	<form class="form-horizontal" name="userFollowAddForm" id="userFollowAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="userFollow_userObj1_user_name" class="col-md-2 text-right">Followed:</label>
						  	 <div class="col-md-8">
							    <select id="userFollow_userObj1_user_name" name="userFollow.userObj1.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="userFollow_userObj2_user_name" class="col-md-2 text-right">Follower:</label>
						  	 <div class="col-md-8">
							    <select id="userFollow_userObj2_user_name" name="userFollow.userObj2.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="userFollow_followTimeDiv" class="col-md-2 text-right">FollowTime:</label>
						  	 <div class="col-md-8">
				                <div id="userFollow_followTimeDiv" class="input-group date userFollow_followTime col-md-12" data-link-field="userFollow_followTime">
				                    <input class="form-control" id="userFollow_followTime" name="userFollow.followTime" size="16" type="text" value="" placeholder="Choose FollowTime" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
								            <div class="form-group">
								            	<span class="col-md-2""></span>
								            	<span onclick="ajaxUserFollowAdd();" class="btn btn-primary bottom5 top5">Add</span>
								            </div>
						</form> 
				        <style>#userFollowAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.en-US.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//UploadAddUserFollowerInfo
	function ajaxUserFollowAdd() { 
		//Upload之前先Validate表单
		$("#userFollowAddForm").data('bootstrapValidator').validate();
		if(!$("#userFollowAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "UserFollow/add",
			dataType : "json" , 
			data: new FormData($("#userFollowAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("SaveSuccessful！");
					$("#userFollowAddForm").find("input").val("");
					$("#userFollowAddForm").find("textarea").val("");
				} else {
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
	//ValidateUserFollowerAddForm
	$('#userFollowAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"userFollow.followTime": {
				validators: {
					notEmpty: {
						message: "FollowTime cannot be empty",
					}
				}
			},
		}
	}); 
	//InitializeFollowedValues 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#userFollow_userObj1_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#userFollow_userObj1_user_name").html(html);
    	}
	});
	//InitializeFollowerValues 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#userFollow_userObj2_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#userFollow_userObj2_user_name").html(html);
    	}
	});
	//FollowTimePart
	$('#userFollow_followTimeDiv').datetimepicker({
		language:  'en-US',  //Displaylanguage
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//Validate Date
		$('#userFollowAddForm').data('bootstrapValidator').updateStatus('userFollow.followTime', 'NOT_VALIDATED',null).validateField('userFollow.followTime');
	});
})
</script>
</body>
</html>
