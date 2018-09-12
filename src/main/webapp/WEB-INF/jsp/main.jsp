<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.hnnd.entity.*,java.util.*" %>
<html>
<head>
    <title>自学管理系统</title>

  <%@include file="../../common/Cupertino.jspf"%>
    <style type="text/css">
        body {
            font-family: microsoft yahei;
        }
        #Title{
        font-family:STXingkai;
        color:navy;
        font-size:40px;
        }
    </style>
    <script>
        /**
         * 打开新选项卡
         * @param text 标题
         * @param url   路径
         * @param icon  图标
         */
        function openTab(text,url) {
            //判断当前选项卡是否存在
            if($('#tabs').tabs('exists',text)){
                //如果存在 显示
                $("#tabs").tabs("select",text);
            }else{
                //如果不存在 则新建一个
                $("#tabs").tabs('add',{
                    title:text,
                    closable:true,      //是否允许选项卡摺叠。
                    content:"<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='"+url+"'></iframe>"
                    //url 远程加载所打开的url
                })
            }
        }
    </script>
</head>
<body class="easyui-layout" onbeforeunload="window.location='${pageContext.request.contextPath}/user/logout'">

<div region="north" style="height: 78px; background-color: #E0ECFF">
    <table style="padding: 5px" width="100%">
        <tr>
            <td width="50%">
                <h2 id="Title">&nbsp;&nbsp;&nbsp;&nbsp;自学管理系统</h2>
            </td>
            <td align="right" width="50%">
                <font size="3" color="#1e90ff">&nbsp;&nbsp;<strong>欢迎：${user.name}</strong></font>
            </td>
        </tr>
    </table>
    <!-- <div style="padding: 5px" width="100%">
        <div width="50%"><h2 id="Title">&nbsp;&nbsp;&nbsp;&nbsp;自学管理系统</h2></div>
        <div width="50%">欢迎：${user.name}</div>
    </div> -->
</div>
<div region="west" style="width: 200px" title="管理菜单" split="true">
    <div class="easyui-accordion" data-options="fit:true,border:false">
        <div title="计划管理" data-options="selected:true,iconCls:'icon-item'" style="padding: 10px">
            <a href="javascript:openTab('专业计划管理','${pageContext.request.contextPath}/major/selectMajor','icon-writeblog')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px">专业管理</a>
            <a href="javascript:openTab('课程计划管理','${pageContext.request.contextPath}/course/selectCourse')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-review'" style="width: 150px">课程管理</a>
            <!-- <a href="javascript:openTab('考试计划管理','${pageContext.request.contextPath}/exam/selectExam')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-review'" style="width: 150px">考试管理</a> -->
            <a href="javascript:openTab('考点计划管理','${pageContext.request.contextPath}/examLocation/selectExamLocation')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-review'" style="width: 150px">考点管理</a>
        </div>
        
        
        <div title="成绩管理" data-options="iconCls:'icon-bkgl'" style="padding:10px;">
            <a href="javascript:openTab('成绩管理','${pageContext.request.contextPath}/grade/selectGrade')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px;">成绩管理</a>
            <!--<a href="javascript:openTab('查分管理','${pageContext.request.contextPath}/grade/FindGrade','icon-bkgl')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-bkgl'" style="width: 150px;">查分管理</a>-->
        </div>
        
        
        <div title="学籍管理" data-options="iconCls:'icon-bklb'" style="padding:10px">
            <!-- <a href="javascript:openTab('','blogTypeManage.jsp','icon-bklb')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-bklb'" style="width: 150px;"></a> -->
        </div>
        <div title="报考管理" data-options="iconCls:'icon-plgl'" style="padding:10px">
            <a href="javascript:openTab('报考统计','${pageContext.request.contextPath}/apply/selectApply','icon-writeblog')" class="easyui-linkbutton"
            data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px">统计</a>
        </div>
        <!--<div title="信息管理" data-options="iconCls:'icon-grxx'" style="padding:10px">
            <a href="javascript:openTab('修改个人信息','modifyInfo.jsp','icon-grxxxg')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-grxxxg'" style="width: 150px;"></a>
        </div>-->
        <div title="系统管理" data-options="iconCls:'icon-system'" style="padding:10px">
            <a href="javascript:openTab('用户管理','${pageContext.request.contextPath}/user/selectUser','icon-grxx')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-grxx'" style="width: 150px">用户管理</a>
            <a href="javascript:openTab('角色管理','${pageContext.request.contextPath}/role/selectRole','icon-link')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-link'" style="width: 150px">角色管理</a>
            <a href="javascript:openTab('权限管理','${pageContext.request.contextPath}/permission/selectPermission','icon-modifyPassword')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px">权限管理</a>
            <!-- <a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;"></a>
            <a href="javascript:refreshSystemCache()" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-refresh'" style="width: 150px;"></a>
            <a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'"
               style="width: 150px;"></a> -->
        </div>
    </div>
</div>

<div data-options="region:'center'" style="background:#eee;">
    <div class="easyui-tabs" fit="true" border="false" id="tabs">
        <div title="首页" data-options="iconCls:'icon-home'">
        </div>
    </div>
</div>

</body>
</html>