<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.ItemClass" %>
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
<title>Search for Item</title>
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
  			<li class="active">AddItem</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="itemAddForm" id="itemAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="item_itemClassObj_classId" class="col-md-2 text-right">ItemClass:</label>
				  	 <div class="col-md-8">
					    <select id="item_itemClassObj_classId" name="item.itemClassObj.classId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="item_pTitle" class="col-md-2 text-right">Item Title:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="item_pTitle" name="item.pTitle" class="form-control" placeholder="Input Item Title">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="item_itemPhoto" class="col-md-2 text-right">ItemPhoto:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="item_itemPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="item_itemPhoto" name="item.itemPhoto"/>
					    <input id="itemPhotoFile" name="itemPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="item_itemDesc" class="col-md-2 text-right">ItemDescription:</label>
				  	 <div class="col-md-8">
					    <textarea id="item_itemDesc" name="item.itemDesc" rows="8" class="form-control" placeholder="Input ItemDescription"></textarea>
					 </div>
				  </div>
				 
				  <div class="form-group">
				  	 <label for="item_startPrice" class="col-md-2 text-right">StartPrice:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="item_startPrice" name="item.startPrice" class="form-control" placeholder="Input StartPrice">
					 </div>
				  </div>
				  
				  
						   <div class="form-group">
						      <span class="col-md-2""></span>
						      <span onclick="ajaxItemAdd();" class="btn btn-primary bottom5 top5">AddItem</span>
						   </div> 
						   <style>#itemAddForm .form-group {margin:5px;}  </style>  
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
	//UploadAddItemInfo
	function ajaxItemAdd() { 
		//Upload之前先Validate表单
		$("#itemAddForm").data('bootstrapValidator').validate();
		if(!$("#itemAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Item/userAdd",
			dataType : "json" , 
			data: new FormData($("#itemAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("AddSuccessful！");
					$("#itemAddForm").find("input").val("");
					$("#itemAddForm").find("textarea").val("");
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
	//ValidateItemAddForm
	$('#itemAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"item.pTitle": {
				validators: {
					notEmpty: {
						message: "Item Title cannot be empty",
					}
				}
			},
			"item.itemDesc": {
				validators: {
					notEmpty: {
						message: "ItemDescription cannot be empty",
					}
				}
			},
			"item.startPrice": {
				validators: {
					notEmpty: {
						message: "StartPrice cannot be empty",
					},
					numeric: {
						message: "StartPriceIncorrect"
					}
				}
			},
			 
		}
	}); 
	//InitializeItemClassValues 
	$.ajax({
		url: basePath + "ItemClass/listAll",
		type: "get",
		success: function(itemClasss,response,status) { 
			$("#item_itemClassObj_classId").empty();
			var html="";
    		$(itemClasss).each(function(i,itemClass){
    			html += "<option value='" + itemClass.classId + "'>" + itemClass.className + "</option>";
    		});
    		$("#item_itemClassObj_classId").html(html);
    	}
	});
	  
})
</script>
</body>
</html>
