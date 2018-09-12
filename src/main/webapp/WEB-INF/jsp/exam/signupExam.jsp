<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.hnnd.entity.User" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.5/themes/default/easyui.css" type="text/css"></link>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>
<title></title>
</head>
<body>
	<h1 class="page-header">课程报考</h1>
	<div>
		<table class="table"></table>
	</div>
	<div class="modal fade" id="dlg00" tabindex="-1" role="dialog" aria-labelledby="dlg00Label" >
		<div class="modal-dialog" role="document">
	            <div class="modal-content" style="width:400px;height:400px">
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	                    <h4 class="modal-title" id="myModalLabel">选择考点</h4>
	                </div>
	                
	                <div id="dlg1" class="easyui-dialog" title="选择考点" data-options="iconCls:'icon-save'" style="width:380px;height:250px;padding:10px">
						<div id="addWrap">
							<form action="" method="post" id="addLocationForm" >
						        <table style="border-collapse:separate; border-spacing:10px;">
						        	<tr>
						        		<td>所在城市：</td>
						        	    <td>
						        	    	<input id="city" class="easyui-combobox" style="width:200px"></input>
						        	    </td>
						        	</tr>
						        	<tr>
						        		<td>所在区/县：</td>
						        	    <td>
						        	    	<input id="district" class="easyui-combobox" style="width:200px"></input>
						        	    </td>
						        	</tr>
						        </table>
							</form>
						</div>
					</div>
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-default" data-dismiss="modal">
	                    <span class="glyphicon glyphicon-remove" aria-hidden="true">
	                    </span>关闭</button>
	                    
	                    <button type="button" id="btn_submit" class="btn btn-primary" data-dismiss="modal" onclick="insertSignup()">
	                    <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true">
	                    </span>提交</button>
	                </div>
	            </div>
	        </div>
        </div>
</body>
<script>
	window.operateEvents={
		"click #signbtn":function(e,value,row,index){
			courseid=row.id;
			$('#dlg00').modal();
		}
	}
	$(function() {
		$('#city').combobox({
			url:"${pageContext.request.contextPath}/city/loadCity", 
	        editable:false, 
	        cache: false,
	        panelHeight: '150',
	        valueField:'citycode',   
	        textField:'city_name',
	        
	        onSelect: function(){
			        $("#district").combobox('clear');//清空课程
			        var citycode = $('#city').combobox('getValue');	
			        //alert(citycode);
			        $('#district').combobox('reload','${pageContext.request.contextPath}/district/loadDistrict?citycode='+citycode);
			      	//alert(id);

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
		
		$('.table').bootstrapTable({
			 url: '${pageContext.request.contextPath}/apply/courseSearch',                      //请求后台的URL（*）
             method: 'POST',                      //请求方式（*）
             //toolbar: '#toolbar',              //工具按钮用哪个容器
             striped: true,                      //是否显示行间隔色
             cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
             pagination: true,                   //是否显示分页（*）
             sortable: true,                     //是否启用排序
                              //排序方式
             sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
             pageNumber: 1,                      //初始化加载第一页，默认第一页,并记录
             pageSize: 10,                     //每页的记录行数（*）
             pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
             search: true,                      //是否显示表格搜索
             strictSearch: true,
             showColumns: false,                  //是否显示所有的列（选择显示的列）
             showRefresh: true,                  //是否显示刷新按钮
             minimumCountColumns: 1,             //最少允许的列数
             clickToSelect: true,                //是否启用点击选中行
             //height: 500,                      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
             uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
             showToggle: true,                   //是否显示详细视图和列表视图的切换按钮
             cardView: false,                    //是否显示详细视图
             detailView: false,                  //是否显示父子表
             //得到查询的参数
             queryParams : function (params) {
                 //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                 var temp = {   
                     rows: params.limit,                         //页面大小
                     page: (params.offset/params.limit) + 1,   //页码
                     sort: params.sort,      //排序列名  
                     sortOrder: params.order //排位命令（desc，asc） 
                 };
                 return temp;
             },
             columns:[{
                 field:'course_name',
                 title:'科目名称',
                 },{
                     field:'id',
                     title:'课程id',
                     visible: false,//false表示不显示
                 },{
                     field:'book_name',
                     title:'教材',
                 },{
                     field:'major_name',
                     title:'所属专业',
                 },{
                     field:'start_time',
                     title:'报名开始时间',
                 },{
                     field:'end_time',
                     title:'报名截止时间',
                 },{
                     field:'exam_time',
                     title:'考试开始时间',
                 },{
                     field:'ID',
                     title: '操作',
                     width: 120,
                     align: 'center',
                     valign: 'middle',
                     events:'operateEvents',
                     formatter: AddFunctionAlty,
                 }, ],
             onLoadSuccess: function () {
             },
             onLoadError: function () {
                 showTips("数据加载失败！");
             },
             onDblClickRow: function (row, $element) {
                 var id = row.ID;
                 EditViewById(id, 'view');
             },
		});
		$('#result').click(function() {
				$('.table').bootstrapTable(
					'refresh',{url : '${pageContext.request.contextPath}/apply/courseSearch'}
					);
			});
		$('#report').click(function(){
			alert("请选择科目！");
			});
	});

	function AddFunctionAlty(value, row, index) { 
		return [ '<button type="button" id="signbtn" style="margin-right:15px;">报考</button>'].join('')
	}
	
	var username="${sessionScope.user.name}";
	//alert(username);
	function insertSignup(){
		//var citycode=$('#in_citycode').val();
		var citycode=$('#city').combobox('getValue');
		if(citycode==""){
			alert("城市不能为空!");
			return;
		}
	
		//var districtcode=$('#in_districtcode').val();
		var districtcode=$('#district').combobox('getValue');
		if(districtcode==""){
			alert("区/县不能为空!");
			return;
		}
		$.ajax({
		    type : "post",
		    datatype : "json",
		    url : "${pageContext.request.contextPath}/apply/applyInsert",
		    data:{
		    	user_name:username,
		    	course_id:courseid,
		    	citycode:citycode, 
		    	districtcode:districtcode
		    },
		    success : function(result) {
		    	alert(result);
		    },
		    error:function(){
		    	alert("报考失败");
		    }
		});
		
		$('#city').combobox('clear');
		$('#district').combobox('clear');
		$('#dlg00').dialog('close');
	}
</script>
</html>