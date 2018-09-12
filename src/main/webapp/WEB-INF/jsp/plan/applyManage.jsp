<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<%@include file="/../../../common/easyui.jspf"%>
<body class="easyui-layout" style="height:800px; width: 100%;">

	<div id="dlg01" class="easyui-dialog" closed="true" title="导入报名报考数据"
		data-options="iconCls:'icon-save'" style="width: 380px; height: 350px">
		<div id="addWrap">
			<form id="applyUpload" action="#" method="post" class="form-horizontal" enctype="multipart/form-data">
				<div title="上传文件" style="width: 400px; padding: 30px 70px 50px 70px">
					<input type="file" name="doc" id="doc" class="uploadfile"/>
					<br> <input type="button" value="上传" id="uploadapplysubmit" >
				</div>
			</form>
		</div>
	</div>
	<div style="width: 1200px; height: 400px;"
	    >
		<table id="dg" title="统计" class="easyui-datagrid" fitColumns="true"
			pagination="true" singleSelect="true"  style="width: 1200px; height: 400px;"
			url="${pageContext.request.contextPath}/apply/applySearch"
			toolbar="#tb">
			<thead>
				<tr>
					<th field="cb" checkbox="true" align="center"></th>
					<th field="id" width="100" align="center">报考ID</th>
					<th field="user_id" width="100" align="center">用户ID</th>
					<th field="course_id" width="100" align="center">课程ID</th>
					<th field="exam_classroom_id" width="100" align="center">考场ID</th>
					<th field="status" width="100" align="center">报考支付状态</th>
					<th field="result" width="200" align="center">是否审核</th>
					<th field="exam_number" width="200" align="center">准考证号</th>
					<th field="seat_number" width="200" align="center">座位号</th>
				</tr>
			</thead>
		</table>
		<div id="tb">
			<div>
			
				<a href="javascript:loadApply()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true" >导入报名报考数据</a>
				<a href="javascript:checkApply()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true" >审核完成</a>
				<a href="javascript:examNumber()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true" >生成准考证号</a>
				<a href="javascript:noticeApply_open()" class="easyui-linkbutton"
					iconCls="icon-ok" plain="true">发布报考信息</a>
				<a href="javascript:noticeApply_off()" class="easyui-linkbutton"
					iconCls="icon-cancel" plain="true">取消报考</a>
				<a href="javascript:reloadApply()" class="easyui-linkbutton"
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
    function loadApply(){
    	$('#dlg01').dialog('open');
    }
    
    function noticeApply_open(){
    	var con;
    	con=confirm("发布后学生将能够开始报考，确认发布吗");
    	if(con ==false ){
    		return;
    	}
		$.ajax({
			type : "post",
			datatype : "json",
			url : "${pageContext.request.contextPath}/apply/applyNotice_open",
			success : function() {
				//console.log(result);
				alert("成绩发布成功");
			}
		})
    	    	
    }
    
    function noticeApply_close(){
    	var con;
    	con=confirm("发布后学生将不能够报考，确认取消吗");
    	if(con ==false ){
    		return;
    	}
		$.ajax({
			type : "post",
			datatype : "json",
			url : "${pageContext.request.contextPath}/apply/applyNotice_off",
			success : function() {
				//console.log(result);
				alert("报考取消成功");
			}
		})
    	    	
    }
    
    function reloadMajor() {
        $("#dg").datagrid("reload");
    }
	
	function load(){
		$('#dlg01').dialog('close') ;
		$("#dg").datagrid("reload");
		
	}
	function examNumber() {
		$.ajax({
            type: "POST",
            url:"${pageContext.request.contextPath}/apply/addExamNumber",
            success: function (data) {
				if(result.toString()=="success"){
					alert("生成成功");
					$("#dg").datagrid("reload");
					
				}else{
					alert("生成失败");
				}
            },
            error: function(data) {
                alert("error:"+data.responseText);
             }
        });
 	}
	function checkApply() {
 		var row=$("#dg").datagrid("getSelected");
 		var id=row.id;
 		var result = row.result;

 		if(result.toString() =="1"){
 			alert("该申请已审核");
 		}
 		else{
 		$.ajax({
 			url : "${pageContext.request.contextPath}/apply/checkApply",
 			data : {id :id},
 			type : "POST",
            success: function (data) {
				if(result.toString()=="success"){
					alert("申请成功");
					$("#dg").datagrid("reload");
					
				}else{
					alert("申请失败");
				}
            }
 		});

 		}
 	}
	$(function() {
	    $('#uploadapplysubmit').click(function() {    
	    	
	    	var file = $("#doc")[0].files[0];
	    	var formData = new FormData(); 
	    	var filePath = file.name;  //获取文件名
	   		var fileLx = filePath.toString().substring(filePath.toString().lastIndexOf(".")+1); //取得后缀
	    	formData.append('filedoc',file);
	        var ajaxUrl = "${pageContext.request.contextPath}/apply/applyUpload";
	        if(fileLx=="xlsx"||fileLx=="xls"){
	        	$('#dlg01').dialog('close'); 
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
		    				if(result.toString()=="success"){
		    					alert("上传成功");
		    					$("#dg").datagrid("reload");
		    					
		    				}else{
		    					alert("上传失败");
		    				}
		                }
		            ,
		            error: function(data) {
		                alert("error:"+data.responseText);
		             }
		        });
	        }else{
	        	alert("请上传.xls或.xlsx格式");
	        }
	    });
	});
	
	

</script>

</html>