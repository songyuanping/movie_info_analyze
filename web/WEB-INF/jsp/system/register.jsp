<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/19 0019
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/static/css/font-awesome-4.7.0/css/font-awesome.min.css"
          rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function(){
            $("#password-button-bar").click(function(){
                var password = $("input[name='password']").val();
                var password1 = $("input[name='password1']").val();
                if(password !== password1){
                    alert("两次密码不一致，请重新输入!");
                    $("input[name='password']").val("");
                    $("input[name='password1']").val("");
                    return false;
                }
            });
        });
    </script>
</head>
<body>
<div class="container">
    <div class="row col-4 offset-4" style="padding-top: 45px">
        <div class="alert-warning text-center">${message}</div>
    </div>
    <form class="col-4 offset-4" action="${pageContext.request.contextPath }/administrator/register" method="post">
        <div class="form-group">
            <label for="phone">账  户:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-phone fa-fw"></i>
                </span>
                <%--匹配13位电话号码--%>
                <input type='text' id="phone" class="form-control" placeholder="输入13位电话号码" name="phone" pattern="^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\d{8}$" required>
            </div>
        </div>
        <div class="form-group">
            <label for="userName">用户名称:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <%--匹配中英文的用户名称--%>
                <input type='text' id="userName" class="form-control" placeholder="输入账户名称" name="userName" pattern="[0-9a-zA-Z\u4E00-\u9FA5]+" required>
            </div>
        </div>
        <div class="form-group">
            <label for="email">邮  箱:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-mail-forward fa-fw"></i>
                </span>
                <%--匹配用户邮箱--%>
                <input type='email' id="email" class="form-control" placeholder="输入邮箱" pattern="^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$" name="email" required>
            </div>
        </div>
        <div class="form-group">
            <label for="password">密  码:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-key fa-fw"></i>
                </span>
                <%--匹配用户密码，要求长度为6-18且以字母开头--%>
                <input type='password' id="password" name="password" class="form-control" required
                       placeholder="字母开头，长度为: 6-18" pattern="^[a-zA-Z]\w{5,17}$">
            </div>
        </div>
        <div class="form-group">
            <label for="password1">再次输入:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-key fa-fw"></i>
                </span>
                <input type='password' id="password1" name="password1" class="form-control" required
                       placeholder="必须和第一次一样" pattern="^[a-zA-Z]\w{5,17}$">
            </div>
        </div>

        <div class="form-group justify-content-center">
            <button id="password-button-bar" type="submit" class="btn btn-block btn-success ">注 册</button>
            <button type="reset" class="btn btn-block btn-info ">重 置</button>
        </div>
    </form>
</div>
</body>
</html>
