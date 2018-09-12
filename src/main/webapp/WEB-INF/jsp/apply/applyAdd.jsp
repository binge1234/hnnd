<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<!DOCTYPE html>
<html>
<%@include file="/../../../common/easyui.jspf"%>
<body class="easyui-layout" style="height:800px; width: 100%;">

	<div id="dlg02" class="easyui-dialog" closed="true" title="报名"
		data-options="iconCls:'icon-save'" style="width: 380px; height: 350px">
		<div id="addWrap">
			<form id="ff" method="post">
		    	<table cellpadding="5">
		    		<tr>
		    			<td>id:</td>
		    			<td><input class="easyui-textbox" type="text" id="user_id" data-options="required:true"></input></td>
		    		</tr>
		    		<tr>
		    			<td>报名课程id:</td>
		    			<td><input class="easyui-textbox" type="text" id="course_id" data-options="required:true"></input></td>
		    		</tr>
		    		<tr>
		    			<td>下拉例子:</td>
		    			<td>
		    				<select class="easyui-combobox" id="language">
		    				<option value="ar">Arabic</option>
		    				<option value="bg">Bulgarian</option>
		    				<option value="ca">Catalan</option>
		    				<option value="zh-cht">Chinese Traditional</option>
		    				<option value="en" selected="selected">English</option>
		    			</td>
		    		</tr>
		    	</table>
		    </form>
		    <div style="padding:5px">
		    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">确定</a>
		    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">重置</a>
		    </div>
		</div>
	</div>
	<div style="width: 1200px; height: 400px;">
		<div id="tb">
			<div>
				<a href="javascript:loadApply()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true" >报名</a>
					
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
    function loadApply(){
    	$('#dlg02').dialog('open');
    }
    
	
	function load(){
		$('#dlg02').dialog('close') ;
		$("#tb").datagrid("reload");
	}
	function submitForm(){
		$('#dlg02').dialog('close');    
        $.ajax({
    	    type : "post",
    	    datatype : "json",
    	    url : "${pageContext.request.contextPath}/apply/applyInsert",
    	    data:{
    	    	user_id:$("#user_id").val(),
    	    	course_id:$("#course_id").val(),
    	    },
    	    success : function(result) {
    	    	console.log(result);
    	    	$("#tb").datagrid("reload");
    	    }
    	});
	}
	function clearForm(){
		$('#ff').form('clear');
	}
	
</script>

</html>