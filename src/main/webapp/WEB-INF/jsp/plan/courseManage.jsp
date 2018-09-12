<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<!DOCTYPE html>
<html>
<%@include file="/../../../common/easyui.jspf"%>



<body class="easyui-layout" style="height:800px; width: 100%;">

	<div id="dlg1" class="easyui-dialog" closed="true" title="录入专业课程" data-options="iconCls:'icon-save'" style="width: 380px; height: 350px">
		<div id="addWrap">
			<form action="" method="post" class="form-horizontal" enctype="multipart/form-data">
				<div title="上传文件" style="width: 400px; padding: 30px 70px 50px 70px">
					<input type="file" name="doc" id="doc"/>
					<!-- <input type="file" class="easyui-filebox" name="doc" data-options="prompt:'Choose a file...'" style="width:100%"> -->
					<br> <input type="button" value="上传" id="uploadapplysubmit">
				</div>
			</form>
		</div>
	</div>
	
	<div id="dlg2" class="easyui-dialog" closed="true" title="录入课程信息" data-options="iconCls:'icon-save'" style="width:380px;height:450px">
		<div id="addWrap">
			<form action="" method="post" id="addform" autocomplete="off">
		        <table>
		        	<tr><td>course_name:</td><td><input type="text" id="course_name" /></td></tr>
		        	<tr><td>major_name:</td><td><input class="easyui-combobox" id="major_name"
						data-options="
							data:getMajorlist(),
							valueField:'name',
							textField:'name',
							panelHeight:'130',
							editable:false"></td></tr>
		        	<tr><td>book_name:</td><td><input class="easyui-combobox" id="book_name"
						data-options="
							data:getBooklist(),
							valueField:'name',
							textField:'name',
							panelHeight:'130',
							editable:false"></td></tr>
					<tr><td>type:</td><td><input class="easyui-combobox" id="type"
						data-options="
							data:data2,
							valueField:'type',
							textField:'typename',
							panelHeight:'auto',
							editable:false"></td></tr>
					<tr><td>normal_credits:</td><td><input class="easyui-numberbox" id="normal_credits"
						data-options="
							precision:1,
							min:0,
							max:30"></td></tr>
					<tr><td>free_credits:</td><td><input class="easyui-numberbox" id="free_credits"
						data-options="
							precision:1,
							min:0,
							max:30"></td></tr>
					<tr><td>free_grade:</td><td><input class="easyui-numberbox" id="free_grade"
						data-options="
							precision:1,
							min:0,
							max:100"></td></tr>
					<tr><td>grade_proportion:</td><td><input class="easyui-numberbox" id="grade_proportion"
						data-options="
							precision:1,
							max:1,
							min:0"></td></tr>
					<tr><td>cost:</td><td><input class="easyui-numberbox" id="cost"
						data-options="
							precision:2,
							min:0,
							max:999999"></td></tr>
					<tr><td>start_time:</td><td><input class="easyui-datetimebox" id="start_time"
						data-options="
							showSeconds:false,
							editable:false"></td></tr>
					<tr><td>end_time:</td><td><input class="easyui-datetimebox" id="end_time"
						data-options="
							showSeconds:false,
							editable:false"></td></tr>
					<tr><td>exam_time:</td><td><input class="easyui-datetimebox" id="exam_time"
						data-options="
							showSeconds:false,
							editable:false"></td></tr>
		        </table>
		        <input type="button"  value="submit" id="submitbt" />
			</form>
		</div>
	</div>
	
	
	<div style="width: 1200px; height: 400px;">
		<table id="dgWrap" class="easyui-datagrid" title="课程计划管理" style="width: 1200px; height: 400px;" 
			data-options="
			iconCls: 'icon-edit',
			singleSelect: true,
        	pagination: true,
        	toolbar: '#tb',
        	fitColumns: true,
        	url: 'courseSearch',
        	onClickRow: onClickRow ">
		<thead>
			<tr>
				<th data-options="field:'course_name',width:80">课程</th>
				<th data-options="field:'major_name',width:80,
					formatter: function(value,row){
                    	return row.major_name ;
                	},
                	editor:{
	                    type:'combobox',
	                    options:{
	                        valueField:'name',
	                        textField:'name',
	                        panelHeight: 130,
	                        data:getMajorlist(),
	                        required:true,
	                        editable:false
	                    }
                	}">专业</th>
				<th data-options="field:'book_name',width:80,
					formatter: function(value,row){
                    	return row.book_name ;
                	},
                	editor:{
	                    type:'combobox',
	                    options:{
	                        valueField:'name',
	                        textField:'name',
	                        panelHeight: 130,
	                        data:getBooklist(),
	                        required:true,
	                        editable:false
	                    }
                	}">教材</th>
				<th data-options="field:'normal_credits',width:80,editor:{type:'numberbox',
					options:{precision:1,min:0,max:30,required:true}}">课程统考学分</th>
				<th data-options="field:'free_credits',width:80,editor:{type:'numberbox',
					options:{precision:1,min:0,max:30,required:true}}">课程免考学分</th>
				<th data-options="field:'free_grade',width:80,editor:{type:'numberbox',
					options:{precision:1,min:0,max:100,required:true}}">课程免考成绩</th>
				<th data-options="field:'status',width:70,align:'center',
					formatter: function(value,row){
						if(row.status==0)
							return '停用';
                    	return '启用';
                	},
					editor:{
						type:'checkbox',
						options:{
							on:1,
							off:0
						}
					}">课程状态</th>	
				<th data-options="field:'type',width:70,
					formatter: function(value,row){
                    	return row.type;
                	},
                	editor:{
	                    type:'combobox',
	                    options:{
	                        valueField:'type',
	                        textField:'typename',
	                        panelHeight:'auto',
	                        data:data2,
	                        required:true,
	                        editable:false
	                    }
                	}">课程类型</th>
				<th data-options="field:'cost',width:70,editor:{type:'numberbox',
					options:{precision:2,min:0,max:999999}}">报考费用</th>
				<th data-options="field:'grade_proportion',width:70,editor:{type:'numberbox',
					options:{precision:1,max:1,min:0,required:true}}">分数占比</th>
				<th data-options="field:'start_time',width:150,align:'center',
					editor:{
						type:'datetimebox'
					}">开始报考时间</th>
				<th data-options="field:'end_time',width:150,align:'center',
					editor:{
						type:'datetimebox'
					}">结束报考时间</th>
				<th data-options="field:'exam_time',width:150,align:'center',
					editor:{
						type:'datetimebox'
					}">考试时间</th>
			</tr>
		</thead>
		</table>
    	<div id="tb" style="height:auto">
        		<a href="javascript:loadCourse()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true" >导入专业课程</a>
				<a href="javascript:insertCourse()" class="easyui-linkbutton"
					iconCls="icon-add" plain="true">添加新课程</a>
				<a href="javascript:saveCourse()" class="easyui-linkbutton"
					iconCls="icon-save" plain="true">保存</a> 
				<a href="${pageContext.request.contextPath}/course/download" class="easyui-linkbutton"
					iconCls="icon-print" plain="true">打印专业课程</a> 
				<a href="javascript:reloadCourse()" class="easyui-linkbutton"
					iconCls="icon-reload" plain="true">刷新</a>
    	</div>
	</div>

</body>

<script>

	//自定义编辑框
	$.extend($.fn.datagrid.defaults.editors, {
	    textReadonly: {
	        init: function (container, options) {
	            var input = $('<input type="text" readonly="readonly" class="datagrid-editable-input" >').appendTo(container);
	            return input;
	        },
	        getValue: function (target) {
	            return $(target).val();
	        },
	        setValue: function (target, value) {
	            $(target).val(value);
	        },
	        resize: function (target, width) {
	            var input = $(target);
	            if ($.boxModel == true) {
	                input.width(width - (input.outerWidth() - input.width()));
	            } else {
	                input.width(width);
	            }
	        }
	    }
	});
	
	//数据库调取Major数据
	var majorlist ;
	function getMajorlist(){
		$.ajax({
    	    type : "get",
    	    url : "${pageContext.request.contextPath}/course/getMajorList",
    	    async : false,
    	    success : function(result) {
    	    	majorlist = result;
    	    	for(i = 0; i < majorlist.length; i++) {
    	    	    delete majorlist[i].status;
    	    		delete majorlist[i].flag;
    	    		delete majorlist[i].area;
    	    		delete majorlist[i].details;
    	    	} 
    	    }
    	});
		//console.log(majorlist);
		return majorlist;
	}
	
	//数据库调取Book数据
	var booklist ;
	function getBooklist(){
		$.ajax({
    	    type : "get",
    	    url : "${pageContext.request.contextPath}/course/getBookList",
    	    async : false,
    	    success : function(result) {
    	    	booklist = result;
    	    	for(i = 0; i < booklist.length; i++) {
    	    		delete booklist[i].author;
    	    		delete booklist[i].house;
    	    		delete booklist[i].pdate;
    	    		delete booklist[i].price;
    	    	} 
    	    }
    	});
		//console.log(booklist);
		return booklist;
	}
	
	//自定义编辑框
	$.extend($.fn.datagrid.defaults.editors, {
	    datetimebox: {
	        init: function (container, options) {
	            var input = $('<input class="easyuidatetimebox" style="width:150px" data-options="required:true,showSeconds:false,editable:false" >').appendTo(container);
	            return input.datetimebox({
	                formatter: function (date) {
	                    return new Date(date).format("yyyy-MM-dd hh:mm");
	                }
	            });
	        },
	        getValue: function (target) {
	        	//console.log($(target).parent().find('input.combo-value').val());
	            return $(target).parent().find('input.combo-value').val();
	        },
	        setValue: function (target, value) {
	        	//console.log(value);
	            $(target).datetimebox("setValue", value);
	        },
	        resize: function (target, width) {
	            var input = $(target);
	            if ($.boxModel == true) {
	                input.width(width - (input.outerWidth() - input.width()));
	            } else {
	                input.width(width);
	            }
	        }
	    }
	});
	
	// 时间格式化
	Date.prototype.format = function (format) {
	    /*
	    * eg:format="yyyy-MM-dd hh:mm:ss";
	    */
	    if (!format) {
	        format = "yyyy-MM-dd hh:mm:ss";
	    }
	
	    var o = {
	        "M+": this.getMonth() + 1, // month
	        "d+": this.getDate(), // day
	        "h+": this.getHours(), // hour
	        "m+": this.getMinutes(), // minute
	        "s+": this.getSeconds(), // second
	        "q+": Math.floor((this.getMonth() + 3) / 3),
	        // quarter
	        "S": this.getMilliseconds()
	        // millisecond
	    };
	
	    if (/(y+)/.test(format)) {
	        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    }
	
	    for (var k in o) {
	        if (new RegExp("(" + k + ")").test(format)) {
	            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
	        }
	    }
	    return format;
	};
	
	//表格内置函数
	$(function(){
		var pg = $("#dgWrap").datagrid("getPager");  
		$("#dgWrap").datagrid("getPager").click(function(){
			endEditing();
		});
		if(pg)  
		{  
			$(pg).pagination({  
				onBeforeRefresh:function(pageNumber,pageSize){
		    	   console.log("before");
		    	   endEditing();
				}  
		   });  
		}  
	});
	
	//静态type内容
	var data2 = [
		{"type":"公共课程","typename":"公共课程"},
		{"type":"核心课程","typename":"核心课程"},
		{"type":"基础课程","typename":"基础课程"},
		{"type":"实践课程","typename":"实践课程"}
	];
	
    //定义全局url 用于下面与后台的操作。
    var url;

    function loadCourse(){
    	endEditing();
    	$('#dlg1').dialog('open');
    }

    function printCourse(){
    	
    }
    
    function insertCourse() {
    	endEditing();
    	$('#dlg2').dialog('open');
    	
    	$("#course_name").val("");
    	$('#major_name').combobox('setValue', "");
    	$('#book_name').combobox('setValue', "");
    	$('#type').combobox('setValue', "");
    	$("#normal_credits").val("");
    	$("#free_credits").val("");
    	$("#free_grade").val("");
    	$("#cost").val("");
    	$("#grade_proportion").val("");
    	$('#start_time').datebox('setValue', '');
    	$('#end_time').datebox('setValue', '');
    	$('#exam_time').datebox('setValue', '');
    }

    var editIndex = undefined;
    var savedata = new Array();
    
    //保存编辑内容
	function saveCourse() {
		endEditing();
		if(savedata.length == 0){
			return;
		}
		//console.log(JSON.stringify(savedata));
		courses = JSON.stringify(savedata);
		$.ajax({
    	    type : "post",
    	    dataType: "json",
    	    url : "${pageContext.request.contextPath}/course/saveCourseData",
    	    data: {
    	    	coursesjson: courses
    	    },
    	    success : function(result) {
    	    	console.log(result);
    	    }
    	});
		savedata.splice(0,savedata.length);
    }

    function reloadCourse() {
        $("#dgWrap").datagrid("reload");
        endEditing();
    }
    
    
	function findSame(row){
	    for(var i = 0; i < savedata.length; i++){
	        if(savedata[i].id == row.id){
	        	savedata[i] = row;
	            return false;
	        }
	    }
	    return true;
	}
    
    function endEditing(){
    	if (editIndex == undefined){return true}
    	if ($('#dgWrap').datagrid('validateRow', editIndex)){
    		
    		//console.log($("input.easyuidatetimebox:eq(0)").parent().find('input.combo-value').val());
    		//console.log($("input.easyuidatetimebox:eq(1)").parent().find('input.combo-value').val());
    		//console.log($("input.easyuidatetimebox:eq(2)").parent().find('input.combo-value').val());

            //var row = $('#dgWrap').datagrid('getSelected');
            //var sd = row.start_time.replace(/-/g, '/'), ed = row.end_time.replace(/-/g, '/');
            var st = $("input.easyuidatetimebox:eq(0)").parent().find('input.combo-value').val().replace(/-/g, '/'),
            	et = $("input.easyuidatetimebox:eq(1)").parent().find('input.combo-value').val().replace(/-/g, '/'),
            	ext = $("input.easyuidatetimebox:eq(2)").parent().find('input.combo-value').val().replace(/-/g, '/');

            if (st > et) { 
				$.messager.alert('警告','结束时间要大于开始时间','warning'); 
				return false;
			} else if(st == et){ 
				$.messager.alert('警告','开始时间不能等于结束时间','warning');
				return false;
			}
            
            if (et > ext) { 
				$.messager.alert('警告','考试时间要大于结束时间','warning'); 
				return false;
			} else if(et == ext){ 
				$.messager.alert('警告','考试时间不能等于结束时间','warning');
				return false;
			}
            
    		var ed = $('#dgWrap').datagrid('getEditor', {index:editIndex,field:'type'});
    		var typename = $(ed.target).combobox('getText');
    		$('#dgWrap').datagrid('getRows')[editIndex]['typename'] = typename;
    		
    		var majortext = $('#dgWrap').datagrid('getEditor', {index:editIndex,field:'major_name'});
    		var majorcontent = $(majortext.target).combobox('getText');
    		var row = $('#dgWrap').datagrid('getRows')[editIndex];
    		for(i = 0; i < majorlist.length; i++) {
    			if(majorlist[i].name == majorcontent){
    				row.major_id = majorlist[i].id;
    				break;
    			}
	    	} 
    		
    		var booktext = $('#dgWrap').datagrid('getEditor', {index:editIndex,field:'book_name'});
    		var bookcontent = $(booktext.target).combobox('getText');
    		for(i = 0; i < booklist.length; i++) {
    			if(booklist[i].name == bookcontent){
    				row.book_id = booklist[i].id;
    				break;
    			}
	    	}
    		
    		delete row.typename;
    		if(findSame(row)){
    			savedata.push(row);
            }
            //console.log(savedata);
    		
    		$('#dgWrap').datagrid('endEdit', editIndex);  
    		editIndex = undefined;
    		return true;
    	} else {
    		return false;
    	}
    }

    function onClickRow(index){
    	if (editIndex != index){
    		if (endEditing()){
    			$('#dgWrap').datagrid('selectRow', index).datagrid('beginEdit', index);
    			editIndex = index;
    		} else {
    			$('#dgWrap').datagrid('selectRow', editIndex);
    		}
    	}
    }
    
    
    $(function() {
	    $('#submitbt').click(function() {
	    	
	    	//$("#course_name").val("");
	    	//$('#major_name').combobox('setValue', "");
	    	
	    	//console.log($("#course_name").val());
	    	//console.log($("#major_name").combobox('getValue'));
	    	//console.log($("#book_name").combobox('getValue'));
	    	//console.log($("#type").combobox('getValue'));
	    	//console.log($("#normal_credits").val());
	    	//console.log($("#free_credits").val());
	    	//console.log($("#free_grade").val());
	    	//console.log($("#cost").val());
	    	//console.log($("#grade_proportion").val());
	    	//console.log($("#start_time").datetimebox('getValue'));
	    	//console.log($("#end_time").datetimebox('getValue'));
	    	//console.log($("#exam_time").datetimebox('getValue'));
	    	if($("#course_name").val()=='' || $("#major_name").combobox('getValue')=='' || $("#book_name").combobox('getValue')==''
	    			|| $("#type").combobox('getValue')=='' || $("#normal_credits").val()=='' || $("#free_credits").val()=='' || $("#free_grade").val()==''
	    			|| $("#cost").val()=='' || $("#grade_proportion").val()=='' || $("#start_time").datetimebox('getValue')==''
	    			|| $("#end_time").datetimebox('getValue')=='' || $("#exam_time").datetimebox('getValue')==''){
	    		alert('字段不能有空');
	    		return;
	    	}
	    	console.log('success!');
	    	$('#dlg2').dialog('close');
	    	var singleMajorid,singleBookid;
	    	for(i = 0; i < majorlist.length; i++) {
    			if(majorlist[i].name == $("#dlg2 #major_name").combobox('getValue')){
    				singleMajorid = majorlist[i].id;
    				break;
    			}
	    	}
	    	for(i = 0; i < booklist.length; i++) {
    			if(booklist[i].name == $("#dlg2 #book_name").combobox('getValue')){
    				singleBookid = booklist[i].id;
    				break;
    			}
	    	}
	        $.ajax({
	    	    type : "post",
	    	    datatype : "json",
	    	    url : "${pageContext.request.contextPath}/course/insertCourse",
	    	    data:{
	    	    	course_name: $("#dlg2 #course_name").val(),
	    	    	book_id: singleBookid,
	    	    	major_id: singleMajorid,
	    	    	normal_credits: $("#dlg2 #normal_credits").val(),
	    	    	free_credits: $("#dlg2 #free_credits").val(),
	    	    	free_grade: $("#dlg2 #free_grade").val(),
	    	    	tem_type: $("#dlg2 #type").combobox('getValue'),
	    	    	cost: $("#dlg2 #cost").val(),
	    	    	grade_proportion: $("#dlg2 #grade_proportion").val(),
	    	    	start_time: $("#dlg2 #start_time").datetimebox('getValue'),
	    	    	end_time: $("#dlg2 #end_time").datetimebox('getValue'),
	    	    	exam_time: $("#dlg2 #exam_time").datetimebox('getValue')
	    	    },
	    	    success : function(result) {
	    	    	console.log(result);
	    	    	$("#dgWrap").datagrid("reload");
	    	    }
	    	});
	        $('#addform')[0].reset();
	        reloadCourse();
	    });
	});
    
    $(function() {
	    $('#uploadapplysubmit').click(function() {    
	    	//$('#dlg1').dialog('close'); 
	    	var file = $("#doc")[0].files[0];
	    	var formData = new FormData(); 
	    	formData.append('filedoc',file);
	        var ajaxUrl = "${pageContext.request.contextPath}/course/courseUpload";
	        var filePath = file.name;  //获取文件名
	   		var fileLx = filePath.toString().substring(filePath.toString().lastIndexOf(".")+1); //取得后缀
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
		            	$("#dgWrap").datagrid("reload");
		            },
		            error: function(data) {
		                alert("error:"+data.responseText);
		             }
		        });
	   	 	}
	        else{
	        	alert("请上传.xls或.xlsx格式");
	        }
	        
	    });
	});
</script>
</html>