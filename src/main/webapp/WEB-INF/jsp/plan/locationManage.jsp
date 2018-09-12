<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%-- <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> --%>
<!DOCTYPE html>
<style type="text/css">
.style_button {
    background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 9px 16px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 10px;
    margin: 4px 2px;
    cursor: pointer;
    -webkit-transition-duration: 0.4s; /* Safari */
    transition-duration: 0.4s;
}

.button2:hover {
    box-shadow: 0 6px 12px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
}

#BgDiv{
	background-color:#e3e3e3; 
	position:absolute; z-index:99; left:0; top:0; 
	display:none; 
	width:100%; height:1000px;
	opacity:0.5;
	filter: alpha(opacity=50);
	-moz-opacity: 0.5;
}
</style>

<html>
<%@include file="/../../../common/easyui.jspf"%>
<body class="easyui-layout" style="height:800px; width: 100%;">

	<div id="dlg1" class="easyui-dialog" closed="true" title="添加考点" data-options="iconCls:'icon-save'" style="width:380px;height:350px">
		<div id="addWrap">
			<form action="" method="post" id="addLocationForm">
		        <table>
		        	<tr><td>所在城市:</td>
		        	    <td><!-- <input type="text" id="in_citycode" maxlength="2" oninput = "value=value.replace(/[^\d]/g,'')"/> -->
		        	    <input id="city" class="easyui-combobox" style="width:200px"></input>
		        	    </td></tr>
		        	<tr><td>所在区/县:</td>
		        	    <td><!--  <input type="text" id="in_districtcode" maxlength="2" oninput = "value=value.replace(/[^\d]/g,'')"/> -->
		        	    <input id="district" class="easyui-combobox" style="width:200px"></input>
		        	    </td></tr>
		        	<tr><td>考点具体地址:</td><td><input type="text" id="in_location" maxlength="20" style="width:200px"/></td></tr>
		        	<tr><td>考场容纳人数规格：</td>
		        		<td> <select id="capacity" class="easyui-combobox">
		        				<option value="25">25人</option>
		        				<option value="30">30人</option>
		        			</select></td></tr>
		        	<tr></tr>
		        </table>
		        <div align="center"><input class="style_button button2" type="button" width="120" value="添加" id="submitbtn" onclick="insertExamLocation()"/></div>
			</form>
		</div>
	</div>
	
	<div id="dlg2" class="easyui-dialog" closed="true" title="添加/修改考点开考专业" data-options="iconCls:'icon-save'" style="width:380px;height:350px">
		<div id="addWrap">
			<form action="" method="post" id="addMajorForm">
		        <table>
		        	<tr><td>考点代号:</td>
		        	    <td><input type="text" id="examlocation_code" disabled="true" style="width:200px"></input></td></tr>
		        	<tr><td>考点地址:</td>
		        	    <td> <input type="text" id="examlocation_address" disabled="true" style="width:200px"></input> </td></tr>
		        	<tr><td>选择开考专业:</td>
		        	    <td><input id="examlocation_major" class="easyui-combobox" style="width:200px"></input></td></tr>
		        	<tr></tr>
		        </table>
		        <div align="center"> <input class="style_button button2" type="button" width="120" value="添加" id="submitbtn2" onclick="addLocationMajor()"/></div>
		        <input type="text" id="examlocation_id" hidden="true"/>
			</form>
		</div>
	</div>
	
	<div id="dlg3" class="easyui-dialog" closed="true" title="导入考场"
		data-options="iconCls:'icon-save'" style="width: 420px; height: 350px">
		<div id="addWrap">
			<form action="" method="post" class="form-horizontal" enctype="multipart/form-data">
			 <!-- action="../examClassroom/classroomUpload" -->
				<table>
					<tr><td>考点地址：</td>
						<td><input type="text" id="classroom_address" disabled="true" style="width:200px"/></td></tr>
					<tr><td>考点代码：</td>
						<td><input type="text" id="classroom_locationcode" disabled="true" style="width:200px"/></td></tr>
					<tr><td>考场规格（人）：</td>
						<td><input type="text" id="classroom_capacity" disabled="true" style="width:200px"/></td></tr>
					<tr><td>上传文件：</td>
						<td><input type="file" id="classroom_uploadedFile" accept=".xls,.xlsx"/></td></tr>
				</table>
				<input type="text" id="classroom_locationid" hidden="true"/>
				<br>
				<div align="center"><input class="style_button button2" type="button" value="上传" onclick="importExamClassroom()"></div>
																							<!-- onclick="$('#dlg3').dialog('close')" -->
			</form>
		</div>
	</div>
	
	<div id="mainDiv"
		style=" width: 1200px; height: 400px">
		<!--<table id="dg" style="width:1000px;height:600px"></table>-->
		<table id="dg" title="考点管理" class="easyui-datagrid" fitColumns="true"
			pagination="true" singleSelect="true"
			url="${pageContext.request.contextPath}/examLocation/listExamLocation"
			toolbar="#tb" style="width: 1200px; height: 400px">
			<thead>
				<tr>
					<th field="cb" checkbox="true" align="center"></th>
					<th field="id" align="center" hidden="true">考点ID</th>
					<!-- <th field="city_name" width="100" align="center">考点所在城市</th> -->
					<!-- <th field="district_name" width="100" align="center">考点所在区/县</th> -->
					<th field="code" width="70" align="center">考点代号</th>
					<!-- <th field="citycode" width="100" align="center">所在城市代号</th> -->
					<!-- <th field="districtcode" width="100" align="center">所在区/县代号</th> -->
					<th field="location" width="180" align="center">具体地址</th>
					<th field="location_status" width="60" align="center">考点状态</th>
					<th field="majorid" width="80" align="center" hidden="true">专业ID</th>
					<th field="name" width="100" align="center">考点开考专业</th>
					<th field="capacity" width="60" align="center">考场规格(人)</th>
					<th field="totalcapacity" width="100" align="center">考点容纳量</th>					
				</tr>
			</thead>
		</table>
		<div id="tb">
			<div>
			     <shiro:hasPermission name="examloaction:add">
				    <a href="javascript:showInsertExamLocation()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true">添加考点</a></shiro:hasPermission>
				 <shiro:hasPermission name="examloaction:start">
					 <a href="javascript:startExamLocation()" class="easyui-linkbutton"
					iconCls="icon-edit" plain="true">启动考点</a></shiro:hasPermission>
			     <shiro:hasPermission name="examloaction:stop">
					 <a href="javascript:stopExamLocation()" class="easyui-linkbutton"
					iconCls="icon-remove" plain="true">停用考点</a> </shiro:hasPermission>
				 <shiro:hasPermission name="majorlocation:add/update">	
					<a href="javascript:showAddLocationMajor()" class="easyui-linkbutton"
					iconCls="icon-edit" plain="true"> 添加/修改考点开考专业</a></shiro:hasPermission>
				 <shiro:hasPermission name="majorlocation:delete">
					 <a href="javascript:delLocationMajor()" class="easyui-linkbutton"
					iconCls="icon-edit" plain="true">删除考点开考专业</a></shiro:hasPermission>
				 <shiro:hasPermission name="classroom:add">
					 <a href="javascript:showImportExamClassroom()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true">添加考场</a>
	
					<a href="javascript:reloadExamLocation()" class="easyui-linkbutton"
					iconCls="icon-reload" plain="true">刷新</a>
			</div>
		</div>
	</div>
</body>
<script>
	//定义全局url 用于下面与后台的操作。
	var url;
	function showInsertExamLocation(){
		$('#city').combobox('clear');
		$('#district').combobox('clear');
		$('#in_location').val("");
		$('#capacity').combobox('clear');
		$('#dlg1').dialog('open');
		//document.getElementById("mainDiv").style.display="none";//visibility = "hidden";
		//$('#BgDiv').css({ display: "block", height: $(document).height() });
	}
	
	function insertExamLocation(){
		if($('#in_location').val()==""){
			alert("详细地址不能为空!");
			return;
		}
		
		//var citycode=$('#in_citycode').val();
		var citycode=$('#city').combobox('getValue');
		if(citycode==""){
			alert("城市不能为空!");
			return;
		}
		var location=$('#city').combobox('getText');
	
		//var districtcode=$('#in_districtcode').val();
		var districtcode=$('#district').combobox('getValue');
		if(districtcode==""){
			alert("区/县不能为空!");
			return;
		}
		location+=$('#district').combobox('getText');
		location+=$('#in_location').val();
		
		var capacity=$('#capacity').combobox('getValue');
		if(capacity==null || capacity==""){
			alert("请选择考场容纳人数规格！");
			return ;
		}
		//alert(capacity);
		
		$.ajax({
 			url : "${pageContext.request.contextPath}/examLocation/insertExamLocation",
 			dataType: "json",
 			data : {location:location, citycode:citycode, districtcode:districtcode, capacity:capacity},
 			type : "POST",
 		});
		
		
		$('#dlg1').dialog('close');
		
		alert("新增考点成功。");
		$("#dg").datagrid("reload");
	}
	
	function startExamLocation(){
		var row=$("#dg").datagrid("getSelected");
		if(row==null){
			alert("请选择一个考点！");
			return ;
		}
		var id=row.id;
 		var status = row.location_status;
 		
 		if(status.toString() =="启用"){
 			alert("本考点已经启用！");
 		}
 		else{
 		$.ajax({
 			url : "${pageContext.request.contextPath}/examLocation/startExamLocation",
 			data : {id :id},
 			type : "POST",
 		});
 		alert("成功启用考点。");
 		$("#dg").datagrid("reload");
 		}
	}
	
	function stopExamLocation(){
		var row=$("#dg").datagrid("getSelected");
		if(row==null){
			alert("请选择一个考点！");
			return ;
		}
		if(row.majorid!=null ){
			alert("该考点尚有开考专业，不能停用该考点！");
			return ;
		}
		var id=row.id;
 		var status = row.location_status;
 		
 		if(status.toString() =="停用"){
 			alert("本考点已经停用！");
 		}
 		else{
 		$.ajax({
 			url : "${pageContext.request.contextPath}/examLocation/stopExamLocation",
 			data : {id :id},
 			type : "POST",
 		});
 		alert("成功停用考点。");
 		$("#dg").datagrid("reload");
 		}
	}
	
	function reloadExamLocation(){
		$("#dg").datagrid("reload");
	}
	
	function showAddLocationMajor(){
 		/* $('#examlocation_code').val("");
		$('#examlocation_address').val("");
		$('#examlocation_id').val("");
		$('#examlocation_major').combobox('clear');
		 */
		var row=$("#dg").datagrid("getSelected");
		if(row==null){
			alert("请选择一个考点！");
			return ;
		}
		if(row.location_status.toString()=="停用"){
			alert("考点尚未启用，不能添加开考专业！");
			return ;
		}
		$('#examlocation_code').val(row.code);
		$('#examlocation_address').val(row.location);
		$('#examlocation_id').val(row.id);
		$('#examlocation_major').combobox({
			url:"${pageContext.request.contextPath}/major/listNoLocation", 
	        editable:false, 
	        cache: false,
	        panelHeight: '150',
	        valueField:'id',   
	        textField:'name'
		});
		$('#dlg2').dialog('open');
	}
	
	function addLocationMajor(){
		var majorid=$('#examlocation_major').combobox('getValue');
		if(majorid==null){
			alert("请选择开考专业！");
			return ;
		}
		//alert(majorid);
		//var row=$("#dg").datagrid("getSelected");
		//var id=$('#examlocation_id').val();
		var id=$('#examlocation_id').val();//row.id;
		
		$.ajax({
 			url : "${pageContext.request.contextPath}/examLocation/addLocationMajor",
 			dataType: "json",
 			data : {id :id, majorid:majorid},
 			type : "POST",
 		});
		
		alert("成功修改考点开考的专业。");
		
		$('#dlg2').dialog('close');
 		$("#dg").datagrid("reload");
 	}
	
	function delLocationMajor(){
		var row=$("#dg").datagrid("getSelected");
		if(row==null){
			alert("请先选择一个考点！");
			return ;
		}
		if(row.majorid!=null){
			alert("该考点尚有开考专业，不能停用！");
			return ;
		}
		var id=row.id;
		$.ajax({
 			url : "${pageContext.request.contextPath}/examLocation/delLocationMajor",
 			data : {id :id},
 			type : "POST",
 		});
		alert("成功删除考点开考的专业。");
 		$("#dg").datagrid("reload");
	}
	
	function showImportExamClassroom(){
		var row=$("#dg").datagrid("getSelected");
		if(row==null){
			alert("请选择一个考点！");
			return ;
		}
		if(row.location_status.toString()=="启用"){
			alert("该考点已启用，勿修改考场！");
			return ;
		}
		$('#classroom_address').val(row.location);
		$('#classroom_capacity').val(row.capacity);
		$('#classroom_locationcode').val(row.code);
		$('#classroom_locationid').val(row.id);
		document.getElementById('classroom_uploadedFile').value='';
		$('#dlg3').dialog('open');
	}
	
	function importExamClassroom(){
		var formData = new FormData();
        formData.append("file", document.getElementById("classroom_uploadedFile").files[0]);
		var id=$('#classroom_locationid').val();
		formData.append("id",id);
		$.ajax({
			 url: "${pageContext.request.contextPath}/examClassroom/classroomUpload",
             type: "POST",
             data: formData,
             cache: false,
             // 必须false才会自动加上正确的Content-Type
             contentType: false,
             // 必须false才会避开jQuery对 formdata 的默认处理
             // XMLHttpRequest会对 formdata 进行正确的处理
             processData: false,
             async:false,//同步
             
             success: function (data) {
                 if (data>0) {
                     alert("上传成功！成功添加了 "+data+" 个考场。");
                     
                  $.ajax({
             			url:"${pageContext.request.contextPath}/examLocation/updateTotolCapacity",
             			type:"post",
             			data:{id:id},
             			async:false,//同步
             			/* success:function(data){
             				alert("成功更新考点容量");
             			} */
             		});
                 }
                 else if (data==-1) {
                     alert("文件为空，请确认后再次上传！");
                 }
                 else if(data==-2){
                	 alert("文件格式有误！请确认文件格式后再次上传！");
                 }
                 else if(data==-3){
                	 alert("上传的考场与已有的考场重复！请确认并修改后再次上传！");
                 }
                 else if(data=-4){
                	 alert("文件内容的格式有误！请参照标准内容格式修改后再次上传！");
                 }
                 else {
                	 alert("文件处理错误！");
                 }
             },
             error: function (XMLHttpRequest, textStatus, errorThrown) {
                 alert("错误！status:"+XMLHttpRequest.status);
                 alert("错误！state:"+XMLHttpRequest.readyState);
                 alert("错误！"+textStatus);
             }
		});
		
		$("#dg").datagrid("reload");
		document.getElementById('classroom_uploadedFile').value='';
		$('#dlg3').dialog('close');
	}
	
	
	$(function(){
		/* $('#capacity').combobox({
			editable:false, 
	        cache: false,
	        panelHeight: '150',
	        valueField:'capacity_int',   
	        textField:'capacity_str',
		});
		 */
		$('#city').combobox({
			url:"${pageContext.request.contextPath}/city/loadCity", 
	        editable:false, 
	        cache: false,
	        panelHeight: '150',
	        valueField:'citycode',   
	        textField:'city_name',
	        
	        onSelect: function(){
			        $("#district").combobox('clear');
			        var citycode = $('#city').combobox('getValue');	
			        //alert(citycode);
			        $('#district').combobox('reload','${pageContext.request.contextPath}/district/loadDistrict?citycode='+citycode);
			      	//alert(id);
		      	
		      /* $.ajax({
		        type: "POST",
		        url: "${pageContext.request.contextPath}/district/loadDistrict?citycode="=citycode,
		        cache: false,
		        //data:{citycode:citycode},
		        dataType : "json",
		        success: function(data){
		        				$("#district").combobox("loadData",data);
		                 }
		      }); 	 */
		     }
		});
		
		$('#district').combobox({ 
		      //url:'itemManage!categorytbl', 
		      editable:false, //不可编辑状态
		      cache: false,
		      panelHeight: '150',//自动高度适合
		      valueField:'districtcode',   
		      textField:'district_name'
		     });

	});
</script>
</html>
</html>