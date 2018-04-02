<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userInfo.css" /> 

<div id="userInfo_manage"></div>
<div id="userInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="userInfo_manage_tool.edit();">Edit</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="userInfo_manage_tool.remove();">Delete</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="userInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="userInfo_manage_tool.redo();">Cancel选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="userInfo_manage_tool.exportExcel();">ExportToExcel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="userInfoQueryForm" method="post">
			PayPalAccount：<input type="text" class="textbox" id="paypalAccount" name="paypalAccount" style="width:110px" />
			Username：<input type="text" class="textbox" id="user_name" name="user_name" style="width:110px" />
			Name：<input type="text" class="textbox" id="name" name="name" style="width:110px" />
			BirthDate：<input type="text" id="birthDate" name="birthDate" class="easyui-datebox" editable="false" style="width:100px">
			Phone：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			City：<input type="text" class="textbox" id="city" name="city" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="userInfo_manage_tool.search();">Search</a>
		</form>	
	</div>
</div>

<div id="userInfoEditDiv">
	<form id="userInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">Username:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_user_name_edit" name="userInfo.user_name" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">Password:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_password_edit" name="userInfo.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">Name:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_name_edit" name="userInfo.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">Gender:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_gender_edit" name="userInfo.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">BirthDate:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_birthDate_edit" name="userInfo.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">Photo:</span>
			<span class="inputControl">
				<img id="userInfo_userImageImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="userInfo_userImage" name="userInfo.userImage"/>
				<input id="userImageFile" name="userImageFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">Phone:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_telephone_edit" name="userInfo.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">City:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_city_edit" name="userInfo.city" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">Address:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_address_edit" name="userInfo.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">Email:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_email_edit" name="userInfo.email" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">PayPalAccount:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_paypalAccount_edit" name="userInfo.paypalAccount" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">CreateTime:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_createTime_edit" name="userInfo.createTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="UserInfo/js/userInfo_manage.js"></script> 
