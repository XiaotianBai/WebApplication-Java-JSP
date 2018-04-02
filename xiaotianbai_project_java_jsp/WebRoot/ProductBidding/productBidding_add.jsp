<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productBidding.css" />
<div id="productBiddingAddDiv">
	<form id="productBiddingAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">BiddingItem:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_itemObj_itemId" name="productBidding.itemObj.itemId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">BiddingUser:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_userObj_user_name" name="productBidding.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">BiddingTime:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_biddingTime" name="productBidding.biddingTime" />

			</span>

		</div>
		<div>
			<span class="label">BiddingPrice:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_biddingPrice" name="productBidding.biddingPrice" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="productBiddingAddButton" class="easyui-linkbutton">Add</a>
			<a id="productBiddingClearButton" class="easyui-linkbutton">Clear</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ProductBidding/js/productBidding_add.js"></script> 
