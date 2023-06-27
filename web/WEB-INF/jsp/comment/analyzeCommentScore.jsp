<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/9 0009
  Time: 1:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>电影评分分析</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="https://npmcdn.com/tether@1.2.4/dist/js/tether.min.js"></script>
    <script type="text/javascript" src="https://npmcdn.com/bootstrap@4.0.0-alpha.5/dist/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/echarts.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/echarts/theme/infographic.js"></script>
</head>
<script>
    $(document).ready(
        //加载影评中该电影的评分信息
        function loadFunnelData() {
            var movieName='${movieName}';
            var comment = {
                "movieName": movieName,
            };
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/comment/analyzeCommentScore",
                //提交方式
                type: "POST",
                // data表示发送的数据
                data: JSON.stringify(comment),
                // 定义发送请求的数据格式为JSON字符串
                contentType: "application/json; charset=UTF-8",
                //定义回调响应的数据格式为JSON字符串,该属性可以省略
                dataType: "json",
                //成功响应的结果
                success: function (ret) {
                    var scoreList = ret.scoreList, rateList = ret.rateList;

                    // console.log(JSON.stringify(scoreList));
                    // console.log(JSON.stringify(rateList));

                    if (scoreList.length > 0) {
                        // 电影名称
                        movieName = ret.movieName;
                        var list = [],backList=[], str = ['1☆评价', '2☆评价', '3☆评价', '4☆评价', '5☆评价'];
                        for (var i = 0; i < scoreList.length; i++) {
                            var item = {
                                name: str[scoreList[i]/10-1],
                                value: rateList[i],
                            };
                            var backItem={
                                name: str[scoreList[i]/10-1],
                                    value: (rateList.length-i)*20,
                            };
                            list.push(item);
                            backList.push(backItem);
                        }

                        // console.log(JSON.stringify(list));

                        // document.getElementById("center-panel").innerHTML = '';
                        document.getElementById("main").removeAttribute("_echarts_instance_");
                        //设置div样式
                        document.getElementById("main").style.height = '600px';
                        document.getElementById("main").style.width = '1200px';
                        var myChart = echarts.init(document.getElementById('main'), 'shine');
                        var option = {
                            title: {
                                text: "电影 《" + movieName + "》 评分数据统计",
                                subtext: '数据来自: 豆瓣网电影评价的评分信息',
                                fontSize: 20
                            },
                            tooltip: {
                                trigger: 'item',
                                show: true,
                                backgroundColor: 'rgba(50,50,50,0.7)',
                                formatter: '{a}<br/>{b}: {c}%'
                            },
                            toolbox: {
                                show: true,
                                feature: {
                                    dataView: {readOnly: false},
                                    restore: {show: true},
                                    saveAsImage: {show: true},
                                }
                            },
                            legend: {
                                data: ['5☆评价', '4☆评价', '3☆评价', '2☆评价', '1☆评价'],
                                left: 'center',
                                fontSize: 15
                            },
                            series: [
                                {
                                    name: '预期评价',
                                    type: 'funnel',
                                    left: '10%',
                                    width: '80%',
                                    // top: '5%',
                                    label: {
                                        show: true,
                                        formatter: '{b}',
                                        left: '10%',
                                        width: '80%',
                                        fontSize: 15
                                    },
                                    labelLine: {
                                        show: false
                                    },
                                    itemStyle: {
                                        opacity: 0.7
                                    },
                                    emphasis: {
                                        label: {
                                            position: 'inside',
                                            formatter: '{b}'
                                        }
                                    },
                                    data: backList,
                                },
                                {
                                    name: '评分占比',
                                    type: 'funnel',
                                    left: '10%',
                                    width: '80%',
                                    maxSize: '80%',
                                    // top: '5%',
                                    label: {
                                        position: 'inside',
                                        formatter: '{c}%',
                                        color: '#fff',
                                        fontSize: 14
                                    },
                                    itemStyle: {
                                        opacity: 0.575,
                                        borderColor: '#fff',
                                        borderWidth: 2
                                    },
                                    emphasis: {
                                        label: {
                                            position: 'inside',
                                            formatter: '实际{b}: {c}%'
                                        }
                                    },
                                    data: list
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
<body>
<div id="main" class="container" style="padding-top: 30px"></div>
</body>
</html>
