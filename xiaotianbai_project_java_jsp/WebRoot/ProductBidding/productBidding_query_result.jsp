<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productBidding.css" /> 

<div id="productBidding_manage"></div>
<div id="productBidding_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="productBidding_manage_tool.edit();">Edit</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="productBidding_manage_tool.remove();">Delete</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="productBidding_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="productBidding_manage_tool.redo();">Cancel选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="productBidding_manage_tool.exportExcel();">ExportToExcel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="productBiddingQueryForm" method="post">
			BiddingItem：<input class="textbox" type="text" id="itemObj_itemId_query" name="itemObj.itemId" style="width: auto"/>
			BiddingUser：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			BiddingTime：<input type="text" id="biddingTime" name="biddingTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="productBidding_manage_tool.search();">Search</a>
		</form>	
	</div>
</div>

<div id="productBiddingEditDiv">
	<form id="productBiddingEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">BiddingID:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_biddingId_edit" name="productBidding.biddingId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">BiddingItem:</span>
			<span class="inputControl">
				<input class="textbox"  id="productBidding_itemObj_itemId_edit" name="productBidding.itemObj.itemId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">BiddingUser:</span>
			<span class="inputControl">
				<input class="textbox"  id="productBidding_userObj_user_name_edit" name="productBidding.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">BiddingTime:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_biddingTime_edit" name="productBidding.biddingTime" />

			</span>

		</div>
		<div>
			<span class="label">BiddingPrice:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_biddingPrice_edit" name="productBidding.biddingPrice" style="width:80px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="ProductBidding/js/productBidding_manage.js"></script> 
