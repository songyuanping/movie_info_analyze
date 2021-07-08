<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/19 0019
  Time: 23:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>重置密码</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/static/css/font-awesome-4.7.0/css/font-awesome.min.css"
          rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/bootstrap/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="row col-4 offset-4" style="padding-top: 45px">
        <div class="alert-warning">${message}</div>
    </div>
    <form class="col-4 offset-4" action="${pageContext.request.contextPath }/administrator/sendEmail" method="post">
        <div class="form-group">
            <label for="userName">用户名:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <input id="userName" type="text" class="form-control" name="userName" required="required"
                       pattern="^[0-9a-zA-Z\u4E00-\u9FA5]+" placeholder="请输入用户名"/>
            </div>
        </div>
        <div class="form-group">
            <label for="email">邮  箱:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-mail-forward fa-fw"></i>
                </span>
                <input id="email" type="email" class="form-control" name="email" required="required"
                       placeholder="请输入注册邮箱"/>
            </div>
        </div>
        <div class="form-group justify-content-center">
            <button type="submit" class="btn btn-success btn-block ">确  定</button>
            <button type="reset" class="btn btn-info btn-block ">重  填</button>
        </div>
    </form>
</div>
</body>
</html>
