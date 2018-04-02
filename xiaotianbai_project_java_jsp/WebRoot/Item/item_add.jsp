<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/item.css" />
<div id="itemAddDiv">
	<form id="itemAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">ItemClass:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_itemClassObj_classId" name="item.itemClassObj.classId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">Item Title:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_pTitle" name="item.pTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">ItemPhoto:</span>
			<span class="inputControl">
				<input id="itemPhotoFile" name="itemPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">ItemDescription:</span>
			<span class="inputControl">
				<textarea id="item_itemDesc" name="item.itemDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">Poster:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_userObj_user_name" name="item.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">StartPrice:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_startPrice" name="item.startPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">Start Time:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_startTime" name="item.startTime" />

			</span>

		</div>
		<div>
			<span class="label">EndTime:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_endTime" name="item.endTime" />

			</span>

		</div>
		<div class="operation">
			<a id="itemAddButton" class="easyui-linkbutton">Add</a>
			<a id="itemClearButton" class="easyui-linkbutton">Clear</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Item/js/item_add.js"></script> 
