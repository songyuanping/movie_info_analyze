<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/3/24 0024
  Time: 20:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>电影信息展示页面</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/static/css/bootstrap/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/bootstrap/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/echarts.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/dark.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/shine.js"></script>
    <script type="text/javascript">
        function loadScatterData() {
            var scoreAndCommenterList = [];
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/movie/showScoreAndCommenter",
                //提交方式
                type: "POST",
                // data表示发送的数据
                data: [],
                // 定义发送请求的数据格式为JSON字符串
                contentType: "application/json; charset=UTF-8",
                //定义回调响应的数据格式为JSON字符串,该属性可以省略
                dataType: "json",
                //成功响应的结果
                success: function (movieList) {
                    if (movieList.length > 0) {
                        var sum = 0;
                        for (var i = 0; i < movieList.length; i++) {
                            sum += movieList[i].movieScore;
                            scoreAndCommenterList.push([movieList[i].movieScore, movieList[i].commenterNumber, movieList[i].movieName]);
                        }
                        var averageScore = sum / movieList.length;
                        document.getElementById("main").removeAttribute("_echarts_instance_");
                        var myChart = echarts.init(document.getElementById('main'), 'shine');
                        var option = {
                            title: {
                                text: "电影评论人数与电影评分关系",
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
                                formatter: function (params) {
                                    return "电影：" + params.value[2] + ' <br/>'
                                        + "评分：" + params.value[0] + '分 ' + ' <br/>'
                                        + "评论：" + params.value[1] + '人次 ';
                                },
                                axisPointer: {
                                    show: true,
                                    type: 'cross',
                                    lineStyle: {
                                        type: 'dashed',
                                        width: 1
                                    }
                                }
                            },
                            legend: {
                                data: ['评论人数'],
                                left: 'center'
                            },
                            xAxis: {
                                type: 'value',
                                scale: true,
                                axisLabel: {
                                    formatter: '{value} 分'
                                },
                                splitLine: {
                                    show: false
                                }
                            },
                            yAxis: {
                                type: 'value',
                                scale: true,
                                axisLabel: {
                                    formatter: '{value} 人次'
                                },
                                splitLine: {
                                    show: false
                                }
                            },
                            series: [
                                {
                                    name: '评论及评分信息',
                                    type: 'scatter',
                                    data: scoreAndCommenterList,
                                    markArea: {
                                        silent: true,
                                        itemStyle: {
                                            color: 'transparent',
                                            borderWidth: 1,
                                            borderType: 'dashed'
                                        },
                                        data: [[{
                                            name: '数据样本分布区间',
                                            xAxis: 'min',
                                            yAxis: 'min'
                                        }, {
                                            xAxis: 'max',
                                            yAxis: 'max'
                                        }]]
                                    },
                                    markPoint: {
                                        data: [
                                            {type: 'max', name: '最大值'},
                                            {type: 'min', name: '最小值'}
                                        ]
                                    },
                                    markLine: {
                                        lineStyle: {
                                            type: 'solid'
                                        },
                                        data: [
                                            {type: 'average', name: '平均值'},
                                            {xAxis: averageScore}
                                        ]
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
                    alert("电影评分与评论人数数据请求失败！");
                },
            });
        }

        function loadPieData() {

            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/movie/showMovieType",
                //提交方式
                type: "POST",
                // data表示发送的数据
                data: [],
                // 定义发送请求的数据格式为JSON字符串
                contentType: "application/json; charset=UTF-8",
                //定义回调响应的数据格式为JSON字符串,该属性可以省略
                dataType: "json",
                //成功响应的结果
                success: function (ret) {
                    var typeList = ret.typeList;
                    var numberList = ret.numberList;
                    var pieData = [],pieType=[];
                    if (typeList.length > 0 && numberList.length > 0) {
                        var sum = 0;
                        for (var i = 0; i < typeList.length; i++) {
                            if (i < 10) {
                                var item = {
                                    name: typeList[i],
                                    value: numberList[i]
                                };
                                pieType.push(typeList[i]);
                                pieData.push(item);
                            } else {
                                sum += numberList[i];
                            }
                        }
                        item = {
                            name: '其他',
                            value: sum
                        };
                        pieType.push(item.name);
                        pieData.push(item);
                    }
                    document.getElementById("main").removeAttribute("_echarts_instance_");
                    var myChart = echarts.init(document.getElementById('main'), 'shine');
                    var option = {
                        title: {
                            text: "电影评论人数与电影评分关系",
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
                            formatter: '{a} <br/>{b} : {c} ({d}%)'
                        },
                        legend: {
                            orient: 'vertical',
                            left: 10,
                            top:'center',
                            data: pieType
                        },
                        series: [
                            {
                                name: '电影数量及占比信息',
                                type: 'pie',
                                radius: ['30%', '65%'],
                                center: ['50%', '45%'],
                                // roseType: 'radius',
                                selectedMode: 'single',
                                label: {
                                    formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
                                    backgroundColor: '#eee',
                                    borderColor: '#aaa',
                                    borderWidth: 1,
                                    borderRadius: 4,
                                    shadowBlur:3,
                                    shadowOffsetX: 2,
                                    shadowOffsetY: 2,
                                    shadowColor: '#999',
                                    padding: [0, 7],
                                    rich: {
                                        a: {
                                            color: '#999',
                                            lineHeight: 22,
                                            align: 'center'
                                        },
                                        abg: {
                                            backgroundColor: '#333',
                                            width: '100%',
                                            align: 'right',
                                            height: 22,
                                            borderRadius: [4, 4, 0, 0]
                                        },
                                        hr: {
                                            borderColor: '#aaa',
                                            width: '100%',
                                            borderWidth: 0.5,
                                            height: 0
                                        },
                                        b: {
                                            fontSize: 16,
                                            lineHeight: 33
                                        },
                                        per: {
                                            color: '#eee',
                                            backgroundColor: '#334455',
                                            padding: [2, 4],
                                            borderRadius: 2
                                        }
                                    },
                                },
                                data: pieData
                            }
                        ]

                    };
                    //为echarts对象加载数据
                    myChart.setOption(option);
                    window.onresize = myChart.resize;
                },
                error: function () {
                    alert("电影类型与数量数据请求失败！");
                },
            });
        }

    </script>
</head>
<body>

<div id="ScoreAndCommenter">
    <input class="btn btn-info" type="button" value="加载散点图数据" onclick="loadScatterData()"/>
    <input class="btn btn-info" type="button" value="加载饼图数据" onclick="loadPieData()"/>
</div>
<div class="container" id="main" style="width: 1000px;height: 600px"></div>
</body>
</html>
