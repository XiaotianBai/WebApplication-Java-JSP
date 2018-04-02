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
  			<li><a href="<%=basePath %>Item/frontlist">ItemManage</a></li>
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
				  	 <label for="item_userObj_user_name" class="col-md-2 text-right">Poster:</label>
				  	 <div class="col-md-8">
					    <select id="item_userObj_user_name" name="item.userObj.user_name" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="item_startPrice" class="col-md-2 text-right">StartPrice:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="item_startPrice" name="item.startPrice" class="form-control" placeholder="Input StartPrice">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="item_startTimeDiv" class="col-md-2 text-right">Start Time:</label>
				  	 <div class="col-md-8">
		                <div id="item_startTimeDiv" class="input-group date item_startTime col-md-12" data-link-field="item_startTime">
		                    <input class="form-control" id="item_startTime" name="item.startTime" size="16" type="text" value="" placeholder="Choose Start Time" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="item_endTimeDiv" class="col-md-2 text-right">EndTime:</label>
				  	 <div class="col-md-8">
		                <div id="item_endTimeDiv" class="input-group date item_endTime col-md-12" data-link-field="item_endTime">
		                    <input class="form-control" id="item_endTime" name="item.endTime" size="16" type="text" value="" placeholder="Choose EndTime" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
						   <div class="form-group">
						      <span class="col-md-2""></span>
						      <span onclick="ajaxItemAdd();" class="btn btn-primary bottom5 top5">Add</span>
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
			url : basePath + "Item/add",
			dataType : "json" , 
			data: new FormData($("#itemAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("SaveSuccessful！");
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
			"item.startTime": {
				validators: {
					notEmpty: {
						message: "Start Time cannot be empty",
					}
				}
			},
			"item.endTime": {
				validators: {
					notEmpty: {
						message: "EndTime cannot be empty",
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
	//InitializePosterValues 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#item_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#item_userObj_user_name").html(html);
    	}
	});
	//EndTimePart
	$('#item_endTimeDiv').datetimepicker({
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
		$('#itemAddForm').data('bootstrapValidator').updateStatus('item.endTime', 'NOT_VALIDATED',null).validateField('item.endTime');
	});
	//Start TimePart
	$('#item_startTimeDiv').datetimepicker({
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
		$('#itemAddForm').data('bootstrapValidator').updateStatus('item.startTime', 'NOT_VALIDATED',null).validateField('item.startTime');
	});
})
</script>
</body>
</html>
