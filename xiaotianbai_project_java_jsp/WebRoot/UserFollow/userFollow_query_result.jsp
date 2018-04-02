<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userFollow.css" /> 

<div id="userFollow_manage"></div>
<div id="userFollow_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="userFollow_manage_tool.edit();">Edit</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="userFollow_manage_tool.remove();">Delete</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="userFollow_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="userFollow_manage_tool.redo();">Cancel选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="userFollow_manage_tool.exportExcel();">ExportToExcel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="userFollowQueryForm" method="post">
			Followed：<input class="textbox" type="text" id="userObj1_user_name_query" name="userObj1.user_name" style="width: auto"/>
			Follower：<input class="textbox" type="text" id="userObj2_user_name_query" name="userObj2.user_name" style="width: auto"/>
			FollowTime：<input type="text" id="followTime" name="followTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="userFollow_manage_tool.search();">Search</a>
		</form>	
	</div>
</div>

<div id="userFollowEditDiv">
	<form id="userFollowEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">Recordid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userFollow_followId_edit" name="userFollow.followId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="UserFollow/js/userFollow_manage.js"></script> 
