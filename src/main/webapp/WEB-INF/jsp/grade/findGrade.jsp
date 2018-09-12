<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<h1 class="page-header">成绩查询</h1>
	<div>
		<table class="table"></table>
	</div>
</body>
<script>
    window.operateEvents = {
		"click #DataError":function(e,value,row,index){
			/*alert(row.course_id);*/
			var course_id = row.course_id;
			$.ajax({
			url : "${pageContext.request.contextPath}/grade/gradeError", //地址
			data : {
				course_id : course_id
			},
			type : "POST",
			success : function() {
				//console.log(result);
				alert("报错成功！");
                $('.table').bootstrapTable('refresh');//刷新
			},
			error : function() {
				alert("error!");
			}
		    })
	     }	
    }
	$(function() {
		$('.table').bootstrapTable({
			 url: '${pageContext.request.contextPath}/grade/gradeSearchByStudent',                      //请求后台的URL（*）
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
            	 field:'course_id',
                 title:'科目id',
                 },{
                 field:'course_name',
                 title:'考试科目',
                 },{
                     field:'grade',
                     title:'卷面成绩',
                 },{
                     field:'usual_grade',
                     title:'平时成绩',
                 },{
                     field:'final_grade',
                     title:'最终成绩',
                 },{
                     field:'remark',
                     title:'备注',
                 },{
                     field:'ID',
                     title: '操作',
                     width: 120,
                     align: 'center',
                     valign: 'middle',
                     events:operateEvents,
                     formatter: operateFormatter
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
		$('#result')
				.click(
						function() {
							$('.table')
									.bootstrapTable(
											'refresh',
											{
												url : '${pageContext.request.contextPath}/grade/gradeSearchByStudent'
											});
						});
		$('#report').click(function(){
			alert("请选择科目！");
			});
	});

	function operateFormatter(value, row, index) { return [ '<button type="button" id="DataError" class="RoleOfdelete btn btn-primary btn-sm" style="margin-right:15px;">报错</button>'].join(''); }
</script>
</html>