<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.ItemClass" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<ItemClass> itemClassList = (List<ItemClass>)request.getAttribute("itemClassList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //Current Page
    int totalPage =   (Integer)request.getAttribute("totalPage");  //Total Pages
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //Total Records
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>ItemClassSearch</title>
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
		<div class="col-md-12 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">Index</a></li>
			    	<li role="presentation" class="active"><a href="#itemClassListPanel" aria-controls="itemClassListPanel" role="tab" data-toggle="tab">ItemClassList</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>ItemClass/itemClass_frontAdd.jsp" style="display:none;">AddItemClass</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="itemClassListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>No.</td><td>ItemClassid</td><td>ItemClassName</td><td>Operations</td></tr>
				    					<% 
				    						/*Get StartIndex.*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*Traverse Records*/
				    	            		for(int i=0;i<itemClassList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //Current Index.
					    	            		ItemClass itemClass = itemClassList.get(i); //Get到ItemClassObj
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=itemClass.getClassId() %></td>
 											<td><%=itemClass.getClassName() %></td>
 											<td>
 												<a href="<%=basePath  %>ItemClass/<%=itemClass.getClassId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;Inspect</a>&nbsp;
 												<a href="#" onclick="itemClassEdit('<%=itemClass.getClassId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>Edit</a>&nbsp;
 												<a href="#" onclick="itemClassDelete('<%=itemClass.getClassId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>Delete</a>
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
	</div> 
<div id="itemClassEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;ItemClassInfoEdit</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="itemClassEditForm" id="itemClassEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="itemClass_classId_edit" class="col-md-3 text-right">ItemClassid:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="itemClass_classId_edit" name="itemClass.classId" class="form-control" placeholder="Input ItemClassid" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="itemClass_className_edit" class="col-md-3 text-right">ItemClassName:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="itemClass_className_edit" name="itemClass.className" class="form-control" placeholder="Input ItemClassName">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="itemClass_classDesc_edit" class="col-md-3 text-right">Class描述:</label>
		  	 <div class="col-md-9">
			    <textarea id="itemClass_classDesc_edit" name="itemClass.classDesc" rows="8" class="form-control" placeholder="Input Class描述"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#itemClassEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxItemClassModify();">Upload</button>
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
    document.itemClassQueryForm.currentPage.value = currentPage;
    document.itemClassQueryForm.submit();
}

/*JumpTo*/
function changepage(totalPage)
{
    var pageValue=document.itemClassQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('Exceed Maximum!');
        return ;
    }
    document.itemClassQueryForm.currentPage.value = pageValue;
    documentitemClassQueryForm.submit();
}

/*弹出EditItemClass界面并Initialize数据*/
function itemClassEdit(classId) {
	$.ajax({
		url :  basePath + "ItemClass/" + classId + "/update",
		type : "get",
		dataType: "json",
		success : function (itemClass, response, status) {
			if (itemClass) {
				$("#itemClass_classId_edit").val(itemClass.classId);
				$("#itemClass_className_edit").val(itemClass.className);
				$("#itemClass_classDesc_edit").val(itemClass.classDesc);
				$('#itemClassEditDialog').modal('show');
			} else {
				alert("GetInfoFailed！");
			}
		}
	});
}

/*DeleteItemClassInfo*/
function itemClassDelete(classId) {
	if(confirm("ConfirmDeleteThisRecord")) {
		$.ajax({
			type : "POST",
			url : basePath + "ItemClass/deletes",
			data : {
				classIds : classId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("DeleteSuccessful");
					$("#itemClassQueryForm").submit();
					//location.href= basePath + "ItemClass/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajaxUploadItemClassInfo Edit*/
function ajaxItemClassModify() {
	$.ajax({
		url :  basePath + "ItemClass/" + $("#itemClass_classId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#itemClassEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("InfoEditSuccessful！");
                location.href= basePath + "ItemClass/frontlist";
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

})
</script>
</body>
</html>

