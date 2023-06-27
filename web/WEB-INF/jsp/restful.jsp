<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>RESTful测试</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js" ></script>
    <script type="text/javascript">
        function search() {
            // 获取输入的查询编号
            var id = $("#number").val();
            $.ajax({
                url: "${pageContext.request.contextPath }/user/" + id,
                type: "GET",
                //定义回调响应的数据格式为JSON字符串,该属性可以省略
                dataType: "json",
                //成功响应的结果
                success: function (user1) {
                    if (user1.username != null) {
                        alert("您查询的用户是：" + user1.username);
                    } else {
                        alert("没有找到id为:" + id + "的用户！");
                    }
                }
            });
        }
    </script>
</head>
<body>
<form>
    编号：<input type="text" name="number" id="number"/>
    <input type="button" value="搜索" onclick="search()"/>
</form>
</body>
</html>
