<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/8 0008
  Time: 22:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>从Model中取出列表信息</title>
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
    <script>
        //加载影评中该电影的评分信息
        $(document).ready(function loadBarData() {
            var movieName='${movieName}';
            // console.log(movieName);
            var elementValue = {
                "movieName": movieName,
            };
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/elementValue/showElementAnalyze",
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
                        // 电影评论元素关键字，该元素的正面评论和负面评论
                        var keyWordList = [], positiveCountList = [], negativeCountList = [];
                        for (var i = 0; i < elementValueList.length; i++) {
                            keyWordList.push(elementValueList[i].keyWard);
                            positiveCountList.push(elementValueList[i].positiveCount);
                            negativeCountList.push(elementValueList[i].negativeCount);
                        }
                        // document.getElementById("center-panel").innerHTML = '';
                        document.getElementById("main").removeAttribute("_echarts_instance_");
                        //设置div样式
                        document.getElementById("main").style.height = '600px';
                        document.getElementById("main").style.width = '1200px';
                        var myChart = echarts.init(document.getElementById('main'), 'shine');
                        var option = {
                            title: {
                                text: "《" + movieName + "》影评数据分析",
                                // subtext: '数据来自: 豆瓣网前250部电影'
                            },
                            grid: {
                                left: '3%',
                                right: '7%',
                                bottom: '3%',
                                containLabel: true
                            },
                            tooltip: {
                                trigger: 'item',
                                axisPointer: {
                                    type: 'shadow'
                                },
                                show: true,
                            },
                            toolbox: {
                                show: true,
                                feature: {
                                    dataZoom: {
                                        show: true
                                    },
                                    dataView: {readOnly: true},
                                    restore: {show: true},
                                    saveAsImage: {show: true},
                                }
                            },
                            legend: {
                                data: ['正面评价', '负面评价'],
                                icon: 'circle',//图例形状，示例为原型
                                left: 'center'
                            },
                            xAxis: {
                                name: '元素',
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
                                name: '评价次数',
                                type: 'value',
                                scale: true,
                                axisLabel: {
                                    formatter: '{value} 次'
                                },
                                splitLine: {
                                    show: true,
                                    type: 'dashed',
                                },
                                label: {
                                    show: true,
                                    position: 'top'
                                },
                            },
                            series: [
                                {
                                    name: '正面评价',
                                    type: 'bar',
                                    data: positiveCountList,
                                    markLine: {
                                        lineStyle: {
                                            type: 'dashed',
                                            color: 'rgba(15,99,198,0.8)'
                                        },
                                        data: [
                                            [{type: 'min'}, {type: 'max'}]
                                        ]
                                    },
                                    label: {
                                        show: true,
                                        position: 'inside'
                                    },
                                    animationDelay: function (idx) {
                                        return idx * 10;
                                    }
                                },
                                {
                                    name: '负面评价',
                                    type: 'bar',
                                    data: negativeCountList,
                                    label: {
                                        show: true,
                                        position: 'inside'
                                    },
                                    animationDelay: function (idx) {
                                        return idx * 10 + 100;
                                    }
                                }
                            ]
                        };
                        //为echarts对象加载数据
                        myChart.setOption(option);
                        window.onresize = myChart.resize;
                    }
                },
                error: function () {
                    alert('${message}');
                },
            });
        });
    </script>
</head>
<body>
<div id="main" class="container" style="padding-top: 30px"></div>
</body>
</html>
