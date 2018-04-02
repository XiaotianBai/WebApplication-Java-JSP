<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.PostInfo" %>
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<PostInfo> postInfoList = (List<PostInfo>)request.getAttribute("postInfoList");
    //GetAlluserObjInfo
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //Current Page
    int totalPage =   (Integer)request.getAttribute("totalPage");  //Total Pages
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //Total Records
    String pTitle = (String)request.getAttribute("pTitle"); //PostTitleSearchKeyword
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String addTime = (String)request.getAttribute("addTime"); //Post TimeSearchKeyword
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>Search for Posts</title>
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
			    	<li role="presentation" class="active"><a href="#postInfoListPanel" aria-controls="postInfoListPanel" role="tab" data-toggle="tab">我PostList</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>PostInfo/postInfo_frontUserAdd.jsp">AddPost</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="postInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>No.</td><td>Postid</td><td>PostTitle</td><td>Post Time</td><td>Views</td><td>Operations</td></tr>
				    					<% 
				    						/*Get StartIndex.*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*Traverse Records*/
				    	            		for(int i=0;i<postInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //Current Index.
					    	            		PostInfo postInfo = postInfoList.get(i); //Get到PostObj
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=postInfo.getPostInfoId() %></td>
 											<td><%=postInfo.getPTitle() %></td>
 											<td><%=postInfo.getAddTime() %></td>
 											<td><%=postInfo.getHitNum() %></td>
 											<td>
 												<a href="<%=basePath  %>PostInfo/<%=postInfo.getPostInfoId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;Inspect</a>&nbsp;
 												<a href="#" onclick="postInfoEdit('<%=postInfo.getPostInfoId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>Edit</a>&nbsp;
 												<a href="#" onclick="postInfoDelete('<%=postInfo.getPostInfoId() %>');"><i class="fa fa-trash-o fa-fw"></i>Delete</a>
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
    		<h1>Search for Posts</h1>
		</div>
		<form name="postInfoQueryForm" id="postInfoQueryForm" action="<%=basePath %>PostInfo/userFrontlist" class="mar_t15">
			<div class="form-group">
				<label for="pTitle">PostTitle:</label>
				<input type="text" id="pTitle" name="pTitle" value="<%=pTitle %>" class="form-control" placeholder="Input PostTitle">
			</div>
 

            <div class="form-group" style="display:none;">
            	<label for="userObj_user_name">Poster：</label>
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
				<label for="addTime">Post Time:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="Choose Post Time" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
	</div>

		</div>
	</div> 
<div id="postInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;PostInfoEdit</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="postInfoEditForm" id="postInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="postInfo_postInfoId_edit" class="col-md-3 text-right">Postid:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="postInfo_postInfoId_edit" name="postInfo.postInfoId" class="form-control" placeholder="Input Postid" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="postInfo_pTitle_edit" class="col-md-3 text-right">PostTitle:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="postInfo_pTitle_edit" name="postInfo.pTitle" class="form-control" placeholder="Input PostTitle">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_content_edit" class="col-md-3 text-right">PostContent:</label>
		  	 <div class="col-md-9">
			    <textarea id="postInfo_content_edit" name="postInfo.content" rows="8" class="form-control" placeholder="Input PostContent"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_userObj_user_name_edit" class="col-md-3 text-right">Poster:</label>
		  	 <div class="col-md-9">
			    <select id="postInfo_userObj_user_name_edit" name="postInfo.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_addTime_edit" class="col-md-3 text-right">Post Time:</label>
		  	 <div class="col-md-9">
                <div class="input-group date postInfo_addTime_edit col-md-12" data-link-field="postInfo_addTime_edit">
                    <input class="form-control" id="postInfo_addTime_edit" name="postInfo.addTime" size="16" type="text" value="" placeholder="Choose Post Time" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="postInfo_hitNum_edit" class="col-md-3 text-right">Views:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="postInfo_hitNum_edit" name="postInfo.hitNum" class="form-control" placeholder="Input Views">
			 </div>
		  </div>
		</form> 
	    <style>#postInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxPostInfoModify();">Upload</button>
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
    document.postInfoQueryForm.currentPage.value = currentPage;
    document.postInfoQueryForm.submit();
}

/*JumpTo*/
function changepage(totalPage)
{
    var pageValue=document.postInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('Exceed Maximum!');
        return ;
    }
    document.postInfoQueryForm.currentPage.value = pageValue;
    documentpostInfoQueryForm.submit();
}

/*弹出EditPost界面并Initialize数据*/
function postInfoEdit(postInfoId) {
	$.ajax({
		url :  basePath + "PostInfo/" + postInfoId + "/update",
		type : "get",
		dataType: "json",
		success : function (postInfo, response, status) {
			if (postInfo) {
				$("#postInfo_postInfoId_edit").val(postInfo.postInfoId);
				$("#postInfo_pTitle_edit").val(postInfo.pTitle);
				$("#postInfo_content_edit").val(postInfo.content);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#postInfo_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#postInfo_userObj_user_name_edit").html(html);
		        		$("#postInfo_userObj_user_name_edit").val(postInfo.userObjPri);
					}
				});
				$("#postInfo_addTime_edit").val(postInfo.addTime);
				$("#postInfo_hitNum_edit").val(postInfo.hitNum);
				$('#postInfoEditDialog').modal('show');
			} else {
				alert("GetInfoFailed！");
			}
		}
	});
}

/*DeletePostInfo*/
function postInfoDelete(postInfoId) {
	if(confirm("ConfirmDeleteThisRecord")) {
		$.ajax({
			type : "POST",
			url : basePath + "PostInfo/deletes",
			data : {
				postInfoIds : postInfoId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("DeleteSuccessful");
					$("#postInfoQueryForm").submit();
					//location.href= basePath + "PostInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajaxUploadPostInfo Edit*/
function ajaxPostInfoModify() {
	$.ajax({
		url :  basePath + "PostInfo/" + $("#postInfo_postInfoId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#postInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("InfoEditSuccessful！");
                $("#postInfoQueryForm").submit();
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

    /*Post TimePart*/
    $('.postInfo_addTime_edit').datetimepicker({
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

