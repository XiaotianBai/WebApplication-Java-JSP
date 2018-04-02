<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/postInfo.css" />
<div id="postInfoAddDiv">
	<form id="postInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">PostTitle:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_pTitle" name="postInfo.pTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">PostContent:</span>
			<span class="inputControl">
				<textarea id="postInfo_content" name="postInfo.content" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">Poster:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_userObj_user_name" name="postInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">Post Time:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_addTime" name="postInfo.addTime" />

			</span>

		</div>
		<div>
			<span class="label">Views:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_hitNum" name="postInfo.hitNum" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="postInfoAddButton" class="easyui-linkbutton">Add</a>
			<a id="postInfoClearButton" class="easyui-linkbutton">Clear</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/PostInfo/js/postInfo_add.js"></script> 
