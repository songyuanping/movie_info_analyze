<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/9 0009
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>更新密码</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/static/css/font-awesome-4.7.0/css/font-awesome.min.css"
          rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="https://npmcdn.com/tether@1.2.4/dist/js/tether.min.js"></script>
    <script type="text/javascript" src="https://npmcdn.com/bootstrap@4.0.0-alpha.5/dist/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/bootstrap/bootstrap.min.js"></script>
<%--suppress JSJQueryEfficiency --%>
    <script type="text/javascript">
        $(function(){
            // 判断用户前后两次输入的密码是否相同
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
        <div class="alert-warning ">${message}</div>
    </div>
    <form class="col-4 offset-4" action="${pageContext.request.contextPath }/administrator/updatePassword" method="post">
        <div class="form-group">
            <label for="phone">账  户:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-phone fa-fw"></i>
                </span>
                <input type='text' id="phone" class="form-control" name="phone" readonly
                       value=${Administrator_SESSION.phone}>
            </div>
        </div>
        <div class="form-group">
            <label for="userName">用户名称:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <input type='text' id="userName" class="form-control" name="userName" readonly
                       value=${Administrator_SESSION.userName}>
            </div>
        </div>
        <div class="form-group">
            <label for="password">新密码:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-key fa-fw"></i>
                </span>
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
            <button id="password-button-bar" type="submit" class="btn btn-block btn-success ">修 改</button>
            <button type="reset" class="btn btn-block btn-info ">重 置</button>
        </div>
    </form>
</div>
</body>
</html>
