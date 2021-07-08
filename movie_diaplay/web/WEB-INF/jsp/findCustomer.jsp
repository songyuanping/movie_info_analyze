<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<form action="${pageContext.request.contextPath }/findCustomer" method="POST">
    用户id：<input id="id" type="text" name="id"/><br />
    <input type="submit" value="登录" />
</form>
</body>
</html>