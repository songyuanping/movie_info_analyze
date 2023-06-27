<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>影评分析信息</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js"></script>
    <link href="${pageContext.request.contextPath }/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="https://npmcdn.com/tether@1.2.4/dist/js/tether.min.js"></script>
    <script type="text/javascript" src="https://npmcdn.com/bootstrap@4.0.0-alpha.5/dist/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/echarts.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/theme/dark.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/theme/shine.js"></script>
</head>
<body>
<%--<div class="text-info ">--%>
    <%--<h3 class="align-content-center ">${message}</h3>--%>
<%--</div>--%>
<!--搜索表单 -->
<div class="container-fluid" style="padding-top: 20px;">
    <form class="form-inline justify-content-center" action="${pageContext.request.contextPath }/movie/searchMovies" method="post" >
        <label for="rank" class="form-control-label">排 名：</label>
        <input id="rank" name="rank" type="number"  class="form-control" placeholder="输入排名"/>
        <label for="movieName" class="form-control-label" style="margin-left: 15px;">电影名称：</label>
        <input id="movieName" name="movieName" type="text" class="form-control" placeholder="输入电影名称"/>
        <label for="movieType" class="form-control-label" style="margin-left: 15px;">电影类型：</label>
        <input id="movieType" name="movieType" type="text" class="form-control" placeholder="输入电影类型"/>
        <label for="makeCountry"   class="form-control-label" style=" margin-left: 15px;">地  区：</label>
        <input id="makeCountry" name="makeCountry" type="text" class="form-control" placeholder="输入地区"/>
        <input type="submit" class="btn btn-success" value="查 找" style=" margin-left: 15px;"/>
    </form>
</div>
<div class="container" id="center-panel">
    <!--显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class=" table table-rounded table-striped table-hover" align="center">
                <thead class="thead-inverse">
                <tr >
                    <th>排 名</th>
                    <th>电影名称</th>
                    <th>热 度</th>
                    <th>豆瓣评分</th>
                    <th class="nav justify-content-center">操 作</th>
                </tr>
                </thead>
                <c:forEach items="${movieList}" var="movie">
                    <tr>
                        <td>#${movie.rank}</td>
                        <td>《${movie.movieName}》</td>
                        <td align="justify">${movie.commenterNumber} 人次</td>
                        <td>${movie.movieScore} 分</td>
                        <td align="center">
                            <button class="btn btn-info" type="submit" onclick="window.location.href='${pageContext.request.contextPath}/elementValue/toShowElementAnalyze?movieName=${movie.movieName}'">
                                <span aria-hidden="true"></span>
                                元素分析
                            </button>
                            <button class="btn btn-info" type="submit"  onclick="window.location.href='${pageContext.request.contextPath}/comment/toAnalyzeCommentScore?movieName=${movie.movieName}'">
                                <span aria-hidden="true"></span>
                                评分分析
                            </button>

                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <!-- 显示分页信息-->
    <div class="row">
        <!-- 分页文字信息-->
        <div class="col-md-6">
            <p class="text-info">当前第<mark> ${pageNumber} </mark>页，总共 <mark>${pages}</mark> 页，总共 <mark>${total}</mark> 条记录</p>
        </div>
        <!-- 分页条-->
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination pagination-sm">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/elementValue/toFindElementValues?currentPageNumber=1">首页</a>
                    </li>
                    <li class="page-item ">
                        <c:if test="${pageNumber>1}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/elementValue/toFindElementValues?currentPageNumber=${pageNumber-1}"
                               aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </c:if>
                    </li>
                    <c:forEach items="${navigatePageNumberList}" var="page_Num">
                        <c:if test="${page_Num==pageNumber}">
                            <li class="page-item active"><a class="page-link" href="#">${page_Num}</a></li>
                        </c:if>
                        <c:if test="${page_Num!=pageNumber}">
                            <li class="page-item"><a class="page-link"
                                                     href="${pageContext.request.contextPath}/elementValue/toFindElementValues?currentPageNumber=${page_Num}">${page_Num}</a>
                            </li>
                        </c:if>
                    </c:forEach>
                    <li class="page-item">
                        <c:if test="${pageNumber<pages}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/elementValue/toFindElementValues?currentPageNumber=${pageNumber+1}"
                               aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </c:if>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/elementValue/toFindElementValues?currentPageNumber=${pages}">末页</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
