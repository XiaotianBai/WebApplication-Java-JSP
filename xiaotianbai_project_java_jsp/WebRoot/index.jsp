<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%> <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en-US">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <title>xb306_project_index</title>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
</head>
<body> 
<div class="container">

<jsp:include page="header.jsp"></jsp:include>

 <!--picture slide widget-->
    <section id="main_ad" class="carousel slide" data-ride="carousel">

    <div class="carousel-inner" role="listbox">
            <div class="item active" data-image-lg="<%=basePath %>images/slider/slide_01_2000x410.jpg" data-image-xs="<%=basePath %>images/slider/slide_01_640x340.jpg"></div>
            
  
        </div>
        <!-- control -->
    <a class="left carousel-control" href="#main_ad" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">prev</span>
        </a>
        <a class="right carousel-control" href="#main_ad" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">next</span>
        </a>
    </section>
    <!-- over -->



<jsp:include page="footer.jsp"></jsp:include>

</div>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>js/index.js"></script>
</body>
</html>
