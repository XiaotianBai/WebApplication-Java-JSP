<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.ItemClass" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    ItemClass itemClass = (ItemClass)request.getAttribute("itemClass");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>EditItemClassInfo</TITLE>
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
  		<li class="active">ItemClassInfoEdit</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="itemClassEditForm" id="itemClassEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="itemClass_classId_edit" class="col-md-3 text-right">ItemClassid:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="itemClass_classId_edit" name="itemClass.classId" class="form-control" placeholder="Input ItemClassid" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="itemClass_className_edit" class="col-md-3 text-right">ItemClassName:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="itemClass_className_edit" name="itemClass.className" class="form-control" placeholder="Input ItemClassName">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="itemClass_classDesc_edit" class="col-md-3 text-right">Class描述:</label>
		  	 <div class="col-md-9">
			    <textarea id="itemClass_classDesc_edit" name="itemClass.classDesc" rows="8" class="form-control" placeholder="Input Class描述"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxItemClassModify();" class="btn btn-primary bottom5 top5">Edit</span>
			  </div>
		</form> 
	    <style>#itemClassEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出EditItemClass界面并Initialize数据*/
function itemClassEdit(classId) {
	$.ajax({
		url :  basePath + "ItemClass/" + classId + "/update",
		type : "get",
		dataType: "json",
		success : function (itemClass, response, status) {
			if (itemClass) {
				$("#itemClass_classId_edit").val(itemClass.classId);
				$("#itemClass_className_edit").val(itemClass.className);
				$("#itemClass_classDesc_edit").val(itemClass.classDesc);
			} else {
				alert("GetInfoFailed！");
			}
		}
	});
}

/*ajaxUploadItemClassInfo Edit*/
function ajaxItemClassModify() {
	$.ajax({
		url :  basePath + "ItemClass/" + $("#itemClass_classId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#itemClassEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("InfoEditSuccessful！");
                location.reload(true);
                location.href= basePath + "ItemClass/frontlist";
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
    itemClassEdit("<%=request.getParameter("classId")%>");
 })
 </script> 
</body>
</html>

