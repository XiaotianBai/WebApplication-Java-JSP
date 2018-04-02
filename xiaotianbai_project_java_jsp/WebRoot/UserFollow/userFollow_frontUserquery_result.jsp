<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.UserFollow" %>
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<UserFollow> userFollowList = (List<UserFollow>)request.getAttribute("userFollowList");
    //GetAlluserObj2Info
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //Current Page
    int totalPage =   (Integer)request.getAttribute("totalPage");  //Total Pages
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //Total Records
    UserInfo userObj1 = (UserInfo)request.getAttribute("userObj1");
    UserInfo userObj2 = (UserInfo)request.getAttribute("userObj2");
    String followTime = (String)request.getAttribute("followTime"); //FollowTimeSearchKeyword
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>UserFollowerSearch</title>
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
			    	<li role="presentation" class="active"><a href="#userFollowListPanel" aria-controls="userFollowListPanel" role="tab" data-toggle="tab">MyFollowerList</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>UserFollow/userFollow_frontAdd.jsp" style="display:none;">AddUserFollower</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="userFollowListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>No.</td><td>Recordid</td><td>Followed</td><<td>FollowTime</td><td>Operations</td></tr>
				    					<% 
				    						/*Get StartIndex.*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*Traverse Records*/
				    	            		for(int i=0;i<userFollowList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //Current Index.
					    	            		UserFollow userFollow = userFollowList.get(i); //Get到UserFollowerObj
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=userFollow.getFollowId() %></td>
 											<td><a href="<%=basePath %>UserInfo/<%=userFollow.getUserObj1().getUser_name() %>/frontshow" target="_blank"><%=userFollow.getUserObj1().getName() %></a></td>
 											<td><%=userFollow.getFollowTime() %></td>
 											<td>
 												<a href="<%=basePath  %>UserFollow/<%=userFollow.getFollowId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;Inspect</a>&nbsp;
 												<a href="#" onclick="userFollowEdit('<%=userFollow.getFollowId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>Edit</a>&nbsp;
 												<a href="#" onclick="userFollowDelete('<%=userFollow.getFollowId() %>');"><i class="fa fa-trash-o fa-fw"></i>Cancel</a>
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
    		<h1>UserFollowerSearch</h1>
		</div>
		<form name="userFollowQueryForm" id="userFollowQueryForm" action="<%=basePath %>UserFollow/userFrontlist" class="mar_t15">
            <div class="form-group" style="display:none;">
            	<label for="userObj1_user_name">Followed：</label>
                <select id="userObj1_user_name" name="userObj1.user_name" class="form-control">
                	<option value="">No limits</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj1!=null && userObj1.getUser_name()!=null && userObj1.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group" style="display:none;">
            	<label for="userObj2_user_name">Follower：</label>
                <select id="userObj2_user_name" name="userObj2.user_name" class="form-control">
                	<option value="">No limits</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj2!=null && userObj2.getUser_name()!=null && userObj2.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="followTime">FollowTime:</label>
				<input type="text" id="followTime" name="followTime" class="form-control"  placeholder="Choose FollowTime" value="<%=followTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
	</div>

		</div>
	</div> 
<div id="userFollowEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;UserFollowerInfoEdit</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="userFollowEditForm" id="userFollowEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="userFollow_followId_edit" class="col-md-3 text-right">Recordid:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="userFollow_followId_edit" name="userFollow.followId" class="form-control" placeholder="Input Recordid" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="userFollow_userObj1_user_name_edit" class="col-md-3 text-right">Followed:</label>
		  	 <div class="col-md-9">
			    <select id="userFollow_userObj1_user_name_edit" name="userFollow.userObj1.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userFollow_userObj2_user_name_edit" class="col-md-3 text-right">Follower:</label>
		  	 <div class="col-md-9">
			    <select id="userFollow_userObj2_user_name_edit" name="userFollow.userObj2.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userFollow_followTime_edit" class="col-md-3 text-right">FollowTime:</label>
		  	 <div class="col-md-9">
                <div class="input-group date userFollow_followTime_edit col-md-12" data-link-field="userFollow_followTime_edit">
                    <input class="form-control" id="userFollow_followTime_edit" name="userFollow.followTime" size="16" type="text" value="" placeholder="Choose FollowTime" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#userFollowEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxUserFollowModify();">Upload</button>
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
    document.userFollowQueryForm.currentPage.value = currentPage;
    document.userFollowQueryForm.submit();
}

/*JumpTo*/
function changepage(totalPage)
{
    var pageValue=document.userFollowQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('Exceed Maximum!');
        return ;
    }
    document.userFollowQueryForm.currentPage.value = pageValue;
    documentuserFollowQueryForm.submit();
}

/*弹出EditUserFollower界面并Initialize数据*/
function userFollowEdit(followId) {
	$.ajax({
		url :  basePath + "UserFollow/" + followId + "/update",
		type : "get",
		dataType: "json",
		success : function (userFollow, response, status) {
			if (userFollow) {
				$("#userFollow_followId_edit").val(userFollow.followId);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#userFollow_userObj1_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#userFollow_userObj1_user_name_edit").html(html);
		        		$("#userFollow_userObj1_user_name_edit").val(userFollow.userObj1Pri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#userFollow_userObj2_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#userFollow_userObj2_user_name_edit").html(html);
		        		$("#userFollow_userObj2_user_name_edit").val(userFollow.userObj2Pri);
					}
				});
				$("#userFollow_followTime_edit").val(userFollow.followTime);
				$('#userFollowEditDialog').modal('show');
			} else {
				alert("GetInfoFailed！");
			}
		}
	});
}

/*DeleteUserFollowerInfo*/
function userFollowDelete(followId) {
	if(confirm("ConfirmDeleteThisRecord")) {
		$.ajax({
			type : "POST",
			url : basePath + "UserFollow/deletes",
			data : {
				followIds : followId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("DeleteSuccessful");
					$("#userFollowQueryForm").submit();
					//location.href= basePath + "UserFollow/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajaxUploadUserFollowerInfo Edit*/
function ajaxUserFollowModify() {
	$.ajax({
		url :  basePath + "UserFollow/" + $("#userFollow_followId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#userFollowEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("InfoEditSuccessful！");
                $("#userFollowQueryForm").submit();
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

    /*FollowTimePart*/
    $('.userFollow_followTime_edit').datetimepicker({
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

