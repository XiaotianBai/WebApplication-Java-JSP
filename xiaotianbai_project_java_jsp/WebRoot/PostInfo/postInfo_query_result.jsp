<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/postInfo.css" /> 

<div id="postInfo_manage"></div>
<div id="postInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="postInfo_manage_tool.edit();">Edit</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="postInfo_manage_tool.remove();">Delete</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="postInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="postInfo_manage_tool.redo();">Cancel选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="postInfo_manage_tool.exportExcel();">ExportToExcel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="postInfoQueryForm" method="post">
			PostTitle：<input type="text" class="textbox" id="pTitle" name="pTitle" style="width:110px" />
			Poster：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			Post Time：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="postInfo_manage_tool.search();">Search</a>
		</form>	
	</div>
</div>

<div id="postInfoEditDiv">
	<form id="postInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">Postid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_postInfoId_edit" name="postInfo.postInfoId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="PostInfo/js/postInfo_manage.js"></script> 
