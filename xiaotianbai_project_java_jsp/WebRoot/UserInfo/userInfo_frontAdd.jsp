<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>UserSearch</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">Index</a></li>
  			<!--<li><a href="<%=basePath %>UserInfo/frontlist">UserManage</a></li>-->
  			<li class="active">AddUser</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="userInfoAddForm" id="userInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="userInfo_user_name" class="col-md-2 text-right">Username:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="userInfo_user_name" name="userInfo.user_name" class="form-control" placeholder="Input Username">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="userInfo_password" class="col-md-2 text-right">Password:</label>
				  	 <div class="col-md-8">
					    <input type="password" id="userInfo_password" name="userInfo.password" class="form-control" placeholder="Input Password">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_name" class="col-md-2 text-right">Name:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_name" name="userInfo.name" class="form-control" placeholder="Input Name">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_gender" class="col-md-2 text-right">Gender:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_gender" name="userInfo.gender" class="form-control" placeholder="Input Gender">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_birthDateDiv" class="col-md-2 text-right">BirthDate:</label>
				  	 <div class="col-md-8">
		                <div id="userInfo_birthDateDiv" class="input-group date userInfo_birthDate col-md-12" data-link-field="userInfo_birthDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="userInfo_birthDate" name="userInfo.birthDate" size="16" type="text" value="" placeholder="Choose BirthDate" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_userImage" class="col-md-2 text-right">Photo:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="userInfo_userImageImg" border="0px"/><br/>
					    <input type="hidden" id="userInfo_userImage" name="userInfo.userImage"/>
					    <input id="userImageFile" name="userImageFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_telephone" class="col-md-2 text-right">Phone:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_telephone" name="userInfo.telephone" class="form-control" placeholder="Input Phone">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_city" class="col-md-2 text-right">City:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_city" name="userInfo.city" class="form-control" placeholder="Input City">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_address" class="col-md-2 text-right">Address:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_address" name="userInfo.address" class="form-control" placeholder="Input Address">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_email" class="col-md-2 text-right">Email:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_email" name="userInfo.email" class="form-control" placeholder="Input Email">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_paypalAccount" class="col-md-2 text-right">PayPalAccount:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_paypalAccount" name="userInfo.paypalAccount" class="form-control" placeholder="Input PayPalAccount">
					 </div>
				  </div>
				   
						   <div class="form-group">
						      <span class="col-md-2""></span>
						      <span onclick="ajaxUserInfoAdd();" class="btn btn-primary bottom5 top5">Add</span>
						   </div> 
						   <style>#userInfoAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
	//UploadAddUserInfo
	function ajaxUserInfoAdd() { 
		//Upload之前先Validate表单
		$("#userInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#userInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "UserInfo/add",
			dataType : "json" , 
			data: new FormData($("#userInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("Successful！");
					$("#userInfoAddForm").find("input").val("");
					$("#userInfoAddForm").find("textarea").val("");
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
	//ValidateUserAddForm
	$('#userInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"userInfo.user_name": {
				validators: {
					notEmpty: {
						message: "Username cannot be empty",
					}
				}
			},
			"userInfo.password": {
				validators: {
					notEmpty: {
						message: "Password cannot be empty",
					}
				}
			},
			"userInfo.name": {
				validators: {
					notEmpty: {
						message: "Name cannot be empty",
					}
				}
			},
			"userInfo.gender": {
				validators: {
					notEmpty: {
						message: "Gender cannot be empty",
					}
				}
			},
			"userInfo.birthDate": {
				validators: {
					notEmpty: {
						message: "BirthDate cannot be empty",
					}
				}
			},
			"userInfo.telephone": {
				validators: {
					notEmpty: {
						message: "Phone cannot be empty",
					}
				}
			},
			"userInfo.city": {
				validators: {
					notEmpty: {
						message: "City cannot be empty",
					}
				}
			},
			"userInfo.address": {
				validators: {
					notEmpty: {
						message: "Address cannot be empty",
					}
				}
			},
			"userInfo.paypalAccount": {
				validators: {
					notEmpty: {
						message: "PayPalAccount cannot be empty",
					}
				}
			},
			 
		}
	}); 
	 

	$('#userInfo_birthDateDiv').datetimepicker({
		language:  'en-US', 
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {

		$('#userInfoAddForm').data('bootstrapValidator').updateStatus('userInfo.birthDate', 'NOT_VALIDATED',null).validateField('userInfo.birthDate');
	});
})
</script>
</body>
</html>
