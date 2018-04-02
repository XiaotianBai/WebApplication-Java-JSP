<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userInfo.css" />
<div id="userInfoAddDiv">
	<form id="userInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">Username:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_user_name" name="userInfo.user_name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">Password:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_password" name="userInfo.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">Name:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_name" name="userInfo.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">Gender:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_gender" name="userInfo.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">BirthDate:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_birthDate" name="userInfo.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">Photo:</span>
			<span class="inputControl">
				<input id="userImageFile" name="userImageFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">Phone:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_telephone" name="userInfo.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">City:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_city" name="userInfo.city" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">Address:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_address" name="userInfo.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">Email:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_email" name="userInfo.email" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">PayPalAccount:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_paypalAccount" name="userInfo.paypalAccount" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">CreateTime:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_createTime" name="userInfo.createTime" />

			</span>

		</div>
		<div class="operation">
			<a id="userInfoAddButton" class="easyui-linkbutton">Add</a>
			<a id="userInfoClearButton" class="easyui-linkbutton">Clear</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/UserInfo/js/userInfo_add.js"></script> 
