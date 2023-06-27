<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/3/24 0024
  Time: 20:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>电影信息展示页面</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        #home,#scatter,#pie{
            margin-top: 15px;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="https://npmcdn.com/tether@1.2.4/dist/js/tether.min.js"></script>
    <script type="text/javascript" src="https://npmcdn.com/bootstrap@4.0.0-alpha.5/dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/echarts.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/theme/shine.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/theme/infographic.js"></script>
    <script type="text/javascript">
        //将array数组根据子串大小subGroupLength进行分组
        function group(array, subGroupLength) {
            var index = 0;
            var newArray = [];
            while (index < array.length) {
                var childArr = array.slice(index, index += subGroupLength);
                if (childArr.length < subGroupLength) {
                    var len = subGroupLength - childArr.length;
                    for (var i = 0; i < len; i++) {
                        childArr.push({});
                    }
                }
                newArray.push(childArr);
            }
            return newArray;
        }

        $(document).ready(function loadMovieInfo() {
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/movie/showMovieInfo",
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
                    var typeMap = ret.typeMap;
                    // alert(Object.getOwnPropertyNames(typeMap).length);
                    if (Object.getOwnPropertyNames(typeMap).length > 0) {
                        var typeItemList = [];
                        for (var k in typeMap) {
                            //获取同一类型的电影列表
                            var movieList = typeMap[k];
                            var movieNameList = [];
                            var movieItemList = [];

                            for (var i = 0; i < movieList.length; i++) {
                                movieNameList.push(movieList[i].movieName);
                                var director = movieList[i].director;
                                //将字符串中导演信息切分为列表
                                var directorList = director.split("    ");
                                var actors = movieList[i].actors;
                                //将字符串中演员信息切分为列表
                                var actorList = actors.split("    ");
                                var actorItemList = [];

                                var actorValue=movieList[i].movieScore / actorList.length;

                                for (var j = 0; j < actorList.length; j++) {
                                    var actorItem = {
                                        name: actorList[j],
                                        value:actorValue ,
                                    };
                                    actorItemList.push(actorItem);
                                }
                                //将演员信息根据导演列表再次进行分组
                                var dire_act_List = group(actorItemList, actorItemList.length / directorList.length);
                                var directorItemList = [];
                                for (var j = 0; j < directorList.length; j++) {
                                    var directorItem = {
                                        name: directorList[j],
                                        children: dire_act_List[j],
                                    };
                                    directorItemList.push(directorItem);
                                }
                                var movieItem = {
                                    name: movieList[i].movieName,
                                    children: directorItemList,
                                };
                                // console.log("movieItem: " + JSON.stringify(movieItem));
                                movieItemList.push(movieItem);
                            }
                            var typeItem = {
                                name: k,
                                children: movieItemList,
                            };
                            // console.log("typeItem: " + JSON.stringify(typeItem));
                            typeItemList.push(typeItem);
                        }
                        // 清理 echarts实例
                        document.getElementById("home").removeAttribute("_echarts_instance_");
                        //设置div样式
                        document.getElementById("home").style.height = '750px';
                        document.getElementById("home").style.width = '1200px';
                        var myChart = echarts.init(document.getElementById('home'), 'infographic');
                        var option = {
                            title: {
                                text: "电影数据详情",
                                subtext: '数据来自: 豆瓣网电影类型，电影名称，导演和演员信息',
                                sublink:'https://movie.douban.com/'
                            },
                            tooltip: {
                                trigger: 'item',
                                show: true,
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
                                // 设置类型为旭日图
                                type: 'sunburst',
                                center: ['50%', '50%'],
                                //文字以环绕方式显示
                                label: {
                                    rotate: 'radial',
                                },
                                data: typeItemList,
                                // 设置各层次的属性
                                levels: [{}, {
                                    // 设置圆环的内外半径
                                    r0: 25,
                                    r: 90,
                                    label: {
                                        rotate: 'radial',
                                    },
                                }, {
                                    r0: 90,
                                    r: 190,
                                    label: {
                                        // 文字右对齐
                                        align: 'right',
                                        fontSize: 12,
                                    },
                                }, {
                                    r0: 200,
                                    r: 235,
                                    itemStyle: {
                                        shadowBlur: 2,
                                    },
                                    label: {
                                        rotate: 'tangential',
                                        fontSize: 11.5,
                                    },
                                }, {
                                    r0: 240,
                                    r: 245,
                                    label: {
                                        // 文字位于色块外
                                        position: 'outside',
                                        fontSize: 11,
                                    },
                                    downplay: {
                                        label: {
                                            opacity: 0.5,
                                        }
                                    },
                                }],
                            }]
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
        //加载电影评分与评论人数关系
        $(document).ready(function loadScatterData() {
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
                            scoreAndCommenterList.push([movieList[i].movieScore, movieList[i].commenterNumber, movieList[i].movieName, movieList[i].filmInfo]);
                        }
                        var averageScore = sum / movieList.length;
                        document.getElementById("scatter").removeAttribute("_echarts_instance_");
                        //设置div样式
                        document.getElementById("scatter").style.height = '600px';
                        document.getElementById("scatter").style.width = '1200px';
                        var myChart = echarts.init(document.getElementById('scatter'), 'shine');
                        var option = {
                            title: {
                                text: "电影评论人数与电影评分关系",
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
                                show: true,
                                formatter: function (params) {
                                    return "<div>电影：《" + params.value[2] + '》'+'</div>'
                                        + "评分：" + params.value[0] + '分 ' + ' <br/>'
                                        + "评论：" + params.value[1] + '人次 ' + ' <br/>'
                                        + "描述：" + params.value[3];
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
                                data: ['评论人数'],
                                left: 'center'
                            },
                            xAxis: {
                                name:'电影评分',
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
                                name:'评论人次',
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
                                    //电影评分和评论人次信息
                                    data: scoreAndCommenterList,
                                    //数据分布区域
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
                                    //标注点
                                    markPoint: {
                                        data: [
                                            {type: 'max', name: '最大值'},
                                            {type: 'min', name: '最小值'}
                                        ]
                                    },
                                    //标注线
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
                    alert('请求电影评分和评论人次数据失败！');
                },
            });
        });
        //加载各种类型电影的占比情况数据
        $(document).ready(function loadPieData() {

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
                    var pieData = [], pieType = [];
                    if (typeList.length > 0 && numberList.length > 0) {
                        var sum = 0;
                        for (var i = 0; i < typeList.length; i++) {
                            if (i < 13) {
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
                    document.getElementById("pie").removeAttribute("_echarts_instance_");
                    //设置div样式
                    document.getElementById("pie").style.height = '600px';
                    document.getElementById("pie").style.width = '1200px';
                    var myChart = echarts.init(document.getElementById('pie'), 'infographic');
                    var option = {
                        title: {
                            text: "各类型电影数量及其占比数据",
                            subtext: '数据来自: 豆瓣网前250部电影中各种类型电影的所占比例',
                            sublink:'https://movie.douban.com/'
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
                            top: 'center',
                            data: pieType
                        },
                        toolbox: {
                            show: true,
                            feature: {
                                dataView: {readOnly: true},
                                restore: {show: true},
                                saveAsImage: {show: true},
                            }
                        },
                        series: [
                            {
                                name: '电影数量及占比信息',
                                //图表类型为饼图
                                type: 'pie',
                                radius: ['25%', '55%'],
                                center: ['50%', '50%'],
                                // 单选模式
                                selectedMode: 'single',
                                label: {
                                    //数据的显示格式
                                    formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
                                    backgroundColor: '#eee',
                                    // 边框属性
                                    borderColor: '#aaa',
                                    borderWidth: 1,
                                    borderRadius: 4,
                                    //设置阴影效果
                                    shadowBlur: 3,
                                    shadowOffsetX: 2,
                                    shadowOffsetY: 2,
                                    shadowColor: '#999',
                                    //内边距
                                    padding: [0, 7],
                                    //定义tooltip中的显示样式
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
                        ]};
                    //为echarts对象加载数据
                    myChart.setOption(option);
                    window.onresize = myChart.resize;
                },
                error: function () {
                    alert('请求电影类型数据失败！');
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
            <a class="nav-link active" role="tab" data-toggle="tab" href="#home">电影信息</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" role="tab" data-toggle="tab" href="#pie">类型分析</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" role="tab" data-toggle="tab" href="#scatter">评分分析</a>
        </li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div id="home"  class="container tab-pane active"> </div>
        <div id="pie" class="container tab-pane active"></div>
        <div id="scatter" class="container tab-pane active"></div>
    </div>
</div>
</body>
</html>
