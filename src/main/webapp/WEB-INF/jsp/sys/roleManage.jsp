<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<%@include file="/../../../common/easyui.jspf"%>
<body class="easyui-layout" style="height:100%; width: 100%;">

	<div id="dlg2" class="easyui-dialog" closed="true" title="加角色" data-options="iconCls:'icon-save'" style="width:500px;height:350px">
		<div id="addWrap">
			<form action="" method="post" id="addform">
		        <table>

		        	<tr><td>角色名称:</td><td><input type="text" id="name1" /></td></tr>
		        	<tr><td>角色描述:</td><td colspan=2><textarea rows="5" cols="30" id="remark1" form="addform" style="resize:none"></textarea></td></tr>
		            
		        </table>
		        <div id="hello1">
		        
		        </div>
		       <div> <input type="reset"  value="submit" id="submitbt1" /></div>
			</form>
		</div>
	</div>
	<div id="dlg3" class="easyui-dialog" closed="true" title="修改角色" data-options="iconCls:'icon-save'" style="width:380px;height:350px">
		<div id="addWrap">
			<form action="" method="post" id="addform">
		        <table>
		        	<tr><td>角色ID:</td><td><div id="id2"></div></td></tr>
		        	<tr><td>角色名称:</td><td><div id="name2"></div></td></tr>
		        	<tr><td>角色描述:</td><td colspan=2><textarea rows="5" cols="30" id="remark2" form="addform" style="resize:none"></textarea></td> 
		        </table>
		        <div id="hello">
		        
		            </div>
		      <div>  <input type="reset"  value="submit" id="submitbt2" /></div>
			</form>
		</div>
	</div>
	<div
		>
		<!--<table id="dg" style="width:1000px;height:600px"></table>-->
		<table id="dg" title="角色管理" class="easyui-datagrid" fitColumns="true"
			pagination="true" singleSelect="true" style="width:1100px;height:400px"
			url="${pageContext.request.contextPath}/role/roleSearch"
			toolbar="#tb" >
			<thead>
				<tr>
					<th field="cb" checkbox="true" align="center"></th>
					<th field="id" width="100" align="center">角色ID</th>
					<th field="name" width="100" align="center">角色名称</th>
					<th field="remark" width="100" align="center">角色描述</th>
					<th field="startdate" width="100" align="center">创建时间</th>
					<th field="updatedate" width="100" align="center">修改时间</th>
					
				</tr>
			</thead>
		</table>
		<div id="tb">
			<div>
				<a href="javascript:insertRole()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true" >添加角色</a>
				<a href="javascript:updateRole()" class="easyui-linkbutton"
					iconCls="icon-edit" plain="true">修改角色</a> <a
					href="javascript:deleteRole()" class="easyui-linkbutton"
					iconCls="icon-remove" plain="true">删除角色</a> <a
					href="javascript:reloadMajor()" class="easyui-linkbutton"
					iconCls="icon-reload" plain="true">刷新</a>
			</div>
		</div>

	</div>
</body>
<script>

    //定义全局url 用于下面与后台的操作。
    var url;
    /**
     * 插入专业，打开对话框，对话框的内容是空白专业信息单，并要求填写
     */

    /**
     * 插入专业，打开对话框，对话框的内容是空白专业信息单，并要求填写
     */
    function insertRole() {
    	$('#dlg2').dialog('open');
    	$('#hello1').load("${pageContext.request.contextPath}/role/loadPermission1");

    }

     /**
      * 
      */
    function deleteRole() {
    	var row = $('#dg').datagrid('getSelected');
    	var id = row.id;
    	var name = row.name;
    	if(name.toString()=="未定义" || name.toString()=="超级管理员" ||name.toString()=="普通管理员"
    		|| name.toString()=="学生" || name.toString()=="老师"){
    		alert("不能删除该角色");
    		return;
    	}
    	url = "${pageContext.request.contextPath}/role/roleDelete";
    	var con;
    	con=confirm("确认删除角色"+name+"吗");
    	if(con ==false ){
    		return;
    	}            
    	  
    		   $.get(
    			url,
    			{
    				id:id
    			},
    		    function(data){
    				alert("成功删除该角色");
    				$("#dg").datagrid("reload");
    			}
    		   )
    	

    }
    /**
     * 修改角色
     */
     function updateRole(){
     	var row = $("#dg").datagrid('getSelected');
     	var id = row.id;
     	var name = row.name;
     	var remark = row.remark;
        $.ajax({
    	    type : "post",
    	    datatype : "json",
    	    url : "${pageContext.request.contextPath}/role/permSearch",
    	    data:{
    	    	id:row.id,
    	    },
    	    success : function(result) {
    	    	console.log(result);
    	    	$('#hello').load("${pageContext.request.contextPath}/role/loadPermission");
    	    	
    	    }
    	}); 
     	$('#dlg3').dialog('open');
     	$('#id2').html(id);
     	$('#name2').html(name);
     	$('#remark2').val(remark);
     	
     	
     	
     }
    function reloadRole() {
        $("#dg").datagrid("reload");
    }
	</script>
	<script>
	$(function() {
	    $('#submitbt1').click(function() {    
	    	$('#dlg2').dialog('close');    
	        $.ajax({
	    	    type : "post",
	    	    datatype : "json",
	    	    url : "${pageContext.request.contextPath}/role/roleInsert",
	    	    data:{
	    	    	name:$("#name1").val(),
	    	    	remark:$("#remark1").val(),
	    	    	
	    	    },
	    	    success : function(result) {
	    	    	console.log(result);
	    	    	$("#dg").datagrid("reload");
	    	    }
	    	});
	    });
	    
	    $('#submitbt2').click(function() {
	    	var row = $("#dg").datagrid('getSelected');
	    	var startdate=row.startdate;
	    	obj = $(".box");
	    	check_val=[];
	    	for(k in obj){
	    		if(obj[k].checked)
	    			check_val.push(parseInt(obj[k].value));
	    	}
	    	console.log(check_val);
	    	$('#dlg3').dialog('close'); 
	    	
	        $.ajax({
	    	    type : "post",
	    	    datatype : "json",
	    	    url : "${pageContext.request.contextPath}/role/roleUpdate",
	    	    data:{
	    	    	id:$("#id2").html(),
	    	    	name:$("#name2").html(),
	    	    	remark:$("#remark2").val(),
	    	    	startdate:startdate,
	    	    	permissionIds:check_val,
	    	    },
	    	    traditional: true,//这里设置为true
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

</html>