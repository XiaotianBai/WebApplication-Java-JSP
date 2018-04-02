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
<title>ItemClassSearch</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>ItemClass/frontlist">ItemClassList</a></li>
			    	<li role="presentation" class="active"><a href="#itemClassAdd" aria-controls="itemClassAdd" role="tab" data-toggle="tab">AddItemClass</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="itemClassList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="itemClassAdd"> 
				      	<form class="form-horizontal" name="itemClassAddForm" id="itemClassAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="itemClass_className" class="col-md-2 text-right">ItemClassName:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="itemClass_className" name="itemClass.className" class="form-control" placeholder="Input ItemClassName">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="itemClass_classDesc" class="col-md-2 text-right">Class描述:</label>
						  	 <div class="col-md-8">
							    <textarea id="itemClass_classDesc" name="itemClass.classDesc" rows="8" class="form-control" placeholder="Input Class描述"></textarea>
							 </div>
						  </div>
								            <div class="form-group">
								            	<span class="col-md-2""></span>
								            	<span onclick="ajaxItemClassAdd();" class="btn btn-primary bottom5 top5">Add</span>
								            </div>
						</form> 
				        <style>#itemClassAddForm .form-group {margin:10px;}  </style>
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
	//UploadAddItemClassInfo
	function ajaxItemClassAdd() { 
		//Upload之前先Validate表单
		$("#itemClassAddForm").data('bootstrapValidator').validate();
		if(!$("#itemClassAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "ItemClass/add",
			dataType : "json" , 
			data: new FormData($("#itemClassAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("SaveSuccessful！");
					$("#itemClassAddForm").find("input").val("");
					$("#itemClassAddForm").find("textarea").val("");
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
	//ValidateItemClassAddForm
	$('#itemClassAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"itemClass.className": {
				validators: {
					notEmpty: {
						message: "ItemClassName cannot be empty",
					}
				}
			},
			"itemClass.classDesc": {
				validators: {
					notEmpty: {
						message: "Class描述 cannot be empty",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
