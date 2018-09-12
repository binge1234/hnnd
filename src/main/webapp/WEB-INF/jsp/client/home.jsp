<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
   <div class="col-md-3">
       <div class="panel panel-success">
           <div class="panel-heading" style="height:40px;">功能列表</div>
           <div class="panel-body" style="height:380px;">
              <ul class="nav nav-pills  nav-stacked">
              <li role="presentation"><a id="home1" href="#">学生报考</a></li>
              <li role="presentation"><a id="home2" href="#">成绩查询</a></li>
              <li role="presentation"><a id="home3" href="#">关于系统</a></li>
              </ul> 
           </div>
       </div>
   </div>
   <div class="col-md-6"">
       <div style="height: 200px;">
       <div class="panel panel-primary">
           <div class="panel-heading" style="height:40px;">综合信息</div>
           <div class="panel-body" style="height:155px;">
               <ul>
                   <li>关于第二批高等教育自学考试专业调整规范的通知</li>
                   <li>关于调整我省高等教育自学考试统考课程安排的通知</li>
                   <li>四川省高等教育自学考试18·2次2018年10月考试课表和使用教材</li>
               </ul>
           </div>
       </div>
       </div>
       <br/>
       <div style="height: 200px;">
       <div class="panel panel-primary">
           <div class="panel-heading" style="height:40px;">自考政策</div>
           <div class="panel-body" style="height:155px;">
               <ul>
                   <li>四川省高等教育招生考试委员会公告</li>
                   <li>关于做好2018年上半年自学考试实践性环节考</li>
                   <li>四川省高等教育招生考试委员会公告</li>
               </ul>
           </div>
       </div>
       </div>
   </div>
   <div class="col-md-3">
       <div class="panel panel-success">
           <div class="panel-heading" style="height:40px;">重要链接</div>
           <div class="panel-body" style="height:380px;">
              <ul class="nav nav-pills  nav-stacked">
              <li role="presentation"><a href="#">信息公示</a></li>
              <li role="presentation"><a href="#">自考说明</a></li>
              <li role="presentation"><a href="#">联系我们</a></li>
              </ul> 
           </div>
       </div>
   </div>
</body>
<script>
$('#home1').click(function() {
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
$('#home2').click(function() {
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
$('#home3').click(function() {
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