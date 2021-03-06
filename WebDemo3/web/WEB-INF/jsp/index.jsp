<%@ page import="model.Student" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctxpath = request.getContextPath();%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim 和 Respond.js 是为了让 IE8 支持 HTML5 元素和媒体查询（media queries）功能 -->
    <!-- 警告：通过 file:// 协议（就是直接将 html 页面拖拽到浏览器中）访问页面时 Respond.js 不起作用 -->

    <script src="static/js/html5shiv.min.js"></script>
    <script src="static/js/respond.min.js"></script>

    <style>
        h2{text-align: center;}
        p{text-align: center;}
        body {
            padding-top: 70px;
            padding-bottom: 30px;
        }
        td{text-align: center;}
        th{text-align: center;}
    </style>
</head>
<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">CURD练习</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="<%=ctxpath%>/students">列表</a></li>
                <li><a href="<%=ctxpath%>/add">新增</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>
    <div class="container">
        <input type="hidden" id="ctx" value="<%=ctxpath%>">
        <div class="panel panel-info">
            <!-- Default panel contents -->
            <div class="panel-heading"><h2>增删改查练习</h2></div>
            <div class="panel-body">
                <p>这个项目旨在演示初级工程师必须掌握的CURD操作</p>
            </div>
            <%List<Student> students = (List<Student>) request.getAttribute("students");%>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="checkBox1">
                        </th>
                        <th>ID</th>
                        <th>学生名字</th>
                        <th>学生年龄</th>
                        <th>学生电话</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                <% for(Student student : students){%>
                    <tr>
                        <td><input type="checkbox" name="checkBox"></td>
                        <td><%=student.getId()%></td>
                        <td><%=student.getStudentName()%></td>
                        <td><%=student.getAge()%></td>
                        <td><%=student.getTelphone()%></td>
                        <td>
                            <button type="button" class="btn btn-info">编辑</button>
                        </td>
                    </tr>
                <%}%>
                </tbody>
            </table>
            <div class="panel-footer">
                <button type="button" class="btn btn-danger">删除</button>
            </div>
        </div>
    </div>

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="static/js/jquery1.12.4.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script>
    $(function(){
        var ctxPath = $("#ctx").val();
        $(".btn-info").click(function(){
            var id = $(this).parent().parent().children(":nth-child(2)").text();
            window.location.href = ctxPath + "/edit?userId="+id;
        });

        $("#checkBox1").click(function(){
            var checkBoxs = $("input[name='checkBox']");
            for(var i=0;i<checkBoxs.length;i++){
                checkBoxs.get(i).checked = !checkBoxs.get(i).checked;
            }
        });

        $(".btn-danger").click(function(){
            var flag = confirm("确认删除吗？");
            if(flag){
                var checkBoxs = $("input[name='checkBox']:checked");
                var ids = [];
                checkBoxs.each(function(){
                    var id = $(this).parent().next().text();
                    ids.push(id);
                });

                //发送ajax异步请求删除数据库
                $.ajax({
                    url: ctxPath+'/delete',
                    method: 'post',
                    data: {ids: ids},
                    traditional: true,
                    success: function(){
                        window.location.href = ctxPath+"/students";
                    }
                });
            }
        });
    });
</script>
</body>
</html>
