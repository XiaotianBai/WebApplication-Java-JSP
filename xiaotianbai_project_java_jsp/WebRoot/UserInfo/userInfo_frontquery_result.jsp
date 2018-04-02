<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.xiaotianbaiproject.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //Current Page
    int totalPage =   (Integer)request.getAttribute("totalPage");  //Total Pages
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //Total Records
    String paypalAccount = (String)request.getAttribute("paypalAccount"); //PayPalAccountSearchKeyword
    String user_name = (String)request.getAttribute("user_name"); //UsernameSearchKeyword
    String name = (String)request.getAttribute("name"); //NameSearchKeyword
    String birthDate = (String)request.getAttribute("birthDate"); //BirthDateSearchKeyword
    String telephone = (String)request.getAttribute("telephone"); //PhoneSearchKeyword
    String city = (String)request.getAttribute("city"); //CitySearchKeyword
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>UserSearch</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">Index</a></li>
  			<li><a href="<%=basePath %>UserInfo/frontlist">UserList</a></li>
  			<li class="active">Results</li>
  			<a class="pull-right" href="<%=basePath %>UserInfo/userInfo_frontAdd.jsp" style="display:none;">AddUser</a>
		</ul>
		<div class="row">
			<%
				/*Get StartIndex.*/
				int startIndex = (currentPage -1) * 5;
				/*Traverse Records*/
				for(int i=0;i<userInfoList.size();i++) {
            		int currentIndex = startIndex + i + 1; //Current Index.
            		UserInfo userInfo = userInfoList.get(i); //Get到UserObj
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>UserInfo/<%=userInfo.getUser_name() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=userInfo.getUserImage()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		Username:<%=userInfo.getUser_name() %>
			     	</div>
			     	<div class="field">
	            		Password:<%=userInfo.getPassword() %>
			     	</div>
			     	<div class="field">
	            		Name:<%=userInfo.getName() %>
			     	</div>
			     	<div class="field">
	            		Gender:<%=userInfo.getGender() %>
			     	</div>
			     	<div class="field">
	            		BirthDate:<%=userInfo.getBirthDate() %>
			     	</div>
			     	<div class="field">
	            		Phone:<%=userInfo.getTelephone() %>
			     	</div>
			     	<div class="field">
	            		City:<%=userInfo.getCity() %>
			     	</div>
			     	<div class="field">
	            		PayPalAccount:<%=userInfo.getPaypalAccount() %>
			     	</div>
			     	<div class="field">
	            		CreateTime:<%=userInfo.getCreateTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>UserInfo/<%=userInfo.getUser_name() %>/frontshow">Details</a>
			        <a class="btn btn-primary top5" onclick="userInfoEdit('<%=userInfo.getUser_name() %>');" style="display:none;">Edit</a>
			        <a class="btn btn-primary top5" onclick="userInfoDelete('<%=userInfo.getUser_name() %>');" style="display:none;">Delete</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>UserSearch</h1>
		</div>
		<form name="userInfoQueryForm" id="userInfoQueryForm" action="<%=basePath %>UserInfo/frontlist" class="mar_t15">
			<div class="form-group">
				<label for="paypalAccount">PayPalAccount:</label>
				<input type="text" id="paypalAccount" name="paypalAccount" value="<%=paypalAccount %>" class="form-control" placeholder="Input PayPalAccount">
			</div>
			<div class="form-group">
				<label for="user_name">Username:</label>
				<input type="text" id="user_name" name="user_name" value="<%=user_name %>" class="form-control" placeholder="Input Username">
			</div>
			<div class="form-group">
				<label for="name">Name:</label>
				<input type="text" id="name" name="name" value="<%=name %>" class="form-control" placeholder="Input Name">
			</div>
			<div class="form-group">
				<label for="birthDate">BirthDate:</label>
				<input type="text" id="birthDate" name="birthDate" class="form-control"  placeholder="Choose BirthDate" value="<%=birthDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="telephone">Phone:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="Input Phone">
			</div>
			<div class="form-group">
				<label for="city">City:</label>
				<input type="text" id="city" name="city" value="<%=city %>" class="form-control" placeholder="Input City">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
	</div>

		</div>
</div>
<div id="userInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;UserInfoEdit</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="userInfoEditForm" id="userInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="userInfo_user_name_edit" class="col-md-3 text-right">Username:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="userInfo_user_name_edit" name="userInfo.user_name" class="form-control" placeholder="Input Username" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="userInfo_password_edit" class="col-md-3 text-right">Password:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="userInfo_password_edit" name="userInfo.password" class="form-control" placeholder="Input Password">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userInfo_name_edit" class="col-md-3 text-right">Name:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="userInfo_name_edit" name="userInfo.name" class="form-control" placeholder="Input Name">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userInfo_gender_edit" class="col-md-3 text-right">Gender:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="userInfo_gender_edit" name="userInfo.gender" class="form-control" placeholder="Input Gender">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userInfo_birthDate_edit" class="col-md-3 text-right">BirthDate:</label>
		  	 <div class="col-md-9">
                <div class="input-group date userInfo_birthDate_edit col-md-12" data-link-field="userInfo_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="userInfo_birthDate_edit" name="userInfo.birthDate" size="16" type="text" value="" placeholder="Choose BirthDate" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userInfo_userImage_edit" class="col-md-3 text-right">Photo:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="userInfo_userImageImg" border="0px"/><br/>
			    <input type="hidden" id="userInfo_userImage" name="userInfo.userImage"/>
			    <input id="userImageFile" name="userImageFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userInfo_telephone_edit" class="col-md-3 text-right">Phone:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="userInfo_telephone_edit" name="userInfo.telephone" class="form-control" placeholder="Input Phone">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userInfo_city_edit" class="col-md-3 text-right">City:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="userInfo_city_edit" name="userInfo.city" class="form-control" placeholder="Input City">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userInfo_address_edit" class="col-md-3 text-right">Address:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="userInfo_address_edit" name="userInfo.address" class="form-control" placeholder="Input Address">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userInfo_email_edit" class="col-md-3 text-right">Email:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="userInfo_email_edit" name="userInfo.email" class="form-control" placeholder="Input Email">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userInfo_paypalAccount_edit" class="col-md-3 text-right">PayPalAccount:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="userInfo_paypalAccount_edit" name="userInfo.paypalAccount" class="form-control" placeholder="Input PayPalAccount">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userInfo_createTime_edit" class="col-md-3 text-right">CreateTime:</label>
		  	 <div class="col-md-9">
                <div class="input-group date userInfo_createTime_edit col-md-12" data-link-field="userInfo_createTime_edit">
                    <input class="form-control" id="userInfo_createTime_edit" name="userInfo.createTime" size="16" type="text" value="" placeholder="Choose CreateTime" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#userInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxUserInfoModify();">Upload</button>
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
    document.userInfoQueryForm.currentPage.value = currentPage;
    document.userInfoQueryForm.submit();
}

/*JumpTo*/
function changepage(totalPage)
{
    var pageValue=document.userInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('Exceed Maximum!');
        return ;
    }
    document.userInfoQueryForm.currentPage.value = pageValue;
    documentuserInfoQueryForm.submit();
}

/*弹出EditUser界面并Initialize数据*/
function userInfoEdit(user_name) {
	$.ajax({
		url :  basePath + "UserInfo/" + user_name + "/update",
		type : "get",
		dataType: "json",
		success : function (userInfo, response, status) {
			if (userInfo) {
				$("#userInfo_user_name_edit").val(userInfo.user_name);
				$("#userInfo_password_edit").val(userInfo.password);
				$("#userInfo_name_edit").val(userInfo.name);
				$("#userInfo_gender_edit").val(userInfo.gender);
				$("#userInfo_birthDate_edit").val(userInfo.birthDate);
				$("#userInfo_userImage").val(userInfo.userImage);
				$("#userInfo_userImageImg").attr("src", basePath +　userInfo.userImage);
				$("#userInfo_telephone_edit").val(userInfo.telephone);
				$("#userInfo_city_edit").val(userInfo.city);
				$("#userInfo_address_edit").val(userInfo.address);
				$("#userInfo_email_edit").val(userInfo.email);
				$("#userInfo_paypalAccount_edit").val(userInfo.paypalAccount);
				$("#userInfo_createTime_edit").val(userInfo.createTime);
				$('#userInfoEditDialog').modal('show');
			} else {
				alert("GetInfoFailed！");
			}
		}
	});
}

/*DeleteUserInfo*/
function userInfoDelete(user_name) {
	if(confirm("ConfirmDeleteThisRecord")) {
		$.ajax({
			type : "POST",
			url : basePath + "UserInfo/deletes",
			data : {
				user_names : user_name,
			},
			success : function (obj) {
				if (obj.success) {
					alert("DeleteSuccessful");
					$("#userInfoQueryForm").submit();
					//location.href= basePath + "UserInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajaxUploadUserInfo Edit*/
function ajaxUserInfoModify() {
	$.ajax({
		url :  basePath + "UserInfo/" + $("#userInfo_user_name_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#userInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("InfoEditSuccessful！");
                $("#userInfoQueryForm").submit();
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

    /*BirthDatePart*/
    $('.userInfo_birthDate_edit').datetimepicker({
    	language:  'en-US',  //language
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*CreateTimePart*/
    $('.userInfo_createTime_edit').datetimepicker({
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

