<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<form action="${pageContext.request.contextPath }/findMovie" method="POST">
    用户id：<input id="rank" type="text" name="rank"/><br />
    <input type="submit" value="查询" />
</form>
</body>
</html>