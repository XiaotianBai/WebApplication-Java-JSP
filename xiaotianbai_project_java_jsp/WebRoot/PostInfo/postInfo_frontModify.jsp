<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.PostInfo" %>
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //GetAlluserObjInfo
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    PostInfo postInfo = (PostInfo)request.getAttribute("postInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>EditPostInfo</TITLE>
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
  		<li class="active">PostInfoEdit</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="postInfoEditForm" id="postInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="postInfo_postInfoId_edit" class="col-md-3 text-right">Postid:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="postInfo_postInfoId_edit" name="postInfo.postInfoId" class="form-control" placeholder="Input Postid" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="postInfo_pTitle_edit" class="col-md-3 text-right">PostTitle:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="postInfo_pTitle_edit" name="postInfo.pTitle" class="form-control" placeholder="Input PostTitle">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_content_edit" class="col-md-3 text-right">PostContent:</label>
		  	 <div class="col-md-9">
			    <textarea id="postInfo_content_edit" name="postInfo.content" rows="8" class="form-control" placeholder="Input PostContent"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_userObj_user_name_edit" class="col-md-3 text-right">Poster:</label>
		  	 <div class="col-md-9">
			    <select id="postInfo_userObj_user_name_edit" name="postInfo.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_addTime_edit" class="col-md-3 text-right">Post Time:</label>
		  	 <div class="col-md-9">
                <div class="input-group date postInfo_addTime_edit col-md-12" data-link-field="postInfo_addTime_edit">
                    <input class="form-control" id="postInfo_addTime_edit" name="postInfo.addTime" size="16" type="text" value="" placeholder="Choose Post Time" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_hitNum_edit" class="col-md-3 text-right">Views:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="postInfo_hitNum_edit" name="postInfo.hitNum" class="form-control" placeholder="Input Views">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxPostInfoModify();" class="btn btn-primary bottom5 top5">Edit</span>
			  </div>
		</form> 
	    <style>#postInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出EditPost界面并Initialize数据*/
function postInfoEdit(postInfoId) {
	$.ajax({
		url :  basePath + "PostInfo/" + postInfoId + "/update",
		type : "get",
		dataType: "json",
		success : function (postInfo, response, status) {
			if (postInfo) {
				$("#postInfo_postInfoId_edit").val(postInfo.postInfoId);
				$("#postInfo_pTitle_edit").val(postInfo.pTitle);
				$("#postInfo_content_edit").val(postInfo.content);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#postInfo_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#postInfo_userObj_user_name_edit").html(html);
		        		$("#postInfo_userObj_user_name_edit").val(postInfo.userObjPri);
					}
				});
				$("#postInfo_addTime_edit").val(postInfo.addTime);
				$("#postInfo_hitNum_edit").val(postInfo.hitNum);
			} else {
				alert("GetInfoFailed！");
			}
		}
	});
}

/*ajaxUploadPostInfo Edit*/
function ajaxPostInfoModify() {
	$.ajax({
		url :  basePath + "PostInfo/" + $("#postInfo_postInfoId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#postInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("InfoEditSuccessful！");
                location.reload(true);
                $("#postInfoQueryForm").submit();
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
    /*Post TimePart*/
    $('.postInfo_addTime_edit').datetimepicker({
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
    postInfoEdit("<%=request.getParameter("postInfoId")%>");
 })
 </script> 
</body>
</html>

