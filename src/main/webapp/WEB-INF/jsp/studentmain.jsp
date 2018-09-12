<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap-theme.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap-table.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap-dialog.css">
<script
	src="${pageContext.request.contextPath}/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/bootstrap3/js/bootstrap-dialog.js"></script>
<script
	src="${pageContext.request.contextPath}/static/bootstrap3/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/bootstrap3/js/bootstrap-table.js"></script>

<script src="https://cdn.bootcss.com/holder/2.9.4/holder.min.js"></script>
<title>四川省教育考试院</title>
<style>
#Menu {
	overflow: hidden;
}
.Title{
    width:100%;
    height:100%;
    max-height: 150px; 
    min-height: 150px
}
</style>
</head>
<body background="${pageContext.request.contextPath}/static/img/bg1.jpg" onbeforeunload="window.location='${pageContext.request.contextPath}/user/logout'">
	<div class="container">
		
		<div class="row" style="width:100%;height:150px;">
			
				<div id="carouselMenu" class="carousel slide">
					<ol class="carousel-indicators">
						<li data-target="#carouselMenu" data-slide-to="0" class="active"></li>
						<li data-target="#carouselMenu" data-slide-to="1"></li>
						<li data-target="#carouselMenu" data-slide-to="2"></li>
						<li data-target="#carouselMenu" data-slide-to="3"></li>
					</ol>
					<div class="carousel-inner">
						<div class="item active">
							<img src="${pageContext.request.contextPath}/static/img/title.png" class="Title" alt="" />
						</div>
						<div class="item">
							<img src="${pageContext.request.contextPath}/static/img/title5.png" class="Title" alt="" />
						</div>
						<div class="item">
							<img src="${pageContext.request.contextPath}/static/img/title3.png" class="Title" alt="" />
						</div>
						<div class="item">
							<img src="${pageContext.request.contextPath}/static/img/title4.png" class="Title" alt="" />
						</div>
					</div>
					<a class="carousel-control left" href="#carouselMenu"
						data-slide="prev">‹</a> <a class="carousel-control right"
						href="#carouselMenu" data-slide="next">›</a>
				</div>
			
		</div>
		<div class="container" id="Menu">
			<div class="col-lg-12">
				<nav class="navbar navbar-default" style="width:100%;">
				<div class="container">
					<ul class="nav nav-pills">
						<li role="presentation" class="heng active" id="a1"><a
							href="#">主页</a></li>
						<!-- <li role="presentation" class="heng" id="a2"><a href="#">学生选课</a></li> -->
						<li role="presentation" class="heng" id="a3"><a href="#">学生报考</a></li>
						<li role="presentation" class="heng" id="a4"><a href="#">成绩查询</a></li>
						<li role="presentation" class="heng" id="a5"><a href="#">学生考籍</a></li>
						<li role="presentation" class="heng" id="a6"><a href="#">关于系统</a></li>
					</ul>
				</div>
				</nav>
			</div>
			<div class="col-lg-12" id="Body" style="background: #CCFFFF;"></div>
		</div>
	</div>
</body>
<script>
    $.ajax({ 
    url: "${pageContext.request.contextPath}/home", //地址
    async: false, 
    success: function (html) { 
        //html即是html里的内容
        //$("div#focusBar")获取div对象
        $("#Body").append(html); 
         }
    });
	$('.heng').click(function() {
		$(this).addClass("active");
		$('.heng').not(this).removeClass("active");
	});
	$('#a1').click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/home", //地址
			async : false,
			success : function(html) {
				//html即是html里的内容
				//$("div#focusBar")获取div对象
				$("#Body").html(html);
			},
			error : function() {
				alert("error!");
			}
		})
	})
	$('#a3').click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/exam/signupExam", //地址
			async : false,
			success : function(html) {
				//html即是html里的内容
				//$("div#focusBar")获取div对象
				$("#Body").html(html);
			},
			error : function() {
				alert("error!");
			}
		})
	});
	$('#a4').click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/grade/findGrade", //地址
			async : false,
			success : function(html) {
				//html即是html里的内容
				//$("div#focusBar")获取div对象
				$("#Body").html(html);
			},
		//error: function() {
		//alert("error!");
		//}
		})
	});
	$('#a5').click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/examprovice/findExamProvice", //地址
		    async : false,
			success : function(html) {
			//html即是html里的内容
			//$("div#focusBar")获取div对象
			$("#Body").html(html);
			},
			error : function() {
				alert("error!");
			}
		})
	});
	$('#a6').click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/aboutSystem", //地址
		    async : false,
			success : function(html) {
			//html即是html里的内容
			//$("div#focusBar")获取div对象
			$("#Body").html(html);
			},
			error : function() {
				alert("error!");
			}
		})
	});
</script>
</html>
