<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap-theme.min.css">
<script src="${pageContext.request.contextPath}/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap3/js/bootstrap.min.js"></script>
<script src="https://cdn.bootcss.com/holder/2.9.4/holder.min.js"></script>

<title>欢迎来到四川省自学考试业务管理系统</title>
<style>
		    #Main{
		    	position: absolute;
		        top:20%;
		        left:20%;
		        width:60%;
		        height:50%;
		        border: 10px solid #449D44;
		        background: #5BC0DE;
		    }
		</style>
	</head>
</head>
<body background="${pageContext.request.contextPath}/static/img/bg1.jpg">
		<h1 class="page-header" style="text-align: center;">自学考试系统</h1>
		<div id="Main">
			<div class="col-lg-6">
				<img src="${pageContext.request.contextPath}/static/img/bd53a486ba9213ee56bbe8f567d3d984_t017e187410face3e14.jpg" 
					style="width: 100%;height:100%;overflow:hidden"></img>
			</div>
			<div class="col-lg-6" id="denglu">
			<h2 class="page-header">用户登录/login</h2>
			<form action="login" method="post" class="form-horizontal">
				<div class="form-group">
                    <span class="glyphicon glyphicon-user col-sm-1"></span>
                    <div class="col-sm-7">
                        <input type="text" name="name" class="form-control" id="user_name" placeholder="请输入用户名">
                    </div>
                    <div class="col-sm-4">
                        <span id="nametishi" style="display: none;color: #CC2222;">姓名不能为空！</span>
                    </div>
                </div>
                
                <div class="form-group">
                    <span class="glyphicon glyphicon-briefcase col-sm-1"></span>
                    <div class="col-sm-7">
                        <input type="password" name="password" class="form-control" id="user_password" placeholder="请输入密码">
                    </div>
                    <div class="col-sm-4">
                        <span id="passwdtishi" style="display: none;color: #CC2222;">密码不能为空！</span>
                    </div>
                </div>
                
                <div class="form-group">
                    <span class="col-sm-1"></span>
                    <!--<div class="col-sm-3">
                        <input type="text" class="form-control" placeholder="23054">
                    </div>
                    <div class="col-sm-4">
                        <input type="text" name="yanzhengma" class="form-control" id="yanzhengma" placeholder="请输入验证码">
                    </div> -->
                    <div class="col-sm-11">
                        <div>
                            <img src="${pageContext.request.contextPath}/kaptcha-image" id="kaptchaImage" onclick="this.src='${pageContext.request.contextPath}/kaptcha-image?time='+new Date().getTime()"/></td><td>
                            <input class="col-sm-4" style="height:40px;" type="text" name="code" id="code" />
                        </div>
                   </div>
                </div>
                
                <div class="col-lg-12">
                    <button type="submit" id="Submit" class="btn btn-primary col-sm-4">登录</button>
                    <p class="col-sm-1"></p>
                    <button type="reset" class="btn  btn-success col-sm-4">重置</button>
                    <p class="col-sm-3"></p>
                </div>   
                <div>
                <div class="radio radio-inline">
                    <label>
                        <input type="radio" name="optionsRadios" id="optionsRadios1" 
                         value="option1" checked>考生
                    </label>
                </div>
                <div class="radio radio-inline">
                    <label>
                        <input type="radio" name="optionsRadios" id="optionsRadios2" 
                         value="option1" checked>老师
                    </label>
                </div>
                <div class="radio radio-inline">
                    <label>
                        <input type="radio" name="optionsRadios" id="optionsRadios3" 
                        value="option2">内部人员
                    </label>
                </div>
                <br />
                <div class="col-md-12">
                <a class="col-md-6" href="javascript:javascript:loadRegistered()">还未注册？立即注册>></a>
                <!-- <a class="col-md-6" href="studentlogin">考生登录>></a> -->
                </div></div>
		    </form>
		    <div>${msg}</div>
		    </div>
		</div>
		<div class="modal fade" id="dlg00" tabindex="-1" role="dialog" aria-labelledby="dlg00Label">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">注册</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="txt_departmentname">帐号</label>
                        <input type="text" name="txt_departmentname" class="form-control" id="username" placeholder="帐号">
                    </div>
                    <div class="form-group">
                        <label for="txt_parentdepartment">密码</label>
                        <input type="password" name="txt_parentdepartment" class="form-control" id="userpassword" placeholder="密码">
                    </div>
                    <div class="form-group">
                        <label for="txt_departmentlevel">确认密码</label>
                        <input type="password" name="txt_departmentlevel" class="form-control" id="userpassword2" placeholder="确认密码">
                    </div>
                    <div class="form-group">
                        <label for="txt_departmentlevel">姓名</label>
                        <input type="text" name="txt_departmentlevel" class="form-control" id="userrealname" placeholder="姓名">
                    </div>
                    <div class="form-group">
                        <label for="txt_departmentlevel">手机</label>
                        <input type="text" name="txt_departmentlevel" class="form-control" id="userphone" placeholder="手机">
                    </div>
                    <div class="form-group">
                        <label for="txt_departmentlevel">email</label>
                        <input type="email" name="txt_departmentlevel" class="form-control" id="usermail" placeholder="email">
                    </div>
    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove" aria-hidden="true">
                    </span>关闭</button>
                    
                    <button type="button" id="btn_submit" class="btn btn-primary" data-dismiss="modal">
                    <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true">
                    </span>注册</button>
                </div>
            </div>
        </div>
    </div>
	</body>
	<script>
	$('#Submit').click(function(){
		if($('#user_name').val()==""){
			$('#nametishi').show();
			if($('#user_password').val()==""){
				$('#passwdtishi').show();
			}
			return false;
		}else if($('#user_password').val()==""){
			$('#passwdtishi').show();
			if($('#user_name').val()==""){
				$('#nametishi').show();
			}
			return false;
		}
		})
	$('#user_name').blur(function(){
		if($('#user_name').val()!=""){
			$('#nametishi').hide();
		}
		
	})
	
	$('#user_password').blur(function(){
		if($('#user_password').val()!=""){
			$('#passwdtishi').hide();
		}
		
	})
	function loadRegistered(){
		//$('#dlg00').dialog('open');
		$('#dlg00').modal();
	}
	$(function() {
	    $('#btn_submit').click(function() {   
	    	if($("#username").val()=="")
    		{
	    		alert('请输入帐号');
	    		return false;
    		}
	    	if($("#userpassword").val()=="")
    		{
	    		alert('请输入密码');
	    		return false;
    		}
	    	if($("#userpassword2").val()=="")
    		{
	    		alert('请输入确认密码');
	    		return false;
    		}
	    	if($("#userpassword").val()!=$("#userpassword2").val())
	    	{
	    		alert('输入的两次密码不一致！');
	    		return false;
	    	}
	    	if($("#userrealname").val()=="")
    		{
	    		alert('请输入姓名');
	    		return false;
    		}
	    	var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
	    	if(!myreg.test($("#userphone").val()))
	    	{
	    		alert('请输入有效的手机号码！');
	    		return false;
	    	}
	        if($("#usermail").val()=="")
    		{
	    		alert('请输入邮箱');
	    		return false;
    		}
	        var email = $("#usermail").val();
            var regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            if(!regEmail.test(email)) {
                    alert("邮箱格式不正确");
                    return false;
            }
	        $.ajax({
	    	    type : "get",
	    	    url : "${pageContext.request.contextPath}/user/userRegister",
	    	    data:{
	    	    	name:$("#username").val(),
	    	    	password:$("#userpassword").val(),
	    	    	phone:$("#userphone").val(),
	    	    	mail:$("#usermail").val(),
	    	    	wholename:$("#userrealname").val()
	    	    },
	    	    success : function(data) {
	    	    	alert(data.msg);
	    	    	$('#dlg00').modal('hide')
	    	    },
	    	    error: function(data) {
	                alert("error:"+data.msg);
	             }
	    	});
	        return false;
	    });
	});
	</script>
</html>