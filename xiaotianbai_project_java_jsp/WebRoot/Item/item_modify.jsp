<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_user_logstate.jsp"/>
<!DOCTYPE html>
<html>
<head>
<title>EditPage</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/item.css" />
</head>
<body style="margin:0px; font-size:14px; background-image:url(../images/bg.jpg); background-position:bottom; background-repeat:repeat;">
<div id="item_editDiv">
	<form id="itemEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">Itemid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_itemId_edit" name="item.itemId" value="<%=request.getParameter("itemId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">ItemClass:</span>
			<span class="inputControl">
				<input class="textbox"  id="item_itemClassObj_classId_edit" name="item.itemClassObj.classId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">Item Title:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_pTitle_edit" name="item.pTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">ItemPhoto:</span>
			<span class="inputControl">
				<img id="item_itemPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="item_itemPhoto" name="item.itemPhoto"/>
				<input id="itemPhotoFile" name="itemPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">ItemDescription:</span>
			<span class="inputControl">
				<textarea id="item_itemDesc_edit" name="item.itemDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">Poster:</span>
			<span class="inputControl">
				<input class="textbox"  id="item_userObj_user_name_edit" name="item.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">StartPrice:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_startPrice_edit" name="item.startPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">Start Time:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_startTime_edit" name="item.startTime" />

			</span>

		</div>
		<div>
			<span class="label">EndTime:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_endTime_edit" name="item.endTime" />

			</span>

		</div>
		<div class="operation">
			<a id="itemModifyButton" class="easyui-linkbutton">Update</a> 
		</div>
	</form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js" ></script>
<script src="${pageContext.request.contextPath}/Item/js/item_modify.js"></script> 
</body>
</html>
