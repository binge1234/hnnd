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