<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.Reply" %>
<%@ page import="com.xiaotianbaiproject.po.PostInfo" %>
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Reply> replyList = (List<Reply>)request.getAttribute("replyList");
    //GetAllpostInfoObjInfo
    List<PostInfo> postInfoList = (List<PostInfo>)request.getAttribute("postInfoList");
    //GetAlluserObjInfo
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //Current Page
    int totalPage =   (Integer)request.getAttribute("totalPage");  //Total Pages
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //Total Records
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String replyTime = (String)request.getAttribute("replyTime"); //ReplyTimeSearchKeyword
    PostInfo postInfoObj = (PostInfo)request.getAttribute("postInfoObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>ReplySearch</title>
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
			    	<li role="presentation" class="active"><a href="#replyListPanel" aria-controls="replyListPanel" role="tab" data-toggle="tab">ReplyList</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Reply/reply_frontAdd.jsp" style="display:none;">AddReply</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="replyListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>No.</td><td>Replyid</td><td>OriginalPost</td><td>ReplyContent</td><td>Replier</td><td>ReplyTime</td><td>Operations</td></tr>
				    					<% 
				    						/*Get StartIndex.*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*Traverse Records*/
				    	            		for(int i=0;i<replyList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //Current Index.
					    	            		Reply reply = replyList.get(i); //Get到ReplyObj
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=reply.getReplyId() %></td>
 											<td><%=reply.getPostInfoObj().getPTitle() %></td>
 											<td><%=reply.getContent() %></td>
 											<td><%=reply.getUserObj().getName() %></td>
 											<td><%=reply.getReplyTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Reply/<%=reply.getReplyId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;Inspect</a>&nbsp;
 												<a href="#" onclick="replyEdit('<%=reply.getReplyId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>Edit</a>&nbsp;
 												<a href="#" onclick="replyDelete('<%=reply.getReplyId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>Delete</a>
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
    		<h1>ReplySearch</h1>
		</div>
		<form name="replyQueryForm" id="replyQueryForm" action="<%=basePath %>Reply/frontlist" class="mar_t15">
            <div class="form-group">
            	<label for="userObj_user_name">Replier：</label>
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
				<label for="replyTime">ReplyTime:</label>
				<input type="text" id="replyTime" name="replyTime" class="form-control"  placeholder="Choose ReplyTime" value="<%=replyTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <div class="form-group">
            	<label for="postInfoObj_postInfoId">OriginalPost：</label>
                <select id="postInfoObj_postInfoId" name="postInfoObj.postInfoId" class="form-control">
                	<option value="0">No limits</option>
	 				<%
	 				for(PostInfo postInfoTemp:postInfoList) {
	 					String selected = "";
 					if(postInfoObj!=null && postInfoObj.getPostInfoId()!=null && postInfoObj.getPostInfoId().intValue()==postInfoTemp.getPostInfoId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=postInfoTemp.getPostInfoId() %>" <%=selected %>><%=postInfoTemp.getPTitle() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
	</div>

		</div>
	</div> 
<div id="replyEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;ReplyInfoEdit</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="replyEditForm" id="replyEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="reply_replyId_edit" class="col-md-3 text-right">Replyid:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="reply_replyId_edit" name="reply.replyId" class="form-control" placeholder="Input Replyid" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="reply_postInfoObj_postInfoId_edit" class="col-md-3 text-right">OriginalPost:</label>
		  	 <div class="col-md-9">
			    <select id="reply_postInfoObj_postInfoId_edit" name="reply.postInfoObj.postInfoId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reply_content_edit" class="col-md-3 text-right">ReplyContent:</label>
		  	 <div class="col-md-9">
			    <textarea id="reply_content_edit" name="reply.content" rows="8" class="form-control" placeholder="Input ReplyContent"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reply_userObj_user_name_edit" class="col-md-3 text-right">Replier:</label>
		  	 <div class="col-md-9">
			    <select id="reply_userObj_user_name_edit" name="reply.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="reply_replyTime_edit" class="col-md-3 text-right">ReplyTime:</label>
		  	 <div class="col-md-9">
                <div class="input-group date reply_replyTime_edit col-md-12" data-link-field="reply_replyTime_edit">
                    <input class="form-control" id="reply_replyTime_edit" name="reply.replyTime" size="16" type="text" value="" placeholder="Choose ReplyTime" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#replyEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxReplyModify();">Upload</button>
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
    document.replyQueryForm.currentPage.value = currentPage;
    document.replyQueryForm.submit();
}

/*JumpTo*/
function changepage(totalPage)
{
    var pageValue=document.replyQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('Exceed Maximum!');
        return ;
    }
    document.replyQueryForm.currentPage.value = pageValue;
    documentreplyQueryForm.submit();
}

/*弹出EditReply界面并Initialize数据*/
function replyEdit(replyId) {
	$.ajax({
		url :  basePath + "Reply/" + replyId + "/update",
		type : "get",
		dataType: "json",
		success : function (reply, response, status) {
			if (reply) {
				$("#reply_replyId_edit").val(reply.replyId);
				$.ajax({
					url: basePath + "PostInfo/listAll",
					type: "get",
					success: function(postInfos,response,status) { 
						$("#reply_postInfoObj_postInfoId_edit").empty();
						var html="";
		        		$(postInfos).each(function(i,postInfo){
		        			html += "<option value='" + postInfo.postInfoId + "'>" + postInfo.pTitle + "</option>";
		        		});
		        		$("#reply_postInfoObj_postInfoId_edit").html(html);
		        		$("#reply_postInfoObj_postInfoId_edit").val(reply.postInfoObjPri);
					}
				});
				$("#reply_content_edit").val(reply.content);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#reply_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#reply_userObj_user_name_edit").html(html);
		        		$("#reply_userObj_user_name_edit").val(reply.userObjPri);
					}
				});
				$("#reply_replyTime_edit").val(reply.replyTime);
				$('#replyEditDialog').modal('show');
			} else {
				alert("GetInfoFailed！");
			}
		}
	});
}

/*DeleteReplyInfo*/
function replyDelete(replyId) {
	if(confirm("ConfirmDeleteThisRecord")) {
		$.ajax({
			type : "POST",
			url : basePath + "Reply/deletes",
			data : {
				replyIds : replyId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("DeleteSuccessful");
					$("#replyQueryForm").submit();
					//location.href= basePath + "Reply/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajaxUploadReplyInfo Edit*/
function ajaxReplyModify() {
	$.ajax({
		url :  basePath + "Reply/" + $("#reply_replyId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#replyEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("InfoEditSuccessful！");
                $("#replyQueryForm").submit();
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

    /*ReplyTimePart*/
    $('.reply_replyTime_edit').datetimepicker({
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

