<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<%@include file="/../../../common/easyui.jspf"%>
<body class="easyui-layout" style="height:800px; width: 100%;">

	<div id="dlg1" class="easyui-dialog" closed="true" title="录入全国专业"
		data-options="iconCls:'icon-save'" style="width: 380px; height: 350px">
		<div id="addWrap">
			<form id="majorUploadFile" action="#" method="post" class="form-horizontal" enctype="multipart/form-data">
				<div title="上传文件" style="width: 400px; padding: 30px 70px 50px 70px">
					<input type="file" name="doc" id="doc" class="uploadfile"/>
					<br> <input type="button" value="上传" id="uploadsubmit" >
				</div>
			</form>
		</div>
	</div>
	<div id="dlg2" class="easyui-dialog" closed="true" title="录入专业信息" data-options="iconCls:'icon-save'" style="width:380px;height:350px">
		<div id="addWrap">
			<form action="" method="post" id="addform">
		        <table>

		        	<tr><td>major_name:</td><td><input type="text" id="majorname" /></td></tr>
		        	<tr><td>major_area:</td><td><input type="text" id="majorarea" /></td></tr>
		        	<tr><td>details:</td></tr>
		        	<tr><td colspan=2><textarea rows="5" cols="38" id="majordetail" form="addform" style="resize:none"></textarea></td></tr>
		        </table>
		        <input type="reset"  value="submit" id="submitbt" />
			</form>
		</div>
	</div>
	<div style="width: 1200px; height: 400px;"
		>
		<!--<table id="dg" style="width:1000px;height:600px"></table>-->
		<table id="dg" title="专业管理" class="easyui-datagrid" fitColumns="true"
			pagination="true" singleSelect="true"  style="width: 1200px; height: 400px;"
			url="${pageContext.request.contextPath}/major/majorSearch"
			toolbar="#tb" >
			<thead>
				<tr>
					<th field="cb" checkbox="true" align="center"></th>
					<th field="id" width="100" align="center">专业ID</th>
					<th field="name" width="100" align="center">专业名称</th>
					<th field="status" width="100" align="center">专业状态</th>
					<th field="flag" width="100" align="center">是否删除</th>
					<th field="area" width="100" align="center">所属地区</th>
					<th field="details" width="200" align="center">专业描述</th>
				</tr>
			</thead>
		</table>
		<div id="tb">
					<div>
			    <shiro:hasPermission name="major:upload">
				<a href="javascript:loadMajor()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true" >导入全国专业</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="major:add">
				<a href="javascript:insertMajor()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true">添加专业</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="major:start">
				 <a href="javascript:startMajor()" class="easyui-linkbutton"
					iconCls="icon-edit" plain="true">启动专业</a> </shiro:hasPermission>
					<shiro:hasPermission name="major:delete">
					<a href="javascript:stopMajor()" class="easyui-linkbutton"
					iconCls="icon-remove" plain="true">删除专业</a></shiro:hasPermission>
					
					 <a href="javascript:reloadMajor()" class="easyui-linkbutton"
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
    function loadMajor(){
    	$('#dlg1').dialog('open');
    }
    /**
     * 插入专业，打开对话框，对话框的内容是空白专业信息单，并要求填写
     */
    function insertMajor() {
    	$('#dlg2').dialog('open');
    	

    }

     /**
      * 删除专业，要求必须选中一行才允许禁用，否则对用户弹出提示框
      */
    function stopMajor() {
    	var row = $('#dg').datagrid('getSelected');
    	var id = row.id;
    	url = "${pageContext.request.contextPath}/major/majorDelete";
   
    	   if(row.status.toString() =="启用" && row.flag.toString() == "否" ){
    		   $.get(
    			url,
    			{
    				id:id
    			},
    		    function(data){
    				alert("成功禁用该专业");
    				$("#dg").datagrid("reload");
    			}
    		   )
    	   }
    	   else{
    		   alert("不能删除该专业");
    	   }
    	

    }
    /**
     * 启动专业，要求必须选中一行才允许启动，否则对用户弹出提示框
     */
     function startMajor() {
 		var row=$("#dg").datagrid("getSelected");
 		var id=row.id;
 		var status = row.status;

 		if(status.toString() =="启用"){
 			alert("该专业已经启动");
 		}
 		else{
 		$.ajax({
 			url : "${pageContext.request.contextPath}/major/majorStart",
 			data : {id :id},
 			type : "POST",
 		});
 		alert("成功启动专业");
 		$("#dg").datagrid("reload");
 		}
 	}
    
    function reloadMajor() {
        $("#dg").datagrid("reload");
    }
	</script>
	<script>
	$(function() {
	    $('#submitbt').click(function() {    
	    	$('#dlg2').dialog('close');    
	        $.ajax({
	    	    type : "post",
	    	    datatype : "json",
	    	    url : "${pageContext.request.contextPath}/major/majorInsert",
	    	    data:{
	    	    	id:$("#majorid").val(),
	    	    	name:$("#majorname").val(),
	    	    	area:$("#majorarea").val(),
	    	    	details:$("#majordetail").val()
	    	    },
	    	    success : function(result) {
	    	    	console.log(result);
	    	    	$("#dg").datagrid("reload");
	    	    }
	    	});
	    });
	});
	$(function() {
	    $('#uploadsubmit').click(function() {    
	    	
	    	var file = $("#doc")[0].files[0];
	    	var formData = new FormData(); 
	    	var filePath = file.name;  //获取文件名
	   		var fileLx = filePath.toString().substring(filePath.toString().lastIndexOf(".")+1); //取得后缀
	    	formData.append('filedoc',file);
	        var ajaxUrl = "${pageContext.request.contextPath}/major/majorUpload";
	        if(fileLx=="xlsx"||fileLx=="xls"){
	        	$('#dlg1').dialog('close'); 
		        $.ajax({
		            type: "POST",
		            //dataType: "text",
		            url: ajaxUrl,
		            data: formData,
		            async: false,  
		            cache: false,  
		            contentType: false,  
		            processData: false,
		            success: function (data) {
		            	alert(data);
		            	$("#dg").datagrid("reload");
		            },
		            error: function(data) {
		                alert("error:"+data.responseText);
		             }
		        });
	        }else{
	        	alert("请上传.xls或.xlsx格式");
	        }
	        
	    });
	});
	function load(){
		$('#dlg1').dialog('close') ;
		$("#dg").datagrid("reload");
		
	}
	</script>

</html>