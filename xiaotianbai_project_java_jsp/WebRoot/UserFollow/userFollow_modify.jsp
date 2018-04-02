<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_user_logstate.jsp"/>
<!DOCTYPE html>
<html>
<head>
<title>EditPage</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userFollow.css" />
</head>
<body style="margin:0px; font-size:14px; background-image:url(../images/bg.jpg); background-position:bottom; background-repeat:repeat;">
<div id="userFollow_editDiv">
	<form id="userFollowEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">Recordid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userFollow_followId_edit" name="userFollow.followId" value="<%=request.getParameter("followId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">Followed:</span>
			<span class="inputControl">
				<input class="textbox"  id="userFollow_userObj1_user_name_edit" name="userFollow.userObj1.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">Follower:</span>
			<span class="inputControl">
				<input class="textbox"  id="userFollow_userObj2_user_name_edit" name="userFollow.userObj2.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">FollowTime:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userFollow_followTime_edit" name="userFollow.followTime" />

			</span>

		</div>
		<div class="operation">
			<a id="userFollowModifyButton" class="easyui-linkbutton">Update</a> 
		</div>
	</form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js" ></script>
<script src="${pageContext.request.contextPath}/UserFollow/js/userFollow_modify.js"></script> 
</body>
</html>
