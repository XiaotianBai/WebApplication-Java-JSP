<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.Item" %>
<%@ page import="com.xiaotianbaiproject.po.ItemClass" %>
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
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
  <TITLE>EditItemInfo</TITLE>
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
  		<li class="active">ItemInfoEdit</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="itemEditForm" id="itemEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="item_itemId_edit" class="col-md-3 text-right">Itemid:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="item_itemId_edit" name="item.itemId" class="form-control" placeholder="Input Itemid" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="item_itemClassObj_classId_edit" class="col-md-3 text-right">ItemClass:</label>
		  	 <div class="col-md-9">
			    <select id="item_itemClassObj_classId_edit" name="item.itemClassObj.classId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_pTitle_edit" class="col-md-3 text-right">Item Title:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="item_pTitle_edit" name="item.pTitle" class="form-control" placeholder="Input Item Title">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_itemPhoto_edit" class="col-md-3 text-right">ItemPhoto:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="item_itemPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="item_itemPhoto" name="item.itemPhoto"/>
			    <input id="itemPhotoFile" name="itemPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_itemDesc_edit" class="col-md-3 text-right">ItemDescription:</label>
		  	 <div class="col-md-9">
			    <textarea id="item_itemDesc_edit" name="item.itemDesc" rows="8" class="form-control" placeholder="Input ItemDescription"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_userObj_user_name_edit" class="col-md-3 text-right">Poster:</label>
		  	 <div class="col-md-9">
			    <select id="item_userObj_user_name_edit" name="item.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_startPrice_edit" class="col-md-3 text-right">StartPrice:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="item_startPrice_edit" name="item.startPrice" class="form-control" placeholder="Input StartPrice">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_startTime_edit" class="col-md-3 text-right">Start Time:</label>
		  	 <div class="col-md-9">
                <div class="input-group date item_startTime_edit col-md-12" data-link-field="item_startTime_edit">
                    <input class="form-control" id="item_startTime_edit" name="item.startTime" size="16" type="text" value="" placeholder="Choose Start Time" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_endTime_edit" class="col-md-3 text-right">EndTime:</label>
		  	 <div class="col-md-9">
                <div class="input-group date item_endTime_edit col-md-12" data-link-field="item_endTime_edit">
                    <input class="form-control" id="item_endTime_edit" name="item.endTime" size="16" type="text" value="" placeholder="Choose EndTime" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxItemModify();" class="btn btn-primary bottom5 top5">Edit</span>
			  </div>
		</form> 
	    <style>#itemEditForm .form-group {margin-bottom:5px;}  </style>
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
/*Initialize*/
function itemEdit(itemId) {
	$.ajax({
		url :  basePath + "Item/" + itemId + "/update",
		type : "get",
		dataType: "json",
		success : function (item, response, status) {
			if (item) {
				$("#item_itemId_edit").val(item.itemId);
				$.ajax({
					url: basePath + "ItemClass/listAll",
					type: "get",
					success: function(itemClasss,response,status) { 
						$("#item_itemClassObj_classId_edit").empty();
						var html="";
		        		$(itemClasss).each(function(i,itemClass){
		        			html += "<option value='" + itemClass.classId + "'>" + itemClass.className + "</option>";
		        		});
		        		$("#item_itemClassObj_classId_edit").html(html);
		        		$("#item_itemClassObj_classId_edit").val(item.itemClassObjPri);
					}
				});
				$("#item_pTitle_edit").val(item.pTitle);
				$("#item_itemPhoto").val(item.itemPhoto);
				$("#item_itemPhotoImg").attr("src", basePath +　item.itemPhoto);
				$("#item_itemDesc_edit").val(item.itemDesc);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#item_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#item_userObj_user_name_edit").html(html);
		        		$("#item_userObj_user_name_edit").val(item.userObjPri);
					}
				});
				$("#item_startPrice_edit").val(item.startPrice);
				$("#item_startTime_edit").val(item.startTime);
				$("#item_endTime_edit").val(item.endTime);
			} else {
				alert("GetInfoFailed！");
			}
		}
	});
}

/*ajaxUploadItemInfo Edit*/
function ajaxItemModify() {
	$.ajax({
		url :  basePath + "Item/" + $("#item_itemId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#itemEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("InfoEditSuccessful！");
                location.reload(true);
                $("#itemQueryForm").submit();
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
    /*Start TimePart*/
    $('.item_startTime_edit').datetimepicker({
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
    /*EndTimePart*/
    $('.item_endTime_edit').datetimepicker({
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
    itemEdit("<%=request.getParameter("itemId")%>");
 })
 </script> 
</body>
</html>

