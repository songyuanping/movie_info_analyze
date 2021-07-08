<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>影评分析信息</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js"></script>
    <link href="${pageContext.request.contextPath }/static/css/bootstrap/bootstrap.css" rel="stylesheet">
    <script src="https://npmcdn.com/tether@1.2.4/dist/js/tether.min.js"></script>
    <script src="https://npmcdn.com/bootstrap@4.0.0-alpha.5/dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/bootstrap/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/echarts.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/dark.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/shine.js"></script>
    <script type="text/javascript">
        function loadBarData(movieName) {
            // var movieName = $("#movieName").val();
            var elementValue = {
                "movieName": movieName,
            };
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/elementValue/findElementValues",
                //提交方式
                type: "POST",
                // data表示发送的数据
                data: JSON.stringify(elementValue),
                // 定义发送请求的数据格式为JSON字符串
                contentType: "application/json; charset=UTF-8",
                //定义回调响应的数据格式为JSON字符串,该属性可以省略
                dataType: "json",
                //成功响应的结果
                success: function (elementValueList) {
                    if (elementValueList.length > 0) {
                        // 电影名称
                        movieName = elementValueList[0].movieName;
                        // alert(movieName);
                        // console.log(movieName);

                        // 电影评论元素关键字，该元素的正面评论和负面评论
                        var keyWordList = [], positiveCountList = [], negativeCountList = [];
                        for (var i = 0; i < elementValueList.length; i++) {
                            keyWordList.push(elementValueList[i].keyWard);
                            positiveCountList.push(elementValueList[i].positiveCount);
                            negativeCountList.push(elementValueList[i].negativeCount);
                        }
                        document.getElementById("center-panel").innerHTML = '';
                        document.getElementById("main").removeAttribute("_echarts_instance_");
                        var myChart = echarts.init(document.getElementById('main'), 'shine');
                        var option = {
                            title: {
                                text: movieName + " 影评数据分析",
                                subtext: '数据来自: 豆瓣网前250部电影'
                            },
                            grid: {
                                left: '3%',
                                right: '7%',
                                bottom: '3%',
                                containLabel: true
                            },
                            tooltip: {
                                trigger: 'item',
                                show: true,

                            },
                            legend: {
                                data: ['正面评价', '负面评价'],
                                left: 'center'
                            },
                            xAxis: {
                                type: 'category',
                                axisLabel: {
                                    formatter: '{value}'
                                },
                                splitLine: {
                                    show: false
                                },
                                data: keyWordList,
                            },
                            yAxis: {
                                type: 'value',
                                scale: true,
                                axisLabel: {
                                    formatter: '{value} 次'
                                },
                                splitLine: {
                                    show: false
                                }
                            },
                            series: [
                                {
                                    name: '正面评价',
                                    type: 'bar',
                                    data: positiveCountList,
                                },
                                {
                                    name: '负面评价',
                                    type: 'bar',
                                    data: negativeCountList,
                                }
                            ]

                        };
                        //为echarts对象加载数据
                        myChart.setOption(option);
                        window.onresize = myChart.resize;
                    }
                },
                error: function () {
                    alert("电影评论分析数据加载失败！");
                },
            });
        }

    </script>
</head>
<body>
<div class="d-block">
    ${message}
</div>

<div id="center-panel" class="container">
    <table class="table table-striped" align="center">
        <tr>
            <th>电影名称</th>
            <th>类型</th>
            <th>评分</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${movieList}" var="movie">
            <tr>
                <td>${movie.movieName}</td>
                <td>${movie.movieType}</td>
                <td>${movie.movieScore}</td>
                <td>
                    <button class="btn btn-info" type="submit" onclick="loadBarData('${movie.movieName}')">查 看</button>
                </td>
            </tr>
        </c:forEach>>
    </table>
</div>

<%--电影名称：<input id="movieName" class=" text-info" type="text" name="movieName" /><br/>--%>
<%--<input id="button" class="btn btn-info" type="submit" value="提 交" onclick="loadBarData()"/>--%>

<div id="main" class="container" style="width: 1000px;height: 600px"></div>
</body>
</html>
