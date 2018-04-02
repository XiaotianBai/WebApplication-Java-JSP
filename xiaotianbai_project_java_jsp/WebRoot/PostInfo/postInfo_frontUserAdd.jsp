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
<title>PostAdd</title>
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
			url : basePath + "PostInfo/userAdd",
			dataType : "json" , 
			data: new FormData($("#postInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("PostSuccessful！");
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
		}
	}); 
	 
})
</script>
</body>
</html>
