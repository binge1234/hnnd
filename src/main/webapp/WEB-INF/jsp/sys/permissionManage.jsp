<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="/../../../common/easyui.jspf"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>权限管理</title>
</head>
<body class="easyui-layout" style="height:100%; width: 100%;">
<div data-options="region:'center',split:true, border:false,title:'用户列表'">
    <div id="ui-toolbar">
    <br>

        <div class="ui-toolbar-search">
            <label>查看类型：</label>
            <select id="type" class="easyui-combobox" pageHeight="auto" editable="false" style="width: 150px;">
                <option value="-1">请选择查看类型</option>
                    <option value="name">权限名称</option>
                    <option value="remark">权限描述</option>
                    <option value="url">权限url</option>
            </select>
            <label>关键词：</label><input class="wu-text easyui-textbox" id="keywords" style="width:100px">
            <a style="position:absolute;"href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()" >开始检索</a>
        </div>
        <div class="ui-toolbar-button">
            <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="insertPermission()">添加权限</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="updatePermission()">编辑权限</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="deletePermission()">删除权限</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="reloadPermission()">刷新</a>
        </div>
    </div>
    </table>
       <table id="dg" title="权限管理" class="easyui-datagrid" fitColumns="true"
			pagination="true" singleSelect="true"  style="width:1100px;height:400px"
			url="${pageContext.request.contextPath}/permission/permSearch"
			toolbar="#tb" >
			<thead>
				<tr>
					<th field="cb" checkbox="true" align="center"></th>
					<th field="id" width="100" align="center">权限ID</th>
					<th field="name" width="100" align="center">权限名称</th>
					<th field="remark" width="100" align="center">权限描述</th>
					<th field="url" width="100" align="center">权限url</th>
					<th field="startdate" width="100" align="center">创建时间</th>
					<th field="updatedate" width="200" align="center">修改时间</th>
				</tr>
			</thead>
	</table>
	
	<div id="dlg2" class="easyui-dialog" closed="true" title="添加权限信息" data-options="iconCls:'icon-save'" style="width:380px;height:350px">
		<div id="addWrap">
			<form id="addform">
		        <table>
		        	<tr><td>权限名称:</td><td><input type="text" id="pname" /></td></tr>
		        	<tr><td>权限url:</td><td><input type="text" id="purl" /></td></tr>
		        	<tr><td>权限描述:</td>
		        	<tr><td colspan=2><textarea rows="5" cols="30" id="premark" form="addform" style="resize:none"></textarea></td></tr>
		        </table>
		        <input type="reset"  value="submit" id="submitbt" />
		        <div id="check"></div>
			</form>
		</div>
	</div>
	
	<div id="dlg3" class="easyui-dialog" closed="true" title="修改权限信息" data-options="iconCls:'icon-edit'" style="width:400px;height:350px">
		<div id="addWrap">
			<form id="addform">
		        <table>
		        	<tr><td>权限名称:</td><td><input type="text" id="name1" /></td></tr>
		        	<tr><td>权限url:</td><td><input type="text" id="url1" /></td></tr>
		        	<tr><td>权限描述:</td></tr>
		        	<tr><td colspan=2><textarea rows="5" cols="30" id="remark1" form="addform" style="resize:none"></textarea></td></tr>
  
		        	
		        </table>
		        <input type="button"  value="submit" id="submitbt1" />
		        <div id="check1"></div>
			</form>
		</div>
	</div>	

<script>

    function doSearch(){
        $("#dg").datagrid("load",{
            type:$("#type").combobox("getValue"),
            keywords:$("#keywords").val()
        });
        return false;  	
    }
    //定义全局url 用于下面与后台的操作。
    /**
     * 添加权限
     */
    function insertPermission() {
    
    	$('#dlg2').dialog('open');
       

    }
    
    function updatePermission(){
    	console.log("开始");
    	var row = $("#dg").datagrid('getSelected');
    	var id = row.id;
    	var name = row.name;
    	var remark = row.remark;
    	var url = row.url;
    	console.log("结束");
    	$('#name1').val(name);
    	$('#remark1').val(remark);
    	$('#url1').val(url);
    	console.log("测试");
    	$('#dlg3').dialog('open');
    	console.log("测试");

    	
    	
    }
    function deletePermission(){
       	var row = $('#dg').datagrid('getSelected');
    	var id = row.id;
    	var name = row.name;
    	var con;
    	con=confirm("确认删除"+name+"权限吗");
    	if(con ==false ){
    		return;
    	}

    	url = "${pageContext.request.contextPath}/permission/permDelete";
    		   $.get(
    			url,
    			{
    				id:id
    			},
    		    function(data){
    				alert("成功删除该权限");
    				$("#dg").datagrid("reload");
    			}
    		   )
 
    }
    
    function check(){//检查权限是否重复
    	
        $.ajax({
    	    type : "get",
    	    datatype : "json",
    	    url : "${pageContext.request.contextPath}/permission/permCheck",
    	    data:{
    	    	name:$("#url").val()
    	    },
    	    success : function(result) {
    	    	if(result.toString()=="fail"){
    	    	flag = 1;
    	    	$("#check").html("该权限url已被分配");
    	    	$("#check1").html("该权限url已被分配");
    	    	}
    	    	else{
    	    	flag = 0;
    	    	$("#check").html("");
    	    	$("#check1").html("");
    	    	}
    	    	
    	    	
    	    }
    	});
    	
    }

    
    function reloadPermission() {
        $("#dg").datagrid("reload");
    }
	</script>
	<script>
	$(function() {
		
	    $('#submitbt').click(function() { 
     
	    	$('#dlg2').dialog('close'); 
	        $.ajax({
	    	    type : "get",
	    	    datatype : "json",
	    	    url : "${pageContext.request.contextPath}/permission/permInsert",
	    	    data:{
	    	    	name:$("#pname").val(),
	    	    	remark:$("#premark").val(),
	    	    	url:$("#purl").val()
	    	    },
	    	    success : function(result) {
	    	    	console.log(result);
	    	    	$("#dg").datagrid("reload");

	    	    	
	    	    }
	    	});
	    });
	});
	
	$(function() {
	    $('#submitbt1').click(function() { 
	        var row = $('#dg').datagrid('getSelected');
	        var startdate = row.startdate;
	        var id = row.id;
	   
	    	$('#dlg3').dialog('close'); 
	    	
	        $.ajax({
	    	    type : "get",
	    	    datatype : "json",
	    	    url : "${pageContext.request.contextPath}/permission/permUpdate",
	    	    data:{
	    	    	id:id,
	    	    	name:$("#name1").val(),
	    	    	remark:$("#remark1").val(),
	    	    	url:$("#url1").val(),
	    	    	startdate:startdate
	    	    },
	    	    success : function(result) {
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