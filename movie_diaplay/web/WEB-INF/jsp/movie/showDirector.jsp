<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/6 0006
  Time: 22:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>导演词频分析</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/static/css/font-awesome-4.7.0/css/font-awesome.min.css"
          rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/echarts.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/echarts/echarts-wordcloud.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/echarts/theme/shine.js"></script>
    <script type="text/javascript">
        $(document).ready(function loadDirectorCount() {
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/movie/showDirectorCount",
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
                    var directorMap = ret.directorMap;
                    // alert(Object.getOwnPropertyNames(directorMap).length);
                    if (Object.getOwnPropertyNames(directorMap).length > 0) {
                        var directorList = [];
                        for (var director in directorMap) {
                            var directorItem = {
                                name: director,
                                value: directorMap[director],
                            };
                            directorList.push(directorItem);
                        }
                        // console.log("length: " + directorList.length);
                        var option = {
                            //图表标题
                            title: [{
                                text: '导演数据分析',
                                subtext: '依据导演所拍电影数量的词云图',
                                top: 10,
                                textStyle: {
                                    color: 'rgba(22,33,44,0.95)',
                                    fontWeight: 'normal',
                                    fontSize: 20
                                }
                            }],
                            tooltip: {
                                padding: 5,
                                backgroundColor: '#232425',
                                borderColor: '#767879',
                                borderWidth: 1,
                                formatter: function (obj) {
                                    return '导  演：' + ' ' + obj.name + '<br>'
                                        + '指导电影数量：' + obj.value[0] + '<br>'
                                        + '电影平均评分：' + obj.value[1]
                                }
                            },
                            toolbox: {
                                show: true,
                                feature: {
                                    dataView: {readOnly: false},
                                    restore: {show: true},
                                    saveAsImage: {show: true},
                                }
                            },
                            series: [{
                                name: '导演数据分析',
                                //图表类型为词云图
                                type: 'wordCloud',
                                //形状
                                shape: 'circle',
                                sizeRange: [20, 60],//文字范围
                                //文本旋转范围，文本将通过rotationStep45在[-90,90]范围内随机旋转
                                rotationRange: [-45, 90],
                                rotationStep: 45,
                                textRotation: [0, 45, 90, -45],
                                left: 'center',
                                top: 'center',
                                right: null,
                                bottom: null,
                                textStyle: {
                                    normal: {
                                        fontFamily: 'sans-serif',
                                        fontWeight: 'bold',
                                        color: function () {
                                            //设置文字颜色的随机色
                                            return 'rgb(' + [
                                                Math.round(Math.random() * 200),
                                                Math.round(Math.random() * 200),
                                                Math.round(Math.random() * 200)
                                            ].join(',') + ')';
                                        }
                                    },
                                    //悬停上去的颜色设置
                                    emphasis: {
                                        shadowBlur: 3,
                                        shadowColor: '#666'
                                    }
                                },
                                //要显示的数据
                                data: directorList
                            }]
                        };
                        // 清理 echarts实例
                        document.getElementById("director").removeAttribute("_echarts_instance_");
                        document.getElementById("director").style.height = '600px';
                        document.getElementById("director").style.width = '1200px';
                        var myChart = echarts.init(document.getElementById('director'), 'shine');
                        //使用制定的配置项和数据显示图表
                        myChart.setOption(option);
                        window.onresize = myChart.resize;
                    }
                },
                error: function () {
                    alert('${message}');
                },
            });
        });
        $(document).ready(function loadActorsCount() {
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/movie/showActorsCount",
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
                    var actorsMap = ret.actorsMap;
                    // alert(Object.getOwnPropertyNames(actorsMap).length);
                    // console.log(actorsMap);

                    if (Object.getOwnPropertyNames(actorsMap).length > 0) {
                        var actorList = [];
                        for (var actor in actorsMap) {
                            var actorItem = {
                                name: actor,
                                value: actorsMap[actor],
                            };
                            actorList.push(actorItem);
                        }
                        // var maskImage=new Image();
                        // maskImage.src='';
                        var option = {
                            title: [{
                                text: '演员数据分析',
                                subtext: '依据演员参演的电影数量词云图',
                                top: 10,
                                textStyle: {
                                    color: 'rgba(22,33,44,0.95)',
                                    fontWeight: 'normal',
                                    fontSize: 20
                                }
                            }],
                            tooltip: {
                                padding: 5,
                                backgroundColor: '#232425',
                                borderColor: '#767879',
                                borderWidth: 1,
                                formatter: function (obj) {
                                    return '演  员：' + ' ' + obj.name + '<br>'
                                        + '参演影片数量：' + obj.value[0] + '<br>'
                                }
                            },
                            toolbox: {
                                show: true,
                                feature: {
                                    dataView: {readOnly: false},
                                    restore: {show: true},
                                    saveAsImage: {show: true},
                                }
                            },
                            animationDurationUpdate: function(idx) {
                                // 越往后的数据延迟越大
                                return idx * 100;
                            },
                            animationEasingUpdate: 'bounceIn',
                            series: [
                                {
                                name: '演员数据分析',
                                type: 'wordCloud',
                                //形状
                                shape: 'smooth',  //平滑
                                sizeRange: [20, 60],//文字范围
                                //文本旋转范围，文本将通过rotationStep45在[-90,90]范围内随机旋转
                                rotationRange: [-45, 90],
                                rotationStep: 45,
                                textRotation: [0, 45, 90, -45],
                                left: 'center',
                                top: 'center',
                                // gridSize: 8,
                                // maskImage: maskImage,
                                textStyle: {
                                    normal: {
                                        fontFamily: 'sans-serif',
                                        fontWeight: 'bold',
                                        color: function () {//文字颜色的随机色
                                            return 'rgba(' + [
                                                Math.round(Math.random() * 200),
                                                Math.round(Math.random() * 200),
                                                Math.round(Math.random() * 200), 0.95
                                            ].join(',') + ')';
                                        }
                                    },
                                    //悬停上去的颜色设置
                                    emphasis: {
                                        shadowBlur: 3,
                                        shadowColor: '#666'
                                    }
                                },
                                data: actorList
                            }
                            ]
                        };
                        // 清理 echarts实例
                        document.getElementById("actor").removeAttribute("_echarts_instance_");
                        document.getElementById("actor").style.height = '600px';
                        document.getElementById("actor").style.width = '1200px';
                        var myChart = echarts.init(document.getElementById('actor'), 'shine');
                        //使用制定的配置项和数据显示图表
                        myChart.setOption(option);
                        window.onresize = myChart.resize;
                    }
                },
                error: function () {
                    alert('${message}');
                },
            });
        });
        $(document).ready(function loadCommenterCount() {
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/comment/showCommenterCount",
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
                    var commenterMap = ret.commenterMap;
                    // alert(Object.getOwnPropertyNames(commenterMap).length);
                    // console.log(commenterMap);

                    if (Object.getOwnPropertyNames(commenterMap).length > 0) {
                        var commenterList = [];
                        for (var commenter in commenterMap) {
                            var commenterItem = {
                                name: commenter,
                                value: commenterMap[commenter],
                            };
                            commenterList.push(commenterItem);
                        }
                        // var maskImage=new Image();
                        // maskImage.src='';
                        var option = {
                            title: [{
                                text: '用户评论数据分析',
                                subtext: '依据用户的评论数量而成词云图',
                                top: 10,
                                textStyle: {
                                    color: 'rgba(22,33,44,0.95)',
                                    fontWeight: 'normal',
                                    fontSize: 20
                                }
                            }],
                            tooltip: {
                                padding: 5,
                                backgroundColor: '#232425',
                                borderColor: '#767879',
                                borderWidth: 1,
                                formatter: function (obj) {
                                    return '用   户：' + ' ' + obj.name + '<br>'
                                        +  '评论数量：' + obj.value[0] + '<br>'
                                }
                            },
                            toolbox: {
                                show: true,
                                feature: {
                                    dataView: {readOnly: false},
                                    restore: {show: true},
                                    saveAsImage: {show: true},
                                }
                            },
                            series: [{
                                name: '用户评论数据分析',
                                type: 'wordCloud',
                                //形状
                                shape: 'smooth',  //平滑
                                sizeRange: [20, 60],//文字范围
                                //文本旋转范围，文本将通过rotationStep45在[-90,90]范围内随机旋转
                                rotationRange: [-45, 90],
                                rotationStep: 45,
                                textRotation: [0, 45, 90, -45],
                                left: 'center',
                                top: 'center',
                                // gridSize: 8,
                                // maskImage: maskImage,
                                textStyle: {
                                    normal: {
                                        fontFamily: 'sans-serif',
                                        fontWeight: 'bold',
                                        color: function () {//文字颜色的随机色
                                            return 'rgba(' + [
                                                Math.round(Math.random() * 200),
                                                Math.round(Math.random() * 200),
                                                Math.round(Math.random() * 200), 0.95
                                            ].join(',') + ')';
                                        }
                                    },
                                    //悬停上去的颜色设置
                                    emphasis: {
                                        shadowBlur: 3,
                                        shadowColor: '#666'
                                    }
                                },
                                data: commenterList
                            }]
                        };
                        // 清理 echarts实例
                        document.getElementById("commenter").removeAttribute("_echarts_instance_");
                        document.getElementById("commenter").style.height = '600px';
                        document.getElementById("commenter").style.width = '1200px';
                        var myChart = echarts.init(document.getElementById('commenter'), 'shine');
                        //使用制定的配置项和数据显示图表
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
<div class="container">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs " role="tablist">
        <li class="nav-item">
            <a class="nav-link active" role="tab" data-toggle="tab" href="#director">导演指导</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" role="tab" data-toggle="tab" href="#actor">演员出演</a>
        </li>
        <li class="nav-item">
        <a class="nav-link" role="tab" data-toggle="tab" href="#commenter">用户评论</a>
        </li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
        <div id="director" class="container tab-pane active"></div>
        <div id="actor" class="container tab-pane active"></div>
        <div id="commenter" class="container tab-pane active"></div>
    </div>
</div>
</body>
</html>
