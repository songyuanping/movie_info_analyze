<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/3/8 0008
  Time: 19:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%--需要引入Encoder类--%>
<%@page import="java.net.URLEncoder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>下载页面</title>
</head>
<body>
<%-- <a href="${pageContext.request.contextPath }/download?filename=1.jpg">
    文件下载
</a> --%>
<%--使用Encoder类的encoder()方法对中文名进行编码--%>
<a href="${pageContext.request.contextPath }/download?filename=<%=URLEncoder.encode("壁纸.jpg", "UTF-8")%>">
    中文名称文件下载
</a>
</body>
</html>