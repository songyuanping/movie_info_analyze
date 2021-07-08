<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>登录页面</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/static/css/font-awesome-4.7.0/css/font-awesome.min.css"
          rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js"></script>
    <%--<script type="text/javascript" src="https://npmcdn.com/tether@1.2.4/dist/js/tether.min.js"></script>--%>
    <%--<script type="text/javascript" src="https://npmcdn.com/bootstrap@4.0.0-alpha.5/dist/js/bootstrap.min.js"></script>--%>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript">
        function toRegister() {
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/administrator/toRegister",
                //提交方式
                type: "GET",
                // data表示发送的数据
                data: [],
                // 定义发送请求的数据格式为JSON字符串
                contentType: "application/json; charset=UTF-8",
                //定义回调响应的数据格式为JSON字符串,该属性可以省略
                dataType: "json",
                //成功响应的结果
                success: function () {
                    console.log("跳转到注册页面成功！");
                },
                error: function () {
                    alert('跳转到注册页面失败！');
                },
            });
        }
    </script>
</head>
<body>
<div class="container">
    <div class="row col-4 offset-4" style="padding-top: 45px">
        <div class="alert-warning">${message}</div>
    </div>
    <form class="col-4 offset-4" action="${pageContext.request.contextPath }/administrator/login" method="post">
        <div class="form-group">
            <label for="userName">用户名:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-user fa-fw"></i>
                </span>
                <input id="userName" type="text" class="form-control" name="userName" required="required"
                       pattern="[0-9a-zA-Z\u4E00-\u9FA5]+" placeholder="请输入用户名"/>
            </div>
        </div>
        <div class="form-group">
            <label for="password">密 码:</label>
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-key fa-fw"></i>
                </span>
                <input id="password" type="password" class="form-control" name="password" required="required"
                       pattern="^[a-zA-Z]\w{5,17}$" placeholder="请输入密码"/>
            </div>
        </div>
        <div class="form-check">
            <label class="form-check-label ">
                <input class="form-check-input" checked="checked" type="checkbox"> 下次自动登录
            </label>
        </div>
        <div class="form-group justify-content-center">
            <button type="submit" class="btn btn-success btn-block ">登 录</button>
        </div>
    </form>
    <div class="row col-4 offset-4">
        <a href="${pageContext.request.contextPath }/administrator/toRegister" class="btn btn-info btn-block ">注
            册
        </a>
        <a href="${pageContext.request.contextPath }/administrator/toSendEmail" >忘记密码？
        </a>
    </div>
</div>
</body>
</html>