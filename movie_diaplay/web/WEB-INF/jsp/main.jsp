<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>系统主页</title>
</head>
<body>
<div class="container">
    <div class="row">
        当前用户：${Administrator_SESSION.userName}
        <a href="${pageContext.request.contextPath }/administrator/logout">退出</a><br/>
    </div>
    <div class="row">
        查找电影的各个元素评价信息：
        <a href="${pageContext.request.contextPath }/elementValue/toFindElementValues">查找</a><br/>
    </div>
    <div class="rounded">
        更新用户密码信息：
        <form class="form-horizontal" action="${pageContext.request.contextPath}/administrator/updateAdministrator"
              method="post">
            用户密码：<input id="password-label" required="required" type="password" name="password"><br/>
            手机号码：<input id="about-dialog-text-area" required="required" type="text" name="phone"><br/>
            <input type="submit" value="修 改"/>
        </form>
    </div>
    <div class="row">
        展示每一年主要类型电影的数量：
        <form class="well form-search" action="${pageContext.request.contextPath }/movie/queryMovieType" method="post">
            电影名称：<input id="movieName2" type="text" name="movieName"/><br/>
            <input type="submit" value="查询"/>
        </form>
    </div>
    <div class="row">
        展示每一年各个类型电影的数量：
        <form action="${pageContext.request.contextPath }/movie/findMovieType" method="post">
            <input type="submit" value="查询"/>
        </form>
    </div>
    <div class="row">
        展示电影评分与评论人数关系：
        <a href="${pageContext.request.contextPath }/movie/toShowMovie">显示</a>
    </div>
</div>
</body>
</html>
