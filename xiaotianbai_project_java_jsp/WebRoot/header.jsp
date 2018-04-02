<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%> <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <!--button and logo-->
        <div class="navbar-header">
            <button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="<%=basePath %>index.jsp" class="navbar-brand">bidding system</a>
        </div>
        <!--nav button and logo-->
        <!--navbar-->
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-left">
                <li><a href="<%=basePath %>index.jsp">index</a></li>
                <!--  
                 <li><a href="<%=basePath %>UserInfo/frontlist">userinfo</a></li>
                <li><a href="<%=basePath %>ItemClass/frontlist">itemclass</a></li>-->
                <li><a href="<%=basePath %>Item/frontlist?itemClassObj.classId=1">Books</a></li>
                <li><a href="<%=basePath %>Item/frontlist?itemClassObj.classId=2">Toys</a></li>
                <li><a href="<%=basePath %>Item/frontlist?itemClassObj.classId=3">Clothes</a></li>
                <li><a href="<%=basePath %>Item/frontlist?itemClassObj.classId=4">Electronics</a></li>
                <li><a href="<%=basePath %>Item/frontlist?itemClassObj.classId=5">Furniture</a></li>
                 <li><a href="<%=basePath %>PostInfo/frontlist">Forum</a></li>
                <!-- 
                <li><a href="<%=basePath %>ProductBidding/frontlist">order</a></li> 
                 
                <li><a href="<%=basePath %>Reply/frontlist">reply</a></li>
                <li><a href="<%=basePath %>UserFollow/frontlist">follow</a></li> -->
 
            </ul>
            
             <ul class="nav navbar-nav navbar-right">
             	<%
				  	String user_name = (String)session.getAttribute("user_name");
				    if(user_name==null){
	  			%> 
	  			<li><a href="<%=basePath %>UserInfo/userInfo_frontAdd.jsp"><i class="fa fa-sign-in"></i>&nbsp;&nbsp;SignUp</a></li>
                <li><a href="#" onclick="login();"><i class="fa fa-user"></i>&nbsp;&nbsp;SignIn</a></li>
                
                <% } else { %>
                <li class="dropdown">
                    <a id="dLabel" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <%=session.getAttribute("user_name") %>
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="dLabel"> 
                        <li><a href="<%=basePath %>Item/item_frontUserAdd.jsp"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Post Item</a></li>
                        <li><a href="<%=basePath %>Item/userFrontlist"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;My Items</a></li>
                        <li><a href="<%=basePath %>ProductBidding/userFrontlist"><span class="glyphicon glyphicon-screenshot"></span>&nbsp;&nbsp;My Biddings</a></li>
                        <li><a href="<%=basePath %>PostInfo/userFrontlist"><span class="glyphicon glyphicon-cog"></span>&nbsp;&nbsp;My Posts</a></li>
                        <li><a href="<%=basePath %>UserFollow/userFrontlist"><span class="glyphicon glyphicon-heart"></span>&nbsp;&nbsp;My Follow List</a></li>
                        <li><a href="<%=basePath %>UserInfo/userInfo_frontModify.jsp?user_name=<%=session.getAttribute("user_name") %>"><span class="glyphicon glyphicon-credit-card"></span>&nbsp;&nbsp;Edit Profile</a></li>
                        
                    </ul>
                </li>
                <li><a href="<%=basePath %>logout.jsp"><span class="glyphicon glyphicon-off"></span>&nbsp;&nbsp;Exit</a></li>
                <% } %> 
            </ul>
            
        </div>
        <!--导航--> 
    </div>
</nav>
<!--导航结束--> 


<div id="loginDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-key"></i>&nbsp;Login System</h4>
      </div>
      <div class="modal-body">
      	<form class="form-horizontal" name="loginForm" id="loginForm" enctype="multipart/form-data" method="post"  class="mar_t15">
      	  
      	  <div class="form-group">
			 <label for="userName" class="col-md-3 text-right">Username</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="userName" name="userName" class="form-control" placeholder="Input Username">
			 </div>
		  </div> 
		  
      	  <div class="form-group">
		  	 <label for="password" class="col-md-3 text-right">Password</label>
		  	 <div class="col-md-9">
			    <input type="password" id="password" name="password" class="form-control" placeholder="Password">
			 </div>
		  </div> 
		  
		</form> 
	    <style>#bookTypeAddForm .form-group {margin-bottom:10px;}  </style>
      </div>
      <div class="modal-footer"> 
		<button type="button" class="btn btn-default" data-dismiss="modal">close</button>
		<button type="button" class="btn btn-primary" onclick="ajaxLogin();">login</button> 
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->




 
<div id="registerDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-sign-in"></i>&nbsp;UserReg</h4>
      </div>
      <div class="modal-body">
      	<form class="form-horizontal" name="registerForm" id="registerForm" enctype="multipart/form-data" method="post"  class="mar_t15">
      	  
      	   
		  
		</form> 
	    <style>#bookTypeAddForm .form-group {margin-bottom:10px;}  </style>
      </div>
      <div class="modal-footer"> 
		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		<button type="button" class="btn btn-primary" onclick="ajaxRegister();">Reg</button> 
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->






<script>

function register() {
	$("#registerDialog input").val("");
	$("#registerDialog textarea").val("");
	$('#registerDialog').modal('show');
}
function ajaxRegister() {
	$("#registerForm").data('bootstrapValidator').validate();
	if(!$("#registerForm").data('bootstrapValidator').isValid()){
		return;
	}

	jQuery.ajax({
		type : "post" , 
		url : basePath + "UserInfo/add",
		dataType : "json" , 
		data: new FormData($("#registerForm")[0]),
		success : function(obj) { 
			if(obj.success){ 
                alert("RegSuccessful！");
                $("#registerForm").find("input").val("");
                $("#registerForm").find("textarea").val("");
            }else{
                alert(obj.message);
            }
		},
		processData: false,  
	    contentType: false, 
	});
}


function login() {
	$("#loginDialog input").val("");
	$('#loginDialog').modal('show');
}
function ajaxLogin() {
	$.ajax({
		url : "<%=basePath%>frontLogin",
		type : 'post',
		dataType: "json",
		data : {
			"userName" : $('#userName').val(),
			"password" : $('#password').val(),
		}, 
		success : function (obj, response, status) {
			if (obj.success) {
				
				location.href = "<%=basePath%>index.jsp";
			} else {
				alert(obj.msg);
			}
		}
	});
}


</script> 
