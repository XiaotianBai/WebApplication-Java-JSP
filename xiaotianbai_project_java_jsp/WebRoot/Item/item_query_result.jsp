<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/item.css" /> 

<div id="item_manage"></div>
<div id="item_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="item_manage_tool.edit();">Edit</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="item_manage_tool.remove();">Delete</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="item_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="item_manage_tool.redo();">Cancel选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="item_manage_tool.exportExcel();">ExportToExcel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="itemQueryForm" method="post">
			ItemClass：<input class="textbox" type="text" id="itemClassObj_classId_query" name="itemClassObj.classId" style="width: auto"/>
			Item Title：<input type="text" class="textbox" id="pTitle" name="pTitle" style="width:110px" />
			Poster：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			Start Time：<input type="text" id="startTime" name="startTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="item_manage_tool.search();">Search</a>
		</form>	
	</div>
</div>

<div id="itemEditDiv">
	<form id="itemEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">Itemid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_itemId_edit" name="item.itemId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Item/js/item_manage.js"></script> 
