<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="/../../../common/easyui.jspf"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>用户管理</title>
</head>
<body class="easyui-layout" style="height:100%; width: 100%;">
<div data-options="region:'center',split:true, border:false,title:'用户列表'">
    <div id="ui-toolbar">
    <br>

        <div class="ui-toolbar-search">
            <label>查询类型：</label>
            <select id="type" class="easyui-combobox" pageHeight="auto" editable="false" style="width: 150px;">
                <option value="-1">请选择查询类型</option>
                    <option value="name">用户姓名</option>
                    <option value="id">用户id</option>
                    <option value="roleName">用户类型</option>
            </select>
            <label>关键词：</label><input class="wu-text easyui-textbox" id="keywords" style="width:100px">
            <a style="position:absolute;"href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()" >开始检索</a>
        </div>
        <div class="ui-toolbar-button">
            <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="insertUser()">添加用户</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateUser()">编辑用户</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="deleteUser()">删除用户</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="reloadUser()">刷新</a>
        </div>
    </div>
    </table>
       <table id="dg" title="用户管理" class="easyui-datagrid" fitColumns="true"
			pagination="true" singleSelect="true" style="width:1100px;height:400px"
			url="${pageContext.request.contextPath}/user/userSearch"
			toolbar="#tb" >
			<thead>
				<tr>
					<th field="cb" checkbox="true" align="center"></th>
					<th field="id" width="100" align="center">用户ID</th>
					<th field="name" width="100" align="center">用户账号</th>
					<th field="password" width="100" align="center">用户密码</th>
					<th field="roleName" width="100" align="center">角色名称</th>
					<th field="startdate" width="100" align="center">创建时间</th>
					<th field="updatedate" width="200" align="center">修改时间</th>
				</tr>
			</thead>
	</table>
	
	<div id="dlg2" class="easyui-dialog" closed="true" title="添加用户信息" data-options="iconCls:'icon-save'" style="width:380px;height:350px">
		<div id="addWrap">
			<form id="addform">
		        <table>
		        	<tr><td>用户账号:</td><td><input type="text" id="uname" onkeyup="check()" class="easyui-textbox"/></td></tr>
		        	<tr><td>用户密码:</td><td><input type="text" id="upassword" class="easyui-textbox"/></td></tr>
		        	<tr><td>用户角色:</td>
		        	
		        	<td>
		        <select id="utype"   style="width: 150px;" class="easyui-combobox">
             
                <c:forEach items="${roles}" var="role">
                    <option value="${role.name}">${role.name}</option>
                </c:forEach>
                </select>
		        	</td></tr>
		        	
		        </table>
		        <input type="reset"  value="submit" id="submitbt" iconCls="icon-ok" class="easyui-linkbutton"/>
		        <div id="check" style="font-style: red"></div>
			</form>
		</div>
	</div>
	<div id="dlg3" class="easyui-dialog" closed="true" title="编辑用户信息" data-options="iconCls:'icon-save'" style="width:380px;height:350px">
		<div id="addWrap">
			<form id="addform">
		        <table>
		        	<tr><td>用户账号:</td><td><div id=name1></div></td></tr>
		        	<tr><td>用户密码:</td><td><input type="text" id="password1" /></td></tr>
		        	<tr><td>用户角色:</td>
     
        		        	
		        	<td>
		        <select id="type1" class="easyui-combobox" pageHeight="auto" editable="false" style="width: 150px; " >
                   <c:forEach items="${roles}" var="role">
                    <option value="${role.name}">${role.name}</option>
                    </c:forEach>
                </select>
		        	</td></tr>
		        	
		        </table>
		        <input type="reset"  value="submit" id="submitbt1" />
		        <div id="check1"></div>
			</form>
		</div>
	</div>	

<script>


    //定义全局url 用于下面与后台的操作。
    /**
     * 添加用户
     */
     var flag = 0;
    function insertUser() {
    
    	$('#dlg2').dialog('open');
         

    }
    function doSearch(){
        $("#dg").datagrid("load",{
            type:$("#type").combobox("getValue"),
            keywords:$("#keywords").val()
        });
        return false;
    }
    
    function updateUser(){
    	var row = $("#dg").datagrid('getSelected');
    	var id = row.id;
    	var name = row.name;
    	var password = row.password;
    	var roleName = row.roleName;
    	$('#dlg3').dialog('open');
    	$('#name1').html(name);
    	$('#password1').val(password);
    	
    	
    }
    function deleteUser(){
       	var row = $('#dg').datagrid('getSelected');
    	var id = row.id;
    	var name = row.name;
    	var con;
    	con=confirm("确认删除账号为"+name+"用户吗");
    	if(con ==false ){
    		return;
    	}

    	url = "${pageContext.request.contextPath}/user/userDelete";
    		   $.get(
    			url,
    			{
    				id:id
    			},
    		    function(data){
    				alert("成功删除该用户");
    				$("#dg").datagrid("reload");
    			}
    		   )
 
    }
    
    function check(){//检查账号是否重复

        $.ajax({
    	    type : "get",
    	    datatype : "json",
    	    url : "${pageContext.request.contextPath}/user/userCheck",
    	    data:{
    	    	name:$("#uname").val()
    	    },
    	    success : function(result) {
    	    	if(result.toString()=="fail"){
    	    	flag = 1;
    	    	$("#check").html("该用户已存在");
    	    	}
    	    	else{
    	    	flag = 0;
    	    	$("#check").html("");
    	    	
    	    	}
    	    	
    	    	
    	    }
    	});
    	
    }
    
    function check1(){//检查账号是否重复
    	var row = $("#dg").datagrid('getSelected');
        var prename = row.name;
    	var name = $("#name1").val();
    	console.log(prename!=name);
        $.ajax({
    	    type : "get",
    	    datatype : "json",
    	    url : "${pageContext.request.contextPath}/user/userCheck",
    	    data:{
    	    	name:name
    	    },
    	    success : function(result) {
    	    	if(result.toString()=="fail"){
    	    		if(prename!=name){
    	    			
    	    	flag = 1;
    	    	$("#check1").html("该用户已存在");
    	    		}
    	    		$("#check1").html("");
    	    	}
    	    	else{
    	    	flag = 0;
    	    	$("#check1").html("");
    	    	
    	    	}
    	    	
    	    	
    	    }
    	});
    	
    }

    
    function reloadUser() {
        $("#dg").datagrid("reload");
    }
	</script>
	<script>
	$(function() {
		
	    $('#submitbt').click(function() { 
	    	var name = $("#uname").val();
	    	var password = $("#upassword").val();
	    	if(name=="" || password == ""){
	    		$("#check").html("注意检查用户名和密码是否为空");
	    		return;
	    	}
	    	if(flag == 1){
	    		return;
	    	}
	    	var uname = $("#utype").combobox("getValue");
	    	$('#dlg2').dialog('close'); 
	    	
	    	
	        $.ajax({
	    	    type : "get",
	    	    datatype : "json",
	    	    url : "${pageContext.request.contextPath}/user/userInsert",
	    	    data:{
	    	    	name:name,
	    	    	password:password,
	    	    	roleName:uname
	    	    },
	    	    success : function(result) {
	    	    	console.log(result);
	    	    	$("#dg").datagrid("reload");
	    	    	$("#uname").val("");
	    	    	$("#upassord").val("");
	    	    	
	    	    }
	    	});
	    });
	});
	
	$(function() {

	    $('#submitbt1').click(function() { 
	    	var row = $("#dg").datagrid('getSelected');
	    	var id = row.id;
	    	var startdate = row.startdate;
	    	var password = $("#password1").val();
	    	if( password == null){
	    		$("#check1").html("注意密码是否为空");
	    	}
	    	$('#dlg3').dialog('close'); 
	        $.ajax({
	    	    type : "get",
	    	    datatype : "json",
	    	    url : "${pageContext.request.contextPath}/user/userUpdate",
	    	    data:{
	    	    	id:id,
	    	    	name:$("#name1").html(),
	    	    	password:$("#password1").val(),
	    	    	roleName: $("#type1").combobox("getValue"),
	    	    	startdate:startdate
	    	    },
	    	    success : function(result) {
	    	    	console.log(result);
	    	    	$("#dg").datagrid("reload");

	    	    	
	    	    }
	    	});
	    });
	});
	

	
	function load(){
		$('#dlg1').dialog('close') ;
		$("#dg").datagrid("reload");
		
	}
	</script>

</body>
</html>

