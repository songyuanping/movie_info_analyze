<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录页面</title>
</head>
<body>
${message}
<form action="${pageContext.request.contextPath }/administrator/login" method="post">
    用户姓名：<input type="text" name="userName"/><br/>
    登录密码：<input type="password" name="password"/><br/>
    <input type="submit" value="登录"/>
</form>

</body>
</html>