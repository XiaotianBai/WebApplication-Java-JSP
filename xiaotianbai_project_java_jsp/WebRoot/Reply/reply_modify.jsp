<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_user_logstate.jsp"/>
<!DOCTYPE html>
<html>
<head>
<title>EditPage</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reply.css" />
</head>
<body style="margin:0px; font-size:14px; background-image:url(../images/bg.jpg); background-position:bottom; background-repeat:repeat;">
<div id="reply_editDiv">
	<form id="replyEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">Replyid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reply_replyId_edit" name="reply.replyId" value="<%=request.getParameter("replyId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">OriginalPost:</span>
			<span class="inputControl">
				<input class="textbox"  id="reply_postInfoObj_postInfoId_edit" name="reply.postInfoObj.postInfoId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">ReplyContent:</span>
			<span class="inputControl">
				<textarea id="reply_content_edit" name="reply.content" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">Replier:</span>
			<span class="inputControl">
				<input class="textbox"  id="reply_userObj_user_name_edit" name="reply.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">ReplyTime:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reply_replyTime_edit" name="reply.replyTime" />

			</span>

		</div>
		<div class="operation">
			<a id="replyModifyButton" class="easyui-linkbutton">Update</a> 
		</div>
	</form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js" ></script>
<script src="${pageContext.request.contextPath}/Reply/js/reply_modify.js"></script> 
</body>
</html>
