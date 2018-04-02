<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.ProductBidding" %>
<%@ page import="com.xiaotianbaiproject.po.Item" %>
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<ProductBidding> productBiddingList = (List<ProductBidding>)request.getAttribute("productBiddingList");
    //GetAllitemObjInfo
    List<Item> itemList = (List<Item>)request.getAttribute("itemList");
    //GetAlluserObjInfo
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //Current Page
    int totalPage =   (Integer)request.getAttribute("totalPage");  //Total Pages
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //Total Records
    Item itemObj = (Item)request.getAttribute("itemObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String biddingTime = (String)request.getAttribute("biddingTime"); //BiddingTimeSearchKeyword
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>BiddingSearch</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">Index</a></li>
			    	<li role="presentation" class="active"><a href="#productBiddingListPanel" aria-controls="productBiddingListPanel" role="tab" data-toggle="tab">MyBidding</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>ProductBidding/productBidding_frontAdd.jsp" style="display:none;">AddBidding</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="productBiddingListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>No.</td><td>BiddingID</td><td>BiddingItem</td><td>BiddingTime</td><td>BiddingPrice</td><td>Operations</td></tr>
				    					<% 
				    						/*Get StartIndex.*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*Traverse Records*/
				    	            		for(int i=0;i<productBiddingList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //Current Index.
					    	            		ProductBidding productBidding = productBiddingList.get(i); //Get到BiddingObj
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=productBidding.getBiddingId() %></td>
 											<td><a href="<%=basePath %>Item/<%=productBidding.getItemObj().getItemId() %>/frontshow"><%=productBidding.getItemObj().getPTitle() %></a></td>
 											<td><%=productBidding.getBiddingTime() %></td>
 											<td><%=productBidding.getBiddingPrice() %></td>
 											<td>
 												<a href="<%=basePath  %>ProductBidding/<%=productBidding.getBiddingId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;Inspect</a>&nbsp;
 												<a href="#" onclick="productBiddingEdit('<%=productBidding.getBiddingId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>Edit</a>&nbsp;
 												<a href="#" onclick="productBiddingDelete('<%=productBidding.getBiddingId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>Delete</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >Records: <%=recordNumber %>，Page: <%=currentPage %>/<%=totalPage %> </div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>BiddingSearch</h1>
		</div>
		<form name="productBiddingQueryForm" id="productBiddingQueryForm" action="<%=basePath %>ProductBidding/userFrontlist" class="mar_t15">
            <div class="form-group">
            	<label for="itemObj_itemId">BiddingItem：</label>
                <select id="itemObj_itemId" name="itemObj.itemId" class="form-control">
                	<option value="0">No limits</option>
	 				<%
	 				for(Item itemTemp:itemList) {
	 					String selected = "";
 					if(itemObj!=null && itemObj.getItemId()!=null && itemObj.getItemId().intValue()==itemTemp.getItemId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=itemTemp.getItemId() %>" <%=selected %>><%=itemTemp.getPTitle() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group"  style="display:none;">
            	<label for="userObj_user_name">BiddingUser：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">No limits</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="biddingTime">BiddingTime:</label>
				<input type="text" id="biddingTime" name="biddingTime" class="form-control"  placeholder="Choose BiddingTime" value="<%=biddingTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
	</div>

		</div>
	</div> 
<div id="productBiddingEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;BiddingInfoEdit</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="productBiddingEditForm" id="productBiddingEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="productBidding_biddingId_edit" class="col-md-3 text-right">BiddingID:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="productBidding_biddingId_edit" name="productBidding.biddingId" class="form-control" placeholder="Input BiddingID" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="productBidding_itemObj_itemId_edit" class="col-md-3 text-right">BiddingItem:</label>
		  	 <div class="col-md-9">
			    <select id="productBidding_itemObj_itemId_edit" name="productBidding.itemObj.itemId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="productBidding_userObj_user_name_edit" class="col-md-3 text-right">BiddingUser:</label>
		  	 <div class="col-md-9">
			    <select id="productBidding_userObj_user_name_edit" name="productBidding.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="productBidding_biddingTime_edit" class="col-md-3 text-right">BiddingTime:</label>
		  	 <div class="col-md-9">
                <div class="input-group date productBidding_biddingTime_edit col-md-12" data-link-field="productBidding_biddingTime_edit">
                    <input class="form-control" id="productBidding_biddingTime_edit" name="productBidding.biddingTime" size="16" type="text" value="" placeholder="Choose BiddingTime" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="productBidding_biddingPrice_edit" class="col-md-3 text-right">BiddingPrice:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="productBidding_biddingPrice_edit" name="productBidding.biddingPrice" class="form-control" placeholder="Input BiddingPrice">
			 </div>
		  </div>
		</form> 
	    <style>#productBiddingEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxProductBiddingModify();">Upload</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.en-US.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*JumpToSearch */
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.productBiddingQueryForm.currentPage.value = currentPage;
    document.productBiddingQueryForm.submit();
}

/*JumpTo*/
function changepage(totalPage)
{
    var pageValue=document.productBiddingQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('Exceed Maximum!');
        return ;
    }
    document.productBiddingQueryForm.currentPage.value = pageValue;
    documentproductBiddingQueryForm.submit();
}

/*弹出EditBidding界面并Initialize数据*/
function productBiddingEdit(biddingId) {
	$.ajax({
		url :  basePath + "ProductBidding/" + biddingId + "/update",
		type : "get",
		dataType: "json",
		success : function (productBidding, response, status) {
			if (productBidding) {
				$("#productBidding_biddingId_edit").val(productBidding.biddingId);
				$.ajax({
					url: basePath + "Item/listAll",
					type: "get",
					success: function(items,response,status) { 
						$("#productBidding_itemObj_itemId_edit").empty();
						var html="";
		        		$(items).each(function(i,item){
		        			html += "<option value='" + item.itemId + "'>" + item.pTitle + "</option>";
		        		});
		        		$("#productBidding_itemObj_itemId_edit").html(html);
		        		$("#productBidding_itemObj_itemId_edit").val(productBidding.itemObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#productBidding_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#productBidding_userObj_user_name_edit").html(html);
		        		$("#productBidding_userObj_user_name_edit").val(productBidding.userObjPri);
					}
				});
				$("#productBidding_biddingTime_edit").val(productBidding.biddingTime);
				$("#productBidding_biddingPrice_edit").val(productBidding.biddingPrice);
				$('#productBiddingEditDialog').modal('show');
			} else {
				alert("GetInfoFailed！");
			}
		}
	});
}

/*DeleteBiddingInfo*/
function productBiddingDelete(biddingId) {
	if(confirm("ConfirmDeleteThisRecord")) {
		$.ajax({
			type : "POST",
			url : basePath + "ProductBidding/deletes",
			data : {
				biddingIds : biddingId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("DeleteSuccessful");
					$("#productBiddingQueryForm").submit();
					//location.href= basePath + "ProductBidding/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajaxUploadBiddingInfo Edit*/
function ajaxProductBiddingModify() {
	$.ajax({
		url :  basePath + "ProductBidding/" + $("#productBidding_biddingId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#productBiddingEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("InfoEditSuccessful！");
                $("#productBiddingQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*click hide*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*BiddingTimePart*/
    $('.productBidding_biddingTime_edit').datetimepicker({
    	language:  'en-US',  //language
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

