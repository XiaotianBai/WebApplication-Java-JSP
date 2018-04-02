<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_user_logstate.jsp"/>
<!DOCTYPE html>
<html>
<head>
<title>EditPage</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/postInfo.css" />
</head>
<body style="margin:0px; font-size:14px; background-image:url(../images/bg.jpg); background-position:bottom; background-repeat:repeat;">
<div id="postInfo_editDiv">
	<form id="postInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">Postid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_postInfoId_edit" name="postInfo.postInfoId" value="<%=request.getParameter("postInfoId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">PostTitle:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_pTitle_edit" name="postInfo.pTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">PostContent:</span>
			<span class="inputControl">
				<textarea id="postInfo_content_edit" name="postInfo.content" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">Poster:</span>
			<span class="inputControl">
				<input class="textbox"  id="postInfo_userObj_user_name_edit" name="postInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">Post Time:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_addTime_edit" name="postInfo.addTime" />

			</span>

		</div>
		<div>
			<span class="label">Views:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_hitNum_edit" name="postInfo.hitNum" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="postInfoModifyButton" class="easyui-linkbutton">Update</a> 
		</div>
	</form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js" ></script>
<script src="${pageContext.request.contextPath}/PostInfo/js/postInfo_modify.js"></script> 
</body>
</html>
