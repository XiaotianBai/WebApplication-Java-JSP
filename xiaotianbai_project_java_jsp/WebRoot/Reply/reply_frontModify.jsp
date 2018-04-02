<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.Reply" %>
<%@ page import="com.xiaotianbaiproject.po.PostInfo" %>
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //GetAllpostInfoObjInfo
    List<PostInfo> postInfoList = (List<PostInfo>)request.getAttribute("postInfoList");
    //GetAlluserObjInfo
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Reply reply = (Reply)request.getAttribute("reply");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>EditReplyInfo</TITLE>
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
  		<li class="active">ReplyInfoEdit</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="replyEditForm" id="replyEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="reply_replyId_edit" class="col-md-3 text-right">Replyid:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="reply_replyId_edit" name="reply.replyId" class="form-control" placeholder="Input Replyid" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="reply_postInfoObj_postInfoId_edit" class="col-md-3 text-right">OriginalPost:</label>
		  	 <div class="col-md-9">
			    <select id="reply_postInfoObj_postInfoId_edit" name="reply.postInfoObj.postInfoId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reply_content_edit" class="col-md-3 text-right">ReplyContent:</label>
		  	 <div class="col-md-9">
			    <textarea id="reply_content_edit" name="reply.content" rows="8" class="form-control" placeholder="Input ReplyContent"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reply_userObj_user_name_edit" class="col-md-3 text-right">Replier:</label>
		  	 <div class="col-md-9">
			    <select id="reply_userObj_user_name_edit" name="reply.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reply_replyTime_edit" class="col-md-3 text-right">ReplyTime:</label>
		  	 <div class="col-md-9">
                <div class="input-group date reply_replyTime_edit col-md-12" data-link-field="reply_replyTime_edit">
                    <input class="form-control" id="reply_replyTime_edit" name="reply.replyTime" size="16" type="text" value="" placeholder="Choose ReplyTime" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxReplyModify();" class="btn btn-primary bottom5 top5">Edit</span>
			  </div>
		</form> 
	    <style>#replyEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出EditReply界面并Initialize数据*/
function replyEdit(replyId) {
	$.ajax({
		url :  basePath + "Reply/" + replyId + "/update",
		type : "get",
		dataType: "json",
		success : function (reply, response, status) {
			if (reply) {
				$("#reply_replyId_edit").val(reply.replyId);
				$.ajax({
					url: basePath + "PostInfo/listAll",
					type: "get",
					success: function(postInfos,response,status) { 
						$("#reply_postInfoObj_postInfoId_edit").empty();
						var html="";
		        		$(postInfos).each(function(i,postInfo){
		        			html += "<option value='" + postInfo.postInfoId + "'>" + postInfo.pTitle + "</option>";
		        		});
		        		$("#reply_postInfoObj_postInfoId_edit").html(html);
		        		$("#reply_postInfoObj_postInfoId_edit").val(reply.postInfoObjPri);
					}
				});
				$("#reply_content_edit").val(reply.content);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#reply_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#reply_userObj_user_name_edit").html(html);
		        		$("#reply_userObj_user_name_edit").val(reply.userObjPri);
					}
				});
				$("#reply_replyTime_edit").val(reply.replyTime);
			} else {
				alert("GetInfoFailed！");
			}
		}
	});
}

/*ajaxUploadReplyInfo Edit*/
function ajaxReplyModify() {
	$.ajax({
		url :  basePath + "Reply/" + $("#reply_replyId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#replyEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("InfoEditSuccessful！");
                location.reload(true);
                $("#replyQueryForm").submit();
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
    /*ReplyTimePart*/
    $('.reply_replyTime_edit').datetimepicker({
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
    replyEdit("<%=request.getParameter("replyId")%>");
 })
 </script> 
</body>
</html>

