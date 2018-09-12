<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<%@include file="/../../../common/easyui.jspf"%>
<body class="easyui-layout" style="height:800px; width: 100%;">

	<div id="dlg1" class="easyui-dialog" closed="true" title="考核成绩录入"
		data-options="iconCls:'icon-save'" style="width: 380px; height: 350px">
		<div id="addWrap">
			<form action="" method="post" id="addform">
				<table>
					<tr>
						<td>id:</td>
						<td><input type="text" id="id" /></td>
					</tr>
					<tr>
						<td>user_id:</td>
						<td><input type="text" id="user_id" /></td>
					</tr>
					<tr>
						<td>course_id:</td>
						<td><input type="text" id="course_id" /></td>
					</tr>
					<tr>
						<td>grade:</td>
						<td><input type="text" id="grade" /></td>
					</tr>
					<tr>
						<td>usual_grade:</td>
						<td><input type="text" id="usual_grade" /></td>
					</tr>
					<tr>
						<td>final_grade:</td>
						<td><input type="text" id="final_grade" /></td>
					</tr>
					<tr>
						<td>remark:</td>
					</tr>
					<tr>
						<td colspan=2><textarea rows="5" cols="38" id="remark"
								form="addform" style="resize: none"></textarea></td>
					</tr>
				</table>
				<input type="reset" value="submit" id="submitbt" />
			</form>
		</div>
	</div>
	<div id="dlg2" class="easyui-dialog" closed="true" title="成绩变更"
		data-options="iconCls:'icon-save'" style="width: 380px; height: 350px">
		<div id="addWrap">
			<form action="" method="post" id="addform">
				<table>
					<tr>
						<td>id:</td>
						<td id="td2-1"></td>
					</tr>
					<tr>
						<td>user_id:</td>
						<td id="td2-2">
						<td></td>
					</tr>
					<tr>
						<td>course_id:</td>
						<td id="td2-3"></td>
					</tr>
					<tr>
						<td>grade:</td>
						<td><input type="text" id="gradeupdate" /></td>
					</tr>
					<tr>
						<td>usual_grade:</td>
						<td><input type="text" id="usual_gradeupdate" /></td>
					</tr>
					<tr>
						<td>final_grade:</td>
						<td><input type="text" id="final_gradeupdate" /></td>
					</tr>
					<tr>
						<td>remark:</td>
					</tr>
					<tr>
						<td colspan=2><textarea rows="5" cols="38" id="remarkupdate"
								form="addform" style="resize: none"></textarea></td>
					</tr>
				</table>
				<input type="reset" value="保存修改" id="submitupd" /> <input
					type="reset" value="删除成绩" id="submitdel" />
			</form>
		</div>
	</div>
	<div id="dlg3" class="easyui-dialog" closed="true" title="录入考生成绩（文件形式）"
		data-options="iconCls:'icon-save'" style="width: 380px; height: 350px">
		<div id="addWrap">
			<form id="gradeUploadFile" action="#" method="post"
				class="form-horizontal" enctype="multipart/form-data">
				<div title="上传文件" style="width: 400px; padding: 30px 70px 50px 70px">
					<input type="file" name="gradedoc" id="gradedoc" class="uploadfile" />
					<br> <input type="submit" value="上传" id="uploadsubmit">
				</div>
			</form>
		</div>
	</div>

	<div id="mm" style="width: 150px;">
		<div id="weiji1">一般违纪</div>
		<div id="weiji2">严重违纪</div>
		<!-- <div>特别严重违纪</div> -->
	</div>

	<!--<div id="mm1" style="width: 150px;">
		<div>1</div>
		<div>2</div>
		<div>3</div>
	</div>-->

	<div style="width: 1200px; height: 400px">
		<!--<table id="dg" style="width:1000px;height:600px"></table>-->
		<table id="dg" title="成绩管理" class="easyui-datagrid" fitColumns="true"
			pagination="true" singleSelect="true"
			url="${pageContext.request.contextPath}/grade/gradeSearch"
			toolbar="#tb" style="width: 1200px; height: 400px">
			<thead>
				<tr>
					<th field="cb" checkbox="true" align="center"></th>
					<th field="id" width="90" align="center">成绩id</th>
					<th field="name" width="90" align="center">考生姓名</th>
					<th field="course_name" width="90" align="center">课程名称</th>
					<th field="grade" width="90" align="center">考试分数</th>
					<th field="usual_grade" width="90" align="center">平时分数</th>
					<th field="final_grade" width="90" align="center">最终分数</th>
					<th field="remark" width="200" align="center">备注</th>
				</tr>
			</thead>
		</table>
		<div id="tb">
			<div>
				<!-- <a href="" class="easyui-menubutton"
					data-options="menu:'#mm1',iconCls:'icon-add'" plain="true">查询成绩</a>-->
				<a href="javascript:loadGrade()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true">考核成绩录入</a> 
				<a href="javascript:insertGrade()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true">考核成绩添加</a> 
				<a href="javascript:errorGrade()" class="easyui-linkbutton" 
				    iconCls="icon-edit" plain="true">报错成绩核查</a>
				<a href="" class="easyui-menubutton"
					data-options="menu:'#mm',iconCls:'icon-remove'" plain="true">违纪作弊处理</a>
				<a href="javascript:updateGrade()" class="easyui-linkbutton"
					iconCls="icon-reload" plain="true">成绩修改/删除</a>
				<a href="javascript:noticeGrade_open()" class="easyui-linkbutton"
					iconCls="icon-ok" plain="true">发布成绩</a>
				<a href="javascript:noticeGrade_off()" class="easyui-linkbutton"
					iconCls="icon-cancel" plain="true">取消发布</a>
				<a href="javascript:reloadGrade()" class="easyui-linkbutton"
					iconCls="icon-reload" plain="true">刷新</a>
			</div>
		</div>

	</div>

</body>
<script>
	var url;

	function loadGrade() {
		$('#dlg3').dialog('open');
	}
	
	function noticeGrade_open() {
    	var con;
    	con=confirm("发布成绩后学生将能够查询成绩，确认发布成绩吗");
    	if(con ==false ){
    		return;
    	}
		$.ajax({
			type : "post",
			datatype : "json",
			url : "${pageContext.request.contextPath}/grade/gradeNotice_open",
			success : function() {
				//console.log(result);
				alert("成绩发布成功");
			}
		})
    	
	}
	
	function noticeGrade_off() {
    	var con;
    	con=confirm("取消发布后后学生将不能够查询成绩，确认取消发布吗");
    	if(con ==false ){
    		return;
    	}
		$.ajax({
			type : "post",
			datatype : "json",
			url : "${pageContext.request.contextPath}/grade/gradeNotice_off",
			success : function() {
				//console.log(result);
				alert("取消成功");
			}
		})
    	
	}

	function insertGrade() {
		$('#dlg1').dialog('open');
		

	}

	function errorGrade() {
		$("#dg").datagrid("load",{
            key:"key"

        });
        return false;
	}
	
	function reloadGrade(){
		$("#dg").datagrid("reload");
	}

	function updateGrade() {

		var row = $('#dg').datagrid('getSelected');
		if(row.user_name==""){
			
		}else{
			$('#dlg2').dialog('open');
		}
		var id = row.id;
		var user_name = row.user_name;
		var course_name = row.course_name;
		var grade = row.grade;
		var usual_grade = row.usual_grade;
		var final_grade = row.final_grade;
		var remark = row.remark;
		$('#td2-1').html(row.id);
		$('#td2-2').html(row.name);
		$('#td2-3').html(row.course_name);
		$('#submitdel').click(function() {
			$('#dlg2').dialog('close');
			$.ajax({
				url : "${pageContext.request.contextPath}/grade/gradeDelete",
				data : {
					id : id
				},
				type : "POST",
				success : function() {
					if(result.toString()=="success"){
						alert("删除成功");
						$("#dg").datagrid("reload");
						
					}else{
						alert("删除失败");
					}
					
				}

			})
		});
		$('#submitupd').click(function() {
			$('#dlg2').dialog('close');
			$.ajax({
				type : "post",
				datatype : "json",
				url : "${pageContext.request.contextPath}/grade/gradeUpdate",
				data : {
					id : id,
					name : name,
					course_name : course_name,
					grade : $("#gradeupdate").val(),
					usual_grade : $("#usual_gradeupdate").val(),
					final_grade : $("#final_gradeupdate").val(),
					remark : $("#remarkupdate").val()
				},
				success : function() {
					if(result.toString()=="success"){
						alert("修改成功");
						$("#dg").datagrid("reload");
						
					}else{
						alert("修改失败");
					}
				}

			})
		});
	}
</script>
<script>
	$(function() {
		$('#submitbt').click(function() {
			$('#dlg1').dialog('close');
			$.ajax({
				type : "post",
				datatype : "json",
				url : "${pageContext.request.contextPath}/grade/gradeInsert",
				data : {
					id : $("#id").val(),
					user_id : $("#user_id").val(),
					course_id : $("#course_id").val(),
					grade : $("#grade").val(),
					usual_grade : $("#usual_grade").val(),
					final_grade : $("#final_grade").val(),
					remark : $("#remark").val()
				},
				success : function(result) {
					if(result.toString()=="success"){
						alert("添加成功");
						$("#dg").datagrid("reload");
						
					}else{
						alert("添加失败");
					}
				}

			});
		});

		function load() {
			$('#dlg1').dialog('close');
			$("#dg").datagrid("reload");

		}

		$('#weiji1')
				.click(
						function() {
							//alert("0000000");
							var row = $('#dg').datagrid('getSelected');
							var id = row.id;
							var name = row.name;
							var course_name = row.course_name;
							var grade = row.grade;
							var usual_grade = row.usual_grade;
							var final_grade = row.final_grade;
							var remark = row.remark;
							if (remark.toString() == "一般违纪") {
								alert("已存在该违纪记录！");
							} else {
								$
										.ajax({
											url : "${pageContext.request.contextPath}/grade/gradeUsualViolate",
											data : {
												id : id,
												name : name,
												course_name : course_name,
												grade : grade,
												usual_grade : usual_grade,
												final_grade : final_grade,
												remark : remark
											},
											type : "POST",
											datatype : "json",
											success : function(result) {
												if(result.toString()=="success"){
													alert("修改成功");
													$("#dg").datagrid("reload");
													
												}else{
													alert("修改失败");
												}
											}
										});
							}

						});

		$('#weiji2')
				.click(
						function() {
							//alert("0000001");
							var row = $('#dg').datagrid('getSelected');
							var id = row.id;
							var name = row.name;
							var course_name = row.course_name;
							var grade = row.grade;
							var usual_grade = row.usual_grade;
							var final_grade = row.final_grade;
							var remark = row.remark;
							if (remark.toString() == "严重违纪") {
								alert("已存在该违纪记录！");
							} else {
								$
										.ajax({
											url : "${pageContext.request.contextPath}/grade/gradeSeriousViolate",
											data : {
												id : id,
											    name : name,
												course_name : course_name,
												grade : grade,
												usual_grade : usual_grade,
												final_grade : final_grade,
												remark : remark
											},
											type : "POST",
											datatype : "json",
											success : function(result) {
												if(result.toString()=="success"){
													alert("修改成功");
													$("#dg").datagrid("reload");
													
												}else{
													alert("修改失败");
												}
											}
										});
							}
						});
	});
</script>
<script>
	$(function() {
		$('#uploadsubmit')
				.click(
						function() {
							$('#dlg3').dialog('close');
							var file = $("#gradedoc")[0].files[0];
							var formData = new FormData();
							formData.append('filegradedoc', file);
							var ajaxUrl = "${pageContext.request.contextPath}/grade/gradeUpload";
							$.ajax({
								type : "POST",
								//dataType: "text",
								url : ajaxUrl,
								data : formData,
								async : false,
								cache : false,
								contentType : false,
								processData : false,
								success : function(data) {
									alert(data);
									$("#dg").datagrid("reload");
								},
								error : function(data) {
									alert("error:" + data.responseText);
								}
							});

						});
	});
</script>
</html>