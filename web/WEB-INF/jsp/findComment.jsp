<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<form action="${pageContext.request.contextPath }/findComment" method="POST">
    电影名称：<input id="movieName" type="text" name="movieName"/><br />
    <input type="submit" value="查询" />
</form>
</body>
</html>