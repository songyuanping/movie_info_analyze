<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/3/30 0030
  Time: 0:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>电影信息展示页面</title>
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
    <script type="text/javascript">
        $(document).ready(function loadCommentInfo() {
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/comment/showCommentInfo",
                //提交方式
                type: "GET",
                // data表示发送的数据
                data: [],
                // 定义发送请求的数据格式为JSON字符串
                contentType: "application/json; charset=UTF-8",
                //定义回调响应的数据格式为JSON字符串,该属性可以省略
                dataType: "json",
                //成功响应的结果
                success: function (ret) {
                    var yearItemMap = ret.yearItemMap;
                    // console.log(yearItemMap);
                    // alert(Object.getOwnPropertyNames(yearItemMap).length);
                    if (Object.getOwnPropertyNames(yearItemMap).length > 0) {
                        var seriesList = [], yearList = [], movieTypeList = ret.typeList;
                        for (var k in yearItemMap) {
                            //获取同一类型的电影列表
                            yearList.push(k);
                            var series = [];
                            for (var i = 0; i < yearItemMap[k].length; i++) {
                                var item = [
                                    yearItemMap[k][i].pariseCount,
                                    yearItemMap[k][i].commentCount,
                                    yearItemMap[k][i].movieType,
                                    yearItemMap[k][i].totalScore,
                                    yearItemMap[k][i].averageScore
                                ];
                                series.push(item);
                            }
                            seriesList.push(series);
                        }
                        // console.log(seriesList);

                        // 清理 echarts实例
                        document.getElementById("main").removeAttribute("_echarts_instance_");
                        var myChart = echarts.init(document.getElementById('main'), 'infographic');
                        var itemStyle = {
                            opacity: 0.8,
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowOffsetY: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        };
                        var option = {
                            baseOption: {
                                timeline: {
                                    name: '年 份',
                                    axisType: 'category',
                                    orient: 'vertical',
                                    autoPlay: true,
                                    inverse: true,
                                    playInterval: 1000,
                                    left: null,
                                    right: 0,
                                    top: 20,
                                    bottom: 20,
                                    width: 55,
                                    height: null,
                                    label: {
                                        color: '#999'
                                    },
                                    symbol: 'none',
                                    lineStyle: {
                                        color: '#555'
                                    },
                                    checkpointStyle: {
                                        color: '#bbb',
                                        borderColor: '#777',
                                        borderWidth: 2
                                    },
                                    controlStyle: {
                                        showNextBtn: false,
                                        showPrevBtn: false,
                                        color: '#666',
                                        borderColor: '#666'
                                    },
                                    emphasis: {
                                        label: {
                                            color: '#fff'
                                        },
                                        controlStyle: {
                                            color: '#aaa',
                                            borderColor: '#aaa'
                                        }
                                    },
                                    data: yearList
                                },
                                backgroundColor: '#404a59',
                                title: [{
                                    text: yearList[0],
                                    textAlign: 'center',
                                    left: '63%',
                                    top: '55%',
                                    textStyle: {
                                        fontSize: 100,
                                        color: 'rgba(255, 255, 255, 0.7)'
                                    }
                                }, {
                                    text: '各类型电影评论数据变化',
                                    left: 'center',
                                    top: 10,
                                    textStyle: {
                                        color: '#a9aba8',
                                        fontWeight: 'normal',
                                        fontSize: 20
                                    }
                                }],
                                tooltip: {
                                    padding: 5,
                                    // backgroundColor: '#232425',
                                    borderColor: '#767879',
                                    borderWidth: 1,
                                    formatter: function (obj) {
                                        var value = obj.value;
                                        return '<div style="border-bottom: 1px solid rgba(255,255,255,.3); font-size: 18px;padding-bottom: 7px;margin-bottom: 7px">'
                                            + '电影类型：' + ' ' + value[2]
                                            + '</div>'
                                            + '点赞数：' + value[0] + '<br>'
                                            + '评论数量：' + value[1] + '<br>'
                                            + '平均评分：' + value[4];
                                    }
                                },
                                grid: {
                                    top: 100,
                                    containLabel: true,
                                    left: 30,
                                    right: '110'
                                },
                                xAxis: {
                                    type: 'value',
                                    name: '点赞数量',
                                    nameLocation: 'middle',
                                    nameTextStyle: {
                                        fontSize: 18,
                                        padding: 6
                                    },
                                    splitLine: {
                                        show: false
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#ccc'
                                        }
                                    },
                                    axisLabel: {
                                        formatter: '{value} 次'
                                    }
                                },
                                yAxis: {
                                    type: 'value',
                                    name: '评论数量',
                                    // max: 5000,
                                    nameTextStyle: {
                                        color: '#ccc',
                                        fontSize: 18
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#ccc'
                                        }
                                    },
                                    splitLine: {
                                        show: false
                                    },
                                    axisLabel: {
                                        formatter: '{value} 条'
                                    }
                                },
                                visualMap: [
                                    {
                                        show: false,
                                        dimension: 2,
                                        categories: movieTypeList,
                                        calculable: true,
                                        precision: 0.1,
                                        textStyle: {
                                            color: '#cccccc'
                                        },
                                        inRange: {
                                            color: (function () {
                                                var colors = [
                                                    '#FFAE57', '#209864', '#EA5151', '#CCFF00',
                                                    '#9A2555', '#bcd3bb', '#e88f70', '#edc1a5',
                                                    '#25b5b5', '#f0b489', '#928ea8', '#003377',
                                                    "#1DE9B6", "#04B9FF", "#5DBD32", "#FFC809",
                                                    "#FB95D5", "#BDA29A", "#6E7074", "#546570",
                                                    "#37A2DA", "#32C5E9", "#9FE6B8", "#FFDB5C",
                                                    "#FF9F7F", "#FB7293", "#E062AE", "#E690D1",
                                                    "#E7BCF3", "#8378EA",
                                                ];
                                                return colors.concat(colors);
                                            })()
                                        }
                                    }
                                ],
                                series: [
                                    {
                                        type: 'scatter',
                                        itemStyle: itemStyle,
                                        data: seriesList[0],
                                        symbolSize: function (val) {
                                            if (val[4] > 30) {
                                                return (val[4] - 30) * 3;
                                            } else {
                                                return val[4];
                                            }
                                        }
                                    }
                                ],
                                animationDurationUpdate: 1000,
                                animationEasingUpdate: 'quinticInOut'
                            },
                            options: []
                        };

                        for (var n = 0; n < yearList.length; n++) {
                            option.options.push({
                                title: {
                                    show: true,
                                    'text': yearList[n]
                                },
                                series: {
                                    name: yearList[n],
                                    type: 'scatter',
                                    itemStyle: itemStyle,
                                    data: seriesList[n],
                                    symbolSize: function (val) {
                                        if (val[4] > 30) {
                                            return (val[4] - 30) * 3;
                                        } else {
                                            return val[4];
                                        }
                                    }
                                }
                            });
                        }
                    };
                    //为echarts对象加载数据
                    myChart.setOption(option);
                    window.onresize = myChart.resize;
                },
                error: function () {
                    alert('${message}');
                },
            });
        });
    </script>

</head>
<body>
<div id="main" class="container" style="width: 1200px;height: 600px"></div>
</body>
</html>
