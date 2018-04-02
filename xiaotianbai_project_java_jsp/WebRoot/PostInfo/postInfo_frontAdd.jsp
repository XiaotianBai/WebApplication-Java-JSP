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
<title>Search for Posts</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>PostInfo/frontlist">PostList</a></li>
			    	<li role="presentation" class="active"><a href="#postInfoAdd" aria-controls="postInfoAdd" role="tab" data-toggle="tab">AddPost</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="postInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="postInfoAdd"> 
				      	<form class="form-horizontal" name="postInfoAddForm" id="postInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="postInfo_pTitle" class="col-md-2 text-right">PostTitle:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="postInfo_pTitle" name="postInfo.pTitle" class="form-control" placeholder="Input PostTitle">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="postInfo_content" class="col-md-2 text-right">PostContent:</label>
						  	 <div class="col-md-8">
							    <textarea id="postInfo_content" name="postInfo.content" rows="8" class="form-control" placeholder="Input PostContent"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="postInfo_userObj_user_name" class="col-md-2 text-right">Poster:</label>
						  	 <div class="col-md-8">
							    <select id="postInfo_userObj_user_name" name="postInfo.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="postInfo_addTimeDiv" class="col-md-2 text-right">Post Time:</label>
						  	 <div class="col-md-8">
				                <div id="postInfo_addTimeDiv" class="input-group date postInfo_addTime col-md-12" data-link-field="postInfo_addTime">
				                    <input class="form-control" id="postInfo_addTime" name="postInfo.addTime" size="16" type="text" value="" placeholder="Choose Post Time" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="postInfo_hitNum" class="col-md-2 text-right">Views:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="postInfo_hitNum" name="postInfo.hitNum" class="form-control" placeholder="Input Views">
							 </div>
						  </div>
								            <div class="form-group">
								            	<span class="col-md-2""></span>
								            	<span onclick="ajaxPostInfoAdd();" class="btn btn-primary bottom5 top5">Add</span>
								            </div>
						</form> 
				        <style>#postInfoAddForm .form-group {margin:10px;}  </style>
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
	//UploadAddPostInfo
	function ajaxPostInfoAdd() { 
		//Upload之前先Validate表单
		$("#postInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#postInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "PostInfo/add",
			dataType : "json" , 
			data: new FormData($("#postInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("SaveSuccessful！");
					$("#postInfoAddForm").find("input").val("");
					$("#postInfoAddForm").find("textarea").val("");
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
	//ValidatePostAddForm
	$('#postInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"postInfo.pTitle": {
				validators: {
					notEmpty: {
						message: "PostTitle cannot be empty",
					}
				}
			},
			"postInfo.content": {
				validators: {
					notEmpty: {
						message: "PostContent cannot be empty",
					}
				}
			},
			"postInfo.addTime": {
				validators: {
					notEmpty: {
						message: "Post Time cannot be empty",
					}
				}
			},
			"postInfo.hitNum": {
				validators: {
					notEmpty: {
						message: "Views cannot be empty",
					},
					integer: {
						message: "ViewsIncorrect"
					}
				}
			},
		}
	}); 
	//InitializePosterValues 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#postInfo_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#postInfo_userObj_user_name").html(html);
    	}
	});
	//Post TimePart
	$('#postInfo_addTimeDiv').datetimepicker({
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
		$('#postInfoAddForm').data('bootstrapValidator').updateStatus('postInfo.addTime', 'NOT_VALIDATED',null).validateField('postInfo.addTime');
	});
})
</script>
</body>
</html>
