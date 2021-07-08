<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>系统主页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/static/css/font-awesome-4.7.0/css/font-awesome.min.css"
          rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        #top-hcontent {
            font-size: 250px;
            line-height: 1.42857143;
            position: absolute;
            top: 40%;
            margin-top: -100px;
            z-index: 20;
            color: white;
            text-align: center;
            width: 80%;
            margin-left: 11%;
        }

        #top-acontent {
            -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
            font-size: 14px;
            line-height: 1.42857143;
            font-weight: 300;
            box-sizing: border-box;
            position: absolute;
            top: 50%;
            height: 200px;
            margin-top: -100px;
            z-index: 20;
            color: white;
            text-align: center;
            width: 80%;
            left: 0;
            margin-left: 10%;
        }

        #top-acontent a {
            width: 140px;
            height: 40px;
            font-size: 18px;
            border: white 1px solid;
            border-radius: 20px;
            box-sizing: border-box;
            color: white;
            margin-left: 45px;
        }

        #top-acontent a:link {
            color: white;
            background-color: transparent;
            text-decoration: none;
        }

        #top-acontent a:hover, a:active {
            color: black;
            background-color: white;
        }

        #head_nav a:active {
            background-color: #333333;
        }

        #collapsibleNavbar a:active {
            background-color: #333333;
        }

        #about-section {
            margin-bottom: 0;
            -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
            font-size: 16px;
            line-height: 1.42857143;
            color: #9297A3;
            font-weight: 300;
            box-sizing: border-box;
            display: block;
            background-color: #F4F7FC;
            padding-top: 50px;
            padding-bottom: 50px;
            text-align: center;
        }

        #about-section a {
            width: 100px;
            height: 40px;
            font-size: 18px;
            border: white;
            border-radius: 35px;
            box-sizing: border-box;
            color: white;
            /*margin-left: 45px;*/
        }

        #about-section a:link {
            color: white;
            background-color: orangered;
            text-decoration: none;
        }

        #about-section a:hover, a:active {
            border-color: white;
            color: black;
        }

    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/echarts.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/world.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/china.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/theme/shine.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts/theme/dark.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/static/js/echarts/theme/infographic.js"></script>
    <script type="text/javascript">
        //加载电影票房数据
        function loadMovieSells() {
            var uploadedDataURL = "${pageContext.request.contextPath }/static/json/data-1528971808162-BkOXf61WX.json";

            //geoCoordMap把所有可能出现的城市加到数组里面
            var geoCoordMap = {
                "杭州": [119.5313, 29.8773],
                "苏州": [118.8062, 31.9208],
                '上海': [121.4648, 31.2891],
                "天津": [117.4219, 39.4189],
                '深圳': [114.072026, 22.552194],
                "成都": [103.9526, 30.7617],
                "郑州": [113.4668, 34.6234],
                "宁波": [121.640618, 29.86206],
                "合肥": [117.29, 32.0581],
                "重庆": [108.384366, 30.439702],
                "广州": [113.12244, 23.009505],
                "大连": [123.1238, 42.1216],
                "青岛": [117.1582, 36.8701],
                '北京': [116.4551, 40.2539],
                '义乌': [120.067209, 29.346921],
                '东莞': [113.764742, 23.02039],
                "长沙": [113.0823, 28.2568],
                "贵阳": [106.6992, 26.7682],
                '珠海': [113.556111, 22.250876],
                '威海': [122.109148, 37.516889],
                "泉州": [118.58, 24.93],
                "赤峰": [118.87, 42.28],
                "厦门": [118.1, 24.46],
                "福州": [119.3, 26.08],
                "抚顺": [123.97, 41.97],
                "汕头": [116.69, 23.39],
                "宁波": [121.56, 29.86],
                "海口": [110.35, 20.02],
                "岳阳": [113.09, 29.37],
                "武汉": [114.31, 30.52],
                "义乌": [120.06, 29.32],
                "唐山": [118.02, 39.63],
                "石家庄": [114.48, 38.03],
                "哈尔滨": [126.63, 45.75],
                "兰州": [103.73, 36.03],
                "贵阳": [106.71, 26.57],
                "呼和浩特": [111.65, 40.82],
                "南昌": [115.89, 28.68],
                "佛山": [113.11, 23.05],
                "汕头": [116.69, 23.39],
                "烟台": [121.39, 37.52],
                "威海": [122.1, 37.5],
            };

            //2013年数据
            var d1 = {
                "杭州": 10,
                "苏州": 2,
                '上海': 21,
                "天津": 4,
                '深圳': 7,
                "郑州": 7,
                "成都": 5,
                "宁波": 2,
                "合肥": 1,
                "重庆": 3,
                "广州": 19,
                "大连": 1,
                "青岛": 2,
                '北京': 16,
                '义乌': 2,
                '东莞': 1,
                "长沙": 3,
                "贵阳": 0,
                '珠海': 0,
                '威海': 0,
                '南昌': 1,
                '西安': 2,
                '南京': 6,
                '海口': 0,
                '厦门': 3,
                '沈阳': 3,
                '无锡': 0,
                '呼和浩特': 0,
                '长春': 0,
                '哈尔滨': 1,
                '武汉': 5,
                '南宁': 1,
                '昆明': 1,
                '兰州': 0,
                '唐山': 0,
                '石家庄': 2,
                '太原': 1,
                '赤峰': 0,
                '抚顺': 0,
                '珲春': 0,
                '绥芬河': 0,
                '徐州': 0,
                '南通': 1,
                '温州': 2,
                '绍兴': 0,
                '芜湖': 0,
                '福州': 5,
                '泉州': 2,
                '赣州': 2,
                '济南': 3,
                '烟台': 0,
                '洛阳': 1,
                '黄石': 0,
                '岳阳': 0,
                '汕头': 0,
                '佛山': 0,
                '泸州': 0,
                '海东': 0,
                '银川': 0,
            };

            //2014年数据
            var d2 = {
                "杭州": 131,
                "苏州": 51,
                '上海': 114,
                "天津": 58,
                '深圳': 104,
                "郑州": 66,
                "成都": 35,
                "宁波": 59,
                "合肥": 28,
                "重庆": 68,
                "广州": 120,
                "大连": 24,
                "青岛": 58,
                '北京': 118,
                '义乌': 36,
                '东莞': 46,
                "长沙": 34,
                "贵阳": 8,
                '珠海': 11,
                '威海': 7,
                '南昌': 24,
                '西安': 35,
                '南京': 42,
                '海口': 6,
                '厦门': 59,
                '沈阳': 18,
                '无锡': 21,
                '呼和浩特': 7,
                '长春': 13,
                '哈尔滨': 16,
                '武汉': 52,
                '南宁': 14,
                '昆明': 10,
                '兰州': 5,
                '唐山': 3,
                '石家庄': 24,
                '太原': 13,
                '赤峰': 0,
                '抚顺': 0,
                '珲春': 1,
                '绥芬河': 3,
                '徐州': 5,
                '南通': 12,
                '温州': 32,
                '绍兴': 11,
                '芜湖': 3,
                '福州': 72,
                '泉州': 47,
                '赣州': 3,
                '济南': 40,
                '烟台': 14,
                '洛阳': 7,
                '黄石': 1,
                '岳阳': 1,
                '汕头': 8,
                '佛山': 31,
                '泸州': 0,
                '海东': 0,
                '银川': 37,
            };
            //2015年数据
            var d3 = {
                "杭州": 311,
                "苏州": 174,
                '上海': 308,
                "天津": 192,
                '深圳': 304,
                "郑州": 194,
                "成都": 179,
                "宁波": 191,
                "合肥": 130,
                "重庆": 189,
                "广州": 345,
                "大连": 139,
                "青岛": 182,
                '北京': 336,
                '义乌': 136,
                '东莞': 159,
                "长沙": 151,
                "贵阳": 81,
                '珠海': 96,
                '威海': 80,
                '南昌': 112,
                '西安': 163,
                '南京': 155,
                '海口': 59,
                '厦门': 170,
                '沈阳': 102,
                '无锡': 110,
                '呼和浩特': 54,
                '长春': 76,
                '哈尔滨': 113,
                '武汉': 187,
                '南宁': 104,
                '昆明': 100,
                '兰州': 48,
                '唐山': 48,
                '石家庄': 110,
                '太原': 80,
                '赤峰': 8,
                '抚顺': 7,
                '珲春': 19,
                '绥芬河': 16,
                '徐州': 63,
                '南通': 78,
                '温州': 111,
                '绍兴': 88,
                '芜湖': 29,
                '福州': 189,
                '泉州': 148,
                '赣州': 31,
                '济南': 161,
                '烟台': 85,
                '洛阳': 49,
                '黄石': 10,
                '岳阳': 15,
                '汕头': 74,
                '佛山': 153,
                '泸州': 10,
                '海东': 0,
                '银川': 34,
            };
            //2016年数据
            var d4 = {
                "杭州": 296,
                "苏州": 184,
                '上海': 332,
                "天津": 136,
                '深圳': 327,
                "郑州": 208,
                "成都": 235,
                "宁波": 200,
                "合肥": 142,
                "重庆": 191,
                "广州": 327,
                "大连": 154,
                "青岛": 168,
                '北京': 358,
                '义乌': 133,
                '东莞': 166,
                "长沙": 159,
                "贵阳": 81,
                '珠海': 86,
                '威海': 58,
                '南昌': 118,
                '西安': 180,
                '南京': 170,
                '海口': 78,
                '厦门': 160,
                '沈阳': 114,
                '无锡': 119,
                '呼和浩特': 80,
                '长春': 92,
                '哈尔滨': 123,
                '武汉': 190,
                '南宁': 122,
                '昆明': 128,
                '兰州': 69,
                '唐山': 60,
                '石家庄': 118,
                '太原': 93,
                '赤峰': 16,
                '抚顺': 9,
                '珲春': 21,
                '绥芬河': 16,
                '徐州': 78,
                '南通': 93,
                '温州': 122,
                '绍兴': 95,
                '芜湖': 36,
                '福州': 187,
                '泉州': 148,
                '赣州': 47,
                '济南': 161,
                '烟台': 87,
                '洛阳': 55,
                '黄石': 11,
                '岳阳': 26,
                '汕头': 78,
                '佛山': 150,
                '泸州': 10,
                '海东': 0,
                '银川': 45,
            };
            //2017年数据
            var d5 = {
                "杭州": 334,
                "苏州": 185,
                '上海': 313,
                "天津": 181,
                '深圳': 379,
                "郑州": 231,
                "成都": 215,
                "宁波": 183,
                "合肥": 145,
                "重庆": 205,
                "广州": 344,
                "大连": 166,
                "青岛": 170,
                '北京': 351,
                '义乌': 150,
                '东莞': 176,
                "长沙": 174,
                "贵阳": 89,
                '珠海': 91,
                '威海': 61,
                '南昌': 135,
                '西安': 181,
                '南京': 183,
                '海口': 80,
                '厦门': 167,
                '沈阳': 130,
                '无锡': 121,
                '呼和浩特': 89,
                '长春': 122,
                '哈尔滨': 139,
                '武汉': 219,
                '南宁': 138,
                '昆明': 125,
                '兰州': 71,
                '唐山': 71,
                '石家庄': 136,
                '太原': 127,
                '赤峰': 47,
                '抚顺': 9,
                '珲春': 30,
                '绥芬河': 21,
                '徐州': 88,
                '南通': 90,
                '温州': 138,
                '绍兴': 92,
                '芜湖': 26,
                '福州': 283,
                '泉州': 158,
                '赣州': 30,
                '济南': 171,
                '烟台': 81,
                '洛阳': 86,
                '黄石': 15,
                '岳阳': 41,
                '汕头': 96,
                '佛山': 165,
                '泸州': 49,
                '海东': 0,
                '银川': 70,

            };
            //2018年数据
            var d6 = {
                "杭州": 365,
                "苏州": 213,
                '上海': 352,
                "天津": 187,
                '深圳': 430,
                "郑州": 251,
                "成都": 226,
                "宁波": 196,
                "合肥": 165,
                "重庆": 234,
                "广州": 364,
                "大连": 151,
                "青岛": 193,
                '北京': 358,
                '义乌': 162,
                '东莞': 197,
                "长沙": 212,
                "贵阳": 94,
                '珠海': 108,
                '威海': 70,
                '南昌': 167,
                '西安': 188,
                '南京': 203,
                '海口': 102,
                '厦门': 187,
                '沈阳': 148,
                '无锡': 133,
                '呼和浩特': 88,
                '长春': 121,
                '哈尔滨': 143,
                '武汉': 224,
                '南宁': 153,
                '昆明': 144,
                '兰州': 77,
                '唐山': 98,
                '石家庄': 150,
                '太原': 147,
                '赤峰': 16,
                '抚顺': 16,
                '珲春': 31,
                '绥芬河': 18,
                '徐州': 98,
                '南通': 106,
                '温州': 153,
                '绍兴': 112,
                '芜湖': 36,
                '福州': 196,
                '泉州': 178,
                '赣州': 71,
                '济南': 165,
                '烟台': 88,
                '洛阳': 78,
                '黄石': 14,
                '岳阳': 39,
                '汕头': 115,
                '佛山': 185,
                '泸州': 12,
                '海东': 1,
                '银川': 49,
            };
            //2019年数据
            var d7 = {
                "杭州": 352,
                "苏州": 204,
                '上海': 331,
                "天津": 168,
                '深圳': 421,
                "郑州": 271,
                "成都": 231,
                "宁波": 199,
                "合肥": 172,
                "重庆": 141,
                "广州": 365,
                "大连": 132,
                "青岛": 205,
                '北京': 239,
                '义乌': 147,
                '东莞': 193,
                "长沙": 213,
                "贵阳": 105,
                '珠海': 99,
                '威海': 76,
                '南昌': 163,
                '西安': 184,
                '南京': 193,
                '海口': 109,
                '厦门': 170,
                '沈阳': 147,
                '无锡': 138,
                '呼和浩特': 81,
                '长春': 126,
                '哈尔滨': 141,
                '武汉': 241,
                '南宁': 154,
                '昆明': 145,
                '兰州': 89,
                '唐山': 103,
                '石家庄': 146,
                '太原': 137,
                '赤峰': 33,
                '抚顺': 12,
                '珲春': 22,
                '绥芬河': 23,
                '徐州': 101,
                '南通': 100,
                '温州': 134,
                '绍兴': 102,
                '芜湖': 52,
                '福州': 190,
                '泉州': 156,
                '赣州': 80,
                '济南': 161,
                '烟台': 81,
                '洛阳': 100,
                '黄石': 24,
                '岳阳': 48,
                '汕头': 118,
                '佛山': 164,
                '泸州': 14,
                '海东': 0,
                '银川': 61,
            };

            var colors = [
                ["#1DE9B6", "#F46E36", "#04B9FF", "#5DBD32", "#FFC809", "#FB95D5", "#BDA29A", "#6E7074", "#546570", "#C4CCD3"],
                ["#37A2DA", "#67E0E3", "#32C5E9", "#9FE6B8", "#FFDB5C", "#FF9F7F", "#FB7293", "#E062AE", "#E690D1", "#E7BCF3", "#9D96F5", "#8378EA", "#8378EA"],
                ["#DD6B66", "#759AA0", "#E69D87", "#8DC1A9", "#EA7E53", "#EEDD78", "#73A373", "#73B9BC", "#7289AB", "#91CA8C", "#F49F42"],
            ];
            var colorIndex = 0;
            $(function () {
                var year = ["2013", "2014", "2015", "2016", "2017", "2018", "2019"];
                var mapData = [
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    []
                ];

                /*柱子Y名称*/
                var categoryData = [];
                var barData = [];

                for (var key in geoCoordMap) {
                    mapData[0].push({
                        "year": '2013',
                        "name": key,
                        "value": d1[key],
                    });
                    mapData[1].push({
                        "year": '2014',
                        "name": key,
                        "value": d2[key],
                    });
                    mapData[2].push({
                        "year": '2015',
                        "name": key,
                        "value": d3[key],
                    });
                    mapData[3].push({
                        "year": '2016',
                        "name": key,
                        "value": d4[key],
                    });
                    mapData[4].push({
                        "year": '2017',
                        "name": key,
                        "value": d5[key],
                    });
                    mapData[5].push({
                        "year": '2018',
                        "name": key,
                        "value": d6[key],
                    });
                    mapData[6].push({
                        "year": '2019',
                        "name": key,
                        "value": d7[key],
                    });
                }

                for (var i = 0; i < mapData.length; i++) {
                    mapData[i].sort(function sortNumber(a, b) {
                        return a.value - b.value
                    });
                    barData.push([]);
                    categoryData.push([]);
                    for (var j = 0; j < mapData[i].length; j++) {
                        barData[i].push(mapData[i][j].value);
                        categoryData[i].push(mapData[i][j].name);
                    }
                }

                $.getJSON(uploadedDataURL, function (geoJson) {

                    echarts.registerMap('china', geoJson);
                    var convertData = function (data) {
                        var res = [];
                        for (var i = 0; i < data.length; i++) {
                            var geoCoord = geoCoordMap[data[i].name];
                            if (geoCoord) {
                                res.push({
                                    name: data[i].name,
                                    value: geoCoord.concat(data[i].value)
                                });
                            }
                        }
                        return res;
                    };

                    optionXyMap01 = {
                        timeline: {
                            data: year,
                            axisType: 'category',
                            autoPlay: true,
                            playInterval: 3000,
                            left: '10%',
                            right: '10%',
                            bottom: '3%',
                            width: '80%',
                            label: {
                                normal: {
                                    textStyle: {
                                        color: '#ddd'
                                    }
                                },
                                emphasis: {
                                    textStyle: {
                                        color: '#fff'
                                    }
                                }
                            },
                            symbolSize: 10,
                            lineStyle: {
                                color: '#555'
                            },
                            checkpointStyle: {
                                borderColor: '#777',
                                borderWidth: 2
                            },
                            controlStyle: {
                                showNextBtn: true,
                                showPrevBtn: true,
                                normal: {
                                    color: '#666',
                                    borderColor: '#666'
                                },
                                emphasis: {
                                    color: '#aaa',
                                    borderColor: '#aaa'
                                }
                            },

                        },
                        baseOption: {
                            animation: true,
                            animationDuration: 1000,
                            animationEasing: 'cubicInOut',
                            animationDurationUpdate: 1000,
                            animationEasingUpdate: 'cubicInOut',
                            grid: {
                                right: '1%',
                                top: '15%',
                                bottom: '10%',
                                width: '20%'
                            },
                            tooltip: {
                                trigger: 'axis', // hover触发器
                                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow', // 默认为直线，可选为：'line' | 'shadow'
                                    shadowStyle: {
                                        color: 'rgba(150,150,150,0.1)' //hover颜色
                                    }
                                }
                            },
                            geo: {
                                show: true,
                                map: 'china',
                                roam: false,
                                zoom: 1,
                                center: [113.83531246, 34.0267395887],
                                label: {
                                    emphasis: {
                                        show: false
                                    }
                                },
                                itemStyle: {
                                    normal: {
                                        borderColor: 'rgba(147, 235, 248, 1)',
                                        borderWidth: 1,
                                        areaColor: {
                                            type: 'radial',
                                            x: 0.5,
                                            y: 0.5,
                                            r: 0.8,
                                            colorStops: [{
                                                offset: 0,
                                                color: 'rgba(147, 235, 248, 0)' // 0% 处的颜色
                                            }, {
                                                offset: 1,
                                                color: 'rgba(147, 235, 248, .2)' // 100% 处的颜色
                                            }],
                                            globalCoord: false // 缺省为 false
                                        },
                                        shadowColor: 'rgba(128, 217, 248, 1)',
                                        // shadowColor: 'rgba(255, 255, 255, 1)',
                                        shadowOffsetX: -2,
                                        shadowOffsetY: 2,
                                        shadowBlur: 10
                                    },
                                    emphasis: {
                                        areaColor: '#389BB7',
                                        borderWidth: 0
                                    }
                                }
                            },
                        },
                        options: []

                    };

                    for (var n = 0; n < year.length; n++) {
                        optionXyMap01.options.push({
                            backgroundColor: '#013954',
                            title:
                                [{
                                    text: '国内电影票房统计数据',
                                    left: '25%',
                                    top: '7%',
                                    textStyle: {
                                        color: '#fff',
                                        fontSize: 25
                                    }
                                }, {
                                    id: 'statistic',
                                    text: year[n] + "数据统计情况",
                                    left: '75%',
                                    top: '6%',
                                    textStyle: {
                                        color: '#fff',
                                        fontSize: 25
                                    }
                                }
                                ],
                            xAxis: {
                                type: 'value',
                                scale: true,
                                position: 'top',
                                min: 0,
                                boundaryGap: false,
                                splitLine: {
                                    show: false
                                },
                                axisLine: {
                                    show: false
                                },
                                axisTick: {
                                    show: false
                                },
                                axisLabel: {
                                    margin: 2,
                                    textStyle: {
                                        color: '#aaa'
                                    }
                                },
                            },
                            yAxis: {
                                type: 'category',
                                // name: 'TOP 20',
                                nameGap: 16,
                                axisLine: {
                                    show: true,
                                    lineStyle: {
                                        color: '#ddd'
                                    }
                                },
                                axisTick: {
                                    show: false,
                                    lineStyle: {
                                        color: '#ddd'
                                    }
                                },
                                axisLabel: {
                                    interval: 0,
                                    textStyle: {
                                        color: '#ddd'
                                    }
                                },
                                data: categoryData[n]
                            },

                            series: [
                                //地图
                                {
                                    type: 'map',
                                    map: 'china',
                                    geoIndex: 0,
                                    aspectScale: 0.75, //长宽比
                                    showLegendSymbol: false, // 存在legend时显示
                                    label: {
                                        normal: {
                                            show: false
                                        },
                                        emphasis: {
                                            show: false,
                                            textStyle: {
                                                color: '#fff'
                                            }
                                        }
                                    },
                                    roam: false,
                                    itemStyle: {
                                        normal: {
                                            areaColor: '#031525',
                                            borderColor: '#FFFFFF',
                                        },
                                        emphasis: {
                                            areaColor: '#2B91B7'
                                        }
                                    },
                                    animation: false,
                                    data: mapData
                                },
                                //地图中闪烁的点
                                {
                                    //  name: 'Top 5',
                                    type: 'effectScatter',
                                    coordinateSystem: 'geo',
                                    data: convertData(mapData[n].sort(function (a, b) {
                                        return b.value - a.value;
                                    }).slice(0, 20)),
                                    symbolSize: function (val) {
                                        return val[2] / 10;
                                    },
                                    showEffectOn: 'render',
                                    rippleEffect: {
                                        brushType: 'stroke'
                                    },
                                    hoverAnimation: true,
                                    label: {
                                        normal: {
                                            formatter: '{b}',
                                            position: 'right',
                                            show: true
                                        }
                                    },
                                    itemStyle: {
                                        normal: {
                                            color: colors[colorIndex][n],
                                            shadowBlur: 10,
                                            shadowColor: colors[colorIndex][n]
                                        }
                                    },
                                    zlevel: 1
                                },
                                //柱状图
                                {
                                    zlevel: 1.5,
                                    type: 'bar',
                                    symbol: 'none',
                                    itemStyle: {
                                        normal: {
                                            color: colors[colorIndex][n]
                                        }
                                    },
                                    data: barData[n]
                                }
                            ]
                        })
                    }
                    // 清理 echarts实例
                    document.getElementById("main").removeAttribute("_echarts_instance_");
                    var myChart = echarts.init(document.getElementById('main'), 'shine');
                    myChart.setOption(optionXyMap01);
                });
            });
        }

        //加载电影名称信息至单选列表中
        function loadMovieNameList() {
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/movie/listMovieName",
                //提交方式
                type: "POST",
                // data表示发送的数据
                data: [],
                // 定义发送请求的数据格式为JSON字符串
                contentType: "application/json; charset=UTF-8",
                //定义回调响应的数据格式为JSON字符串,该属性可以省略
                dataType: "json",
                //成功响应的结果
                success: function (nameList) {
                    var id1 = Math.floor(Math.random() * nameList.length);
                    var id2 = Math.floor(Math.random() * nameList.length);
                    for (var i = 0; i < nameList.length; i++) {
                        if (i === id1) {
                            document.getElementById("select_movie1").options[i] = new Option(nameList[i], nameList[i], true, true);
                            document.getElementById("select_movie2").options[i] = new Option(nameList[i], nameList[i]);
                        } else if (i === id2) {
                            document.getElementById("select_movie1").options[i] = new Option(nameList[i], nameList[i]);
                            document.getElementById("select_movie2").options[i] = new Option(nameList[i], nameList[i], true, true);
                        } else {
                            document.getElementById("select_movie1").options[i] = new Option(nameList[i], nameList[i]);
                            document.getElementById("select_movie2").options[i] = new Option(nameList[i], nameList[i]);
                        }
                    }
                },
                error: function () {
                    alert('电影名称数据请求失败');
                },
            });
        }

        // 获取输入的电影名称
        function movieElementCompare() {
            var movieName1 = $('#select_movie1').val();
            var movieName2 = $('#select_movie2').val();
            if (movieName1 === movieName2) {
                alert('电影名称不能相同！');
            } else {
                var elementValueList = [];
                var elementValue1 = {
                    movieName: movieName1
                };
                var elementValue2 = {
                    movieName: movieName2
                };
                elementValueList.push(elementValue1);
                elementValueList.push(elementValue2);
                $.ajax({
                    //请求URL
                    url: "${pageContext.request.contextPath }/elementValue/movieCompare",
                    //提交方式
                    type: "POST",
                    // data表示发送的数据
                    data: JSON.stringify(elementValueList),
                    // 定义发送请求的数据格式为JSON字符串
                    contentType: "application/json; charset=UTF-8",
                    //定义回调响应的数据格式为JSON字符串,该属性可以省略
                    dataType: "json",
                    //成功响应的结果
                    success: function (ret) {
                        var movieNameList = ret.movieNameList;
                        console.log(movieNameList);
                        if (movieNameList.length > 0) {
                            // ret.put("movieNameList",movieNameList);
                            var wordList = ret.keyWordList, keyWordList = [];
                            for (var i = 0; i < wordList.length; i++) {
                                var item = {
                                    name: wordList[i],
                                    min: 0
                                };
                                keyWordList.push(item);
                            }
                            var elementCountList1 = ret.elementCountList1;
                            var elementCountList2 = ret.elementCountList2;
                            // 清理 echarts实例
                            document.getElementById("main").removeAttribute("_echarts_instance_");
                            var myChart = echarts.init(document.getElementById('main'), 'dark');
                            var option = {
                                title: [{
                                    text: '电影元素对比',
                                    subtext: '依据用户正面评论数量分析而成',
                                    top: '3%',
                                    left: '3%',
                                    textStyle: {
                                        fontWeight: 'normal',
                                        fontSize: 20
                                    }
                                }],
                                legend: {
                                    icon: 'circle',
                                    top: '3%',
                                    show: true,
                                    orient: "horizontal",
                                    data: movieNameList,
                                    textStyle: {
                                        fontSize: 12,
                                        color: '#fff'
                                    },
                                },
                                tooltip: {
                                    trigger: 'item',
                                    padding: 5,
                                    backgroundColor: '#232425',
                                    borderColor: '#767879',
                                    borderWidth: 1,
                                    formatter: function (obj) {
                                        var val = obj.value;
                                        var ret = '电影：《' + ' ' + obj.name + '》<br>';
                                        for (var i = 0; i < keyWordList.length; i++) {
                                            if (val[i] > 0) {
                                                ret += keyWordList[i].name + '：' + val[i] + '<br>';
                                            }
                                        }
                                        return ret;
                                    }
                                },
                                toolbox: {
                                    right: '3%',
                                    top: '3%',
                                    show: true,
                                    feature: {
                                        dataView: {readOnly: false},
                                        restore: {show: true},
                                        saveAsImage: {show: true},
                                    }
                                },
                                radar: {
                                    //起始角度
                                    startAngle: 90,
                                    center: ['50%', '53%'],
                                    indicator: keyWordList,
                                },
                                series: [{
                                    name: '电影元素分析',
                                    //设置图表类型为雷达图
                                    type: 'radar',
                                    left: 'center',
                                    top: 'center',
                                    data: [
                                        {
                                            //第一部电影的名称
                                            name: movieNameList[0],
                                            //第一部电影的元素信息
                                            value: elementCountList1,
                                            symbol: 'circle',
                                            areaStyle: {
                                                normal: {
                                                    opacity: 0.8,
                                                    color: '#f7812a',
                                                },
                                            },
                                        },
                                        {
                                            //第二部电影的名称
                                            name: movieNameList[1],
                                            //第二部电影的元素信息
                                            value: elementCountList2,
                                            symbol: 'circle',
                                            areaStyle: {
                                                normal: {
                                                    opacity: 0.8,
                                                    color: '#8954E0',
                                                },
                                            },
                                        }
                                    ]
                                }]
                            };
                            //使用制定的配置项和数据显示图表
                            myChart.setOption(option);
                            window.onresize = myChart.resize;
                        }
                    },
                    error: function () {
                        alert('电影名称数据请求失败');
                    },
                });
            }
        }

        //对影评数量及其点赞数量在近几年的变化趋势进行展示
        function loadCommentInfo() {
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
                                        padding: 13
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
                                    nameTextStyle: {
                                        color: '#ccc',
                                        fontSize: 18,
                                        padding: 13
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
                                                var colors = [];
                                                for (var i = 0; i < 40; i++) {
                                                    colors.push('rgba(' + [
                                                        Math.round(Math.random() * 250),
                                                        Math.round(Math.random() * 250),
                                                        Math.round(Math.random() * 250),
                                                        0.75 + Math.random() * 0.25
                                                    ].join(',') + ')');
                                                }
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
                    }
                    ;
                    //为echarts对象加载数据
                    myChart.setOption(option);
                    window.onresize = myChart.resize;
                },
                error: function () {
                    alert('${message}');
                },
            });
        }

        //对影视受众按观影数量进行分类
        function loadMovieCount() {
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/comment/showMovieCount",
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
                    var movieCountMap = ret.movieCountMap;
                    if (Object.getOwnPropertyNames(movieCountMap).length > 0) {
                        var movieViewList = [], userCountList = [], pieDataList = [], pieLegendList = [];
                        var sum = 0, i = 0, count = 0;
                        for (var movieView in movieCountMap) {
                            if (i < 8) {
                                count = movieView;
                                var item = {
                                    name: "观影 " + movieView + " 部",
                                    value: movieCountMap[movieView]
                                };
                                pieLegendList.push(item.name);
                                pieDataList.push(item);
                                i++;
                            } else {
                                sum += movieCountMap[movieView];
                            }
                            //获取同一类型的电影列表
                            movieViewList.push(movieView);
                            userCountList.push(movieCountMap[movieView]);
                        }
                        var item = {
                            name: "观影>" + count + " 部",
                            value: sum,
                        };
                        pieLegendList.push(item.name);
                        pieDataList.push(item);
                        // 清理 echarts实例
                        document.getElementById("main").removeAttribute("_echarts_instance_");
                        var myChart = echarts.init(document.getElementById('main'), 'dark');
                        var option = {
                            title: [{
                                text: '观影数量占比图',
                                left: '3%',
                                // top:'50%'
                            }, {
                                text: '观影数量曲线图',
                                left: '3%',
                                top: '50%'
                            },],
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {
                                    type: 'shadow'
                                }
                            },
                            legend: [{
                                data: ['用户数量'],
                                top: '53%'
                            }, {
                                data: pieLegendList,
                                x: '5%',
                                y: '5%',
                                orient: 'vertical',
                            }],
                            grid: {
                                top: '60%'
                            },
                            toolbox: {
                                feature: {
                                    dataZoom: {
                                        yAxisIndex: 'none'
                                    },
                                    restore: {},
                                    saveAsImage: {}
                                }
                            },
                            dataZoom: [
                                {
                                    show: true,
                                    realtime: true,
                                    start: 30,
                                    end: 70,
                                },
                                {
                                    type: 'inside',
                                    realtime: true,
                                    start: 30,
                                    end: 70,
                                }
                            ],
                            xAxis: [
                                {
                                    type: 'category',
                                    boundaryGap: false,
                                    name: '观影数量/部',
                                    data: movieViewList
                                },
                            ],
                            yAxis: [
                                {
                                    name: '人数/个',
                                    type: 'value',
                                },
                            ],
                            series: [
                                //饼图实例
                                {
                                    type: 'pie',
                                    //用面积代表占比信息
                                    roseType: 'area',
                                    //单选模式
                                    selectedMode: 'single',
                                    radius: ['20%', '45%'],
                                    center: ['60%', '25%'],
                                    label: {
                                        formatter: '{b}:  ({d}%)'
                                    },
                                    data: pieDataList
                                },
                                //折线图实例
                                {
                                    name: '用户数量',
                                    type: 'line',
                                    //数据点样式
                                    symbolSize: 8,
                                    smooth: true,
                                    data: userCountList
                                }
                            ]
                        };
                    }
                    ;
                    //为echarts对象加载数据
                    myChart.setOption(option);
                    window.onresize = myChart.resize;
                },
                error: function () {
                    alert('${message}');
                },
            });
        }

        //对评论用户注册时间进行分类
        function loadJoinDateCount() {
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/commenter/showJoinDateCount",
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
                    var yearList = ret.yearList, countList = ret.countList;
                    if (yearList.length > 0) {
                        var pieLegendList = [], pieDataList = [];
                        for (var i = 0; i < yearList.length; i++) {
                            var item = {
                                name: yearList[i] + " 年",
                                value: countList[i]
                            };
                            if (yearList[i] === 2016) {
                                pieLegendList.push("");
                            }
                            pieLegendList.push(item.name);
                            pieDataList.push(item);
                        }
                        // 清理 echarts实例
                        document.getElementById("main").removeAttribute("_echarts_instance_");
                        var myChart = echarts.init(document.getElementById('main'), 'dark');
                        var option = {
                            title: [{
                                text: '用户注册数量占比图',
                                left: '3%',
                            }, {
                                text: '用户注册数量柱状图',
                                left: '3%',
                                top: '50%'
                            },],
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {
                                    type: 'shadow'
                                },
                                show:true
                            },
                            legend: [{
                                data: ['新用户数量'],
                                top: '53%'
                            }, {
                                data: pieLegendList,
                                x: '5%',
                                y: '5%',
                                orient: 'vertical',
                            }],
                            grid: {
                                top: '60%',
                                left: '3%',
                                right: '7%',
                                bottom: '3%',
                                containLabel: true
                            },
                            toolbox: {
                                feature: {
                                    dataZoom: {
                                        yAxisIndex: 'none'
                                    },
                                    restore: {},
                                    saveAsImage: {}
                                }
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    name: '注册年份',
                                    data: yearList
                                },
                            ],
                            yAxis: [
                                {
                                    name: '人数/人',
                                    type: 'value',
                                    scale: true,
                                },
                            ],
                            series: [
                                {
                                    type: 'pie',
                                    roseType: 'area',
                                    selectedMode: 'single',
                                    radius: ['13%', '40%'],
                                    center: ['60%', '25%'],
                                    label: {
                                        formatter: '{b}: {c}人 ({d}%)'
                                    },
                                    data: pieDataList
                                },
                                {
                                    name: '新用户数量',
                                    type: 'bar',
                                    label: {
                                        show: true,
                                        position: 'top'
                                    },
                                    data: countList
                                }
                            ]
                        };
                    }
                    ;
                    //为echarts对象加载数据
                    myChart.setOption(option);
                    window.onresize = myChart.resize;
                },
                error: function () {
                    alert('请求评论用户的注册时间数据失败！');
                },
            });
        }

        //对电影按照产出地进行分析展示
        function loadMakeCountryCount() {
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/movie/makeCountryCount",
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
                    var makeCountryList = ret.makeCountryList, data = [];
                    if (makeCountryList.length > 0) {
                        var countList = ret.countList;

                        // console.log(makeCountryList);
                        // console.log(countList);

                        for (var i = 0; i < makeCountryList.length; i++) {
                            data.push({name: makeCountryList[i], value: countList[i]});
                        }
                        // 清理 echarts实例
                        document.getElementById("main").removeAttribute("_echarts_instance_");
                        var myChart = echarts.init(document.getElementById('main'), 'dark');
                        var geoCoordMap = {
                            "美国": [-95.712891, 37.09024],
                            "日本": [138.252924, 36.204824],
                            "英国": [-3.435973, 55.378051],
                            "中国香港": [114.109497, 22.396428],
                            "中国大陆": [104.195397, 35.86166],
                            "法国": [2.213749, 46.227638],
                            "德国": [10.451526, 51.165691],
                            "韩国": [127.766922, 35.907757],
                            "意大利": [12.56738, 41.87194],
                            "中国台湾": [120.960515, 23.69781],
                            "加拿大": [-106.346771, 56.130366],
                            "澳大利亚": [133.775136, -25.274398],
                            "瑞士": [8.227512, 46.818188],
                            "西班牙": [-3.74922, 40.463667],
                            "印度": [78.96288, 20.593684],
                            "新西兰": [174.885971, -40.900557],
                            "伊朗": [53.688046, 32.427908],
                            "瑞典": [18.643501, 60.128161],
                            "南非": [22.937506, -30.559482],
                            "巴西": [-51.92528, -14.235004],
                            "波兰": [19.145136, 51.919438],
                            "奥地利": [14.550072, 47.516231],
                            "丹麦": [9.501785, 56.26392],
                            "俄罗斯": [105.318756, 61.52401],
                            "荷兰": [5.291266, 52.132633],
                            "黎巴嫩": [35.862285, 33.854721],
                            "阿根廷": [-63.616672, -38.416097],
                            "冰岛": [-19.020835, 64.963051],
                            "阿联酋": [53.847818, 23.424076],
                            "爱尔兰": [-8.24389, 53.41291],
                            "希腊": [21.824312, 39.074208],
                            "捷克": [15.472962, 49.817492]

                        };
                        var nameMap = {
                            "Canada": "加拿大",
                            "Turkmenistan": "土库曼斯坦",
                            "Saint Helena": "圣赫勒拿",
                            "Lao PDR": "老挝",
                            "Lithuania": "立陶宛",
                            "Cambodia": "柬埔寨",
                            "Ethiopia": "埃塞俄比亚",
                            "Faeroe Is.": "法罗群岛",
                            "Swaziland": "斯威士兰",
                            "Palestine": "巴勒斯坦",
                            "Belize": "伯利兹",
                            "Argentina": "阿根廷",
                            "Bolivia": "玻利维亚",
                            "Cameroon": "喀麦隆",
                            "Burkina Faso": "布基纳法索",
                            "Aland": "奥兰群岛",
                            "Bahrain": "巴林",
                            "Saudi Arabia": "沙特阿拉伯",
                            "Fr. Polynesia": "法属波利尼西亚",
                            "Cape Verde": "佛得角",
                            "W. Sahara": "西撒哈拉",
                            "Slovenia": "斯洛文尼亚",
                            "Guatemala": "危地马拉",
                            "Guinea": "几内亚",
                            "Dem. Rep. Congo": "刚果（金）",
                            "Germany": "德国",
                            "Spain": "西班牙",
                            "Liberia": "利比里亚",
                            "Netherlands": "荷兰",
                            "Jamaica": "牙买加",
                            "Solomon Is.": "所罗门群岛",
                            "Oman": "阿曼",
                            "Tanzania": "坦桑尼亚",
                            "Costa Rica": "哥斯达黎加",
                            "Isle of Man": "曼岛",
                            "Gabon": "加蓬",
                            "Niue": "纽埃",
                            "Bahamas": "巴哈马",
                            "New Zealand": "新西兰",
                            "Yemen": "也门",
                            "Jersey": "泽西岛",
                            "Pakistan": "巴基斯坦",
                            "Albania": "阿尔巴尼亚",
                            "Samoa": "萨摩亚",
                            "Czech Rep.": "捷克",
                            "United Arab Emirates": "阿拉伯联合酋长国",
                            "Guam": "关岛",
                            "India": "印度",
                            "Azerbaijan": "阿塞拜疆",
                            "N. Mariana Is.": "北马里亚纳群岛",
                            "Lesotho": "莱索托",
                            "Kenya": "肯尼亚",
                            "Belarus": "白俄罗斯",
                            "Tajikistan": "塔吉克斯坦",
                            "Turkey": "土耳其",
                            "Afghanistan": "阿富汗",
                            "Bangladesh": "孟加拉国",
                            "Mauritania": "毛里塔尼亚",
                            "Dem. Rep. Korea": "朝鲜",
                            "Saint Lucia": "圣卢西亚",
                            "Br. Indian Ocean Ter.": "英属印度洋领地",
                            "Mongolia": "蒙古",
                            "France": "法国",
                            "Cura?ao": "库拉索岛",
                            "S. Sudan": "南苏丹",
                            "Rwanda": "卢旺达",
                            "Slovakia": "斯洛伐克",
                            "Somalia": "索马里",
                            "Peru": "秘鲁",
                            "Vanuatu": "瓦努阿图",
                            "Norway": "挪威",
                            "Malawi": "马拉维",
                            "Benin": "贝宁",
                            "St. Vin. and Gren.": "圣文森特和格林纳丁斯",
                            "Korea": "韩国",
                            "Singapore": "新加坡",
                            "Montenegro": "黑山共和国",
                            "Cayman Is.": "开曼群岛",
                            "Togo": "多哥",
                            "China": "中国",
                            "Heard I. and McDonald Is.": "赫德岛和麦克唐纳群岛",
                            "Armenia": "亚美尼亚",
                            "Falkland Is.": "马尔维纳斯群岛（福克兰）",
                            "Ukraine": "乌克兰",
                            "Ghana": "加纳",
                            "Tonga": "汤加",
                            "Finland": "芬兰",
                            "Libya": "利比亚",
                            "Dominican Rep.": "多米尼加",
                            "Indonesia": "印度尼西亚",
                            "Mauritius": "毛里求斯",
                            "Eq. Guinea": "赤道几内亚",
                            "Sweden": "瑞典",
                            "Vietnam": "越南",
                            "Mali": "马里",
                            "Russia": "俄罗斯",
                            "Bulgaria": "保加利亚",
                            "United States": "美国",
                            "Romania": "罗马尼亚",
                            "Angola": "安哥拉",
                            "Chad": "乍得",
                            "South Africa": "南非",
                            "Fiji": "斐济",
                            "Liechtenstein": "列支敦士登",
                            "Malaysia": "马来西亚",
                            "Austria": "奥地利",
                            "Mozambique": "莫桑比克",
                            "Uganda": "乌干达",
                            "Japan": "日本",
                            "Niger": "尼日尔",
                            "Brazil": "巴西",
                            "Kuwait": "科威特",
                            "Panama": "巴拿马",
                            "Guyana": "圭亚那",
                            "Madagascar": "马达加斯加",
                            "Luxembourg": "卢森堡",
                            "American Samoa": "美属萨摩亚",
                            "Andorra": "安道尔",
                            "Ireland": "爱尔兰",
                            "Italy": "意大利",
                            "Nigeria": "尼日利亚",
                            "Turks and Caicos Is.": "特克斯和凯科斯群岛",
                            "Ecuador": "厄瓜多尔",
                            "U.S. Virgin Is.": "美属维尔京群岛",
                            "Brunei": "文莱",
                            "Australia": "澳大利亚",
                            "Iran": "伊朗",
                            "Algeria": "阿尔及利亚",
                            "El Salvador": "萨尔瓦多",
                            "C?te d'Ivoire": "科特迪瓦",
                            "Chile": "智利",
                            "Puerto Rico": "波多黎各",
                            "Belgium": "比利时",
                            "Thailand": "泰国",
                            "Haiti": "海地",
                            "Iraq": "伊拉克",
                            "S?o Tomé and Principe": "圣多美和普林西比",
                            "Sierra Leone": "塞拉利昂",
                            "Georgia": "格鲁吉亚",
                            "Denmark": "丹麦",
                            "Philippines": "菲律宾",
                            "S. Geo. and S. Sandw. Is.": "南乔治亚岛和南桑威奇群岛",
                            "Moldova": "摩尔多瓦",
                            "Morocco": "摩洛哥",
                            "Namibia": "纳米比亚",
                            "Malta": "马耳他",
                            "Guinea-Bissau": "几内亚比绍",
                            "Kiribati": "基里巴斯",
                            "Switzerland": "瑞士",
                            "Grenada": "格林纳达",
                            "Seychelles": "塞舌尔",
                            "Portugal": "葡萄牙",
                            "Estonia": "爱沙尼亚",
                            "Uruguay": "乌拉圭",
                            "Antigua and Barb.": "安提瓜和巴布达",
                            "Lebanon": "黎巴嫩",
                            "Uzbekistan": "乌兹别克斯坦",
                            "Tunisia": "突尼斯",
                            "Djibouti": "吉布提",
                            "Greenland": "格陵兰",
                            "Timor-Leste": "东帝汶",
                            "Dominica": "多米尼克",
                            "Colombia": "哥伦比亚",
                            "Burundi": "布隆迪",
                            "Bosnia and Herz.": "波斯尼亚和黑塞哥维那",
                            "Cyprus": "塞浦路斯",
                            "Barbados": "巴巴多斯",
                            "Qatar": "卡塔尔",
                            "Palau": "帕劳",
                            "Bhutan": "不丹",
                            "Sudan": "苏丹",
                            "Nepal": "尼泊尔",
                            "Micronesia": "密克罗尼西亚",
                            "Bermuda": "百慕大",
                            "Suriname": "苏里南",
                            "Venezuela": "委内瑞拉",
                            "Israel": "以色列",
                            "St. Pierre and Miquelon": "圣皮埃尔和密克隆群岛",
                            "Central African Rep.": "中非",
                            "Iceland": "冰岛",
                            "Zambia": "赞比亚",
                            "Senegal": "塞内加尔",
                            "Papua New Guinea": "巴布亚新几内亚",
                            "Trinidad and Tobago": "特立尼达和多巴哥",
                            "Zimbabwe": "津巴布韦",
                            "Jordan": "约旦",
                            "Gambia": "冈比亚",
                            "Kazakhstan": "哈萨克斯坦",
                            "Poland": "波兰",
                            "Eritrea": "厄立特里亚",
                            "Kyrgyzstan": "吉尔吉斯斯坦",
                            "Montserrat": "蒙特塞拉特",
                            "New Caledonia": "新喀里多尼亚",
                            "Macedonia": "马其顿",
                            "Paraguay": "巴拉圭",
                            "Latvia": "拉脱维亚",
                            "Hungary": "匈牙利",
                            "Syria": "叙利亚",
                            "Honduras": "洪都拉斯",
                            "Myanmar": "缅甸",
                            "Mexico": "墨西哥",
                            "Egypt": "埃及",
                            "Nicaragua": "尼加拉瓜",
                            "Cuba": "古巴",
                            "Serbia": "塞尔维亚",
                            "Comoros": "科摩罗",
                            "United Kingdom": "英国",
                            "Fr. S. Antarctic Lands": "南极洲",
                            "Congo": "刚果（布）",
                            "Greece": "希腊",
                            "Sri Lanka": "斯里兰卡",
                            "Croatia": "克罗地亚",
                            "Botswana": "博茨瓦纳",
                            "Siachen Glacier": "锡亚琴冰川地区"
                        };
                        var convertData = function (data) {
                            var res = [];
                            for (var i = 0; i < data.length; i++) {
                                var geoCoord = geoCoordMap[data[i].name];
                                if (geoCoord) {
                                    res.push({
                                        name: data[i].name,
                                        value: geoCoord.concat(data[i].value)
                                    });
                                }
                            }
                            return res;
                        };

                        var option = {
                            title: {
                                text: '电影制作方地区分布',
                                subtext: '统计影片制作方所在地区',
                                sublink: 'http://douban.com',
                                left: '3%',
                                top: '3%',
                                textStyle: {
                                    color: '#fff'
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
                            tooltip: {
                                trigger: 'item',
                                formatter: function (item) {
                                    var str = '';
                                    if (item.value[2] >= countList[4][0]) {
                                        str += 'Top 5' + '<br>';
                                    }
                                    return str + "地区：" + item.name + '<br>' +
                                        "影片数量：" + item.value[2] + '<br>' +
                                        "平均评论次数：" + item.value[3] + '<br>' +
                                        "平均影片评分：" + item.value[4]
                                }
                            },
                            legend: {
                                orient: 'vertical',
                                left: 'center',
                                top: '3%',
                                data: ['影片数量'],
                                show: true,
                                textStyle: {
                                    color: '#fff'
                                }
                            },
                            geo: {
                                map: 'world',
                                roam: true,
                                zoom: 1.1,
                                scaleLimit: {min: 0.75, max: 5},
                                nameMap: nameMap,
                                itemStyle: {
                                    normal: {
                                        areaColor: '#666',
                                        borderColor: '#333'
                                    },
                                    emphasis: {
                                        areaColor: '#ccc'
                                    }
                                }
                            },
                            series: [
                                {
                                    name: '电影数量',
                                    type: 'scatter',
                                    coordinateSystem: 'geo',
                                    data: convertData(data.sort(function (a, b) {
                                        return b.value - a.value;
                                    }).slice(5, data.length)),
                                    symbolSize: function (val) {
                                        return Math.max(val[2] * 0.8, 10);
                                    },
                                    label: {
                                        normal: {
                                            formatter: '{b}',
                                            position: 'right',
                                            // show: false
                                        },
                                        emphasis: {
                                            show: true
                                        }
                                    },
                                    itemStyle: {
                                        normal: {
                                            color: '#ddb926'
                                        }
                                    }
                                },
                                {
                                    name: 'Top 5',
                                    type: 'effectScatter',
                                    coordinateSystem: 'geo',
                                    data: convertData(data.sort(function (a, b) {
                                        return b.value - a.value;
                                    }).slice(0, 5)),
                                    symbolSize: function (val) {
                                        return val[2] * 0.6;
                                    },
                                    showEffectOn: 'render',
                                    rippleEffect: {
                                        brushType: 'stroke'
                                    },
                                    hoverAnimation: true,
                                    label: {
                                        normal: {
                                            formatter: '{b}',
                                            position: 'right',
                                            show: true
                                        }
                                    },
                                    itemStyle: {
                                        normal: {
                                            color: '#f4e925',
                                            shadowBlur: 5,
                                            shadowColor: '#333'
                                        }
                                    },
                                    zlevel: 1
                                }
                            ]
                        };

                    }
                    ;
                    //为echarts对象加载数据
                    myChart.setOption(option);
                    window.onresize = myChart.resize;
                },
                error: function () {
                    alert('请求数据失败！');
                },
            });
        }

        //对电影评论者长居城市进行分析
        function loadCommenterCityCount() {
            $.ajax({
                //请求URL
                url: "${pageContext.request.contextPath }/commenter/liveCityCount",
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
                    var liveCityList = ret.liveCityList, dataList = [];
                    if (liveCityList.length > 0) {
                        var countList = ret.countList, maxCount = countList[0][0];

                        // console.log(liveCityList);
                        // console.log(countList);

                        for (var i = 0; i < liveCityList.length; i++) {
                            dataList.push({name: liveCityList[i], value: countList[i][0]});
                        }
                        // 清理 echarts实例
                        document.getElementById("main").removeAttribute("_echarts_instance_");
                        var myChart = echarts.init(document.getElementById('main'), 'dark');
                        var option = {
                            title: {
                                text: '电影评论者居住地区分布',
                                subtext: '统计电影评论者所在地区',
                                sublink: 'http://douban.com',
                                left: '3%',
                                top: '3%',
                                textStyle: {
                                    color: '#fff'
                                },
                                subtextStyle: {
                                    color: '#fff'
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
                            tooltip: {
                                trigger: 'item',
                                formatter: function (item) {
                                    var index = 0;
                                    for (var i = 0; i < liveCityList.length; i++) {
                                        if (liveCityList[i] === item.name) {
                                            index = i;
                                            return "行政区 ：" + item.name + '<br>' +
                                                "用户数量：" + item.value + '<br>' +
                                                "平均好友数量：" + countList[index][1] + '<br>' +
                                                "平均粉丝数量：" + countList[index][2];
                                        }
                                    }
                                    return "行政区 ：" + item.name + '<br>' +
                                        "用户数量：0" + '<br>';
                                    // "平均好友数量：" + countList[index][1] + '<br>' +
                                    // "平均粉丝数量：" + countList[index][2]
                                }
                            },
                            visualMap: {
                                min: 0,
                                max: maxCount,
                                left: '3%',
                                bottom: '5%',
                                showLabel: true,
                                name: '用户数量',
                                text: ["高", "低"],
                                textStyle: {
                                    color: '#fff'
                                },
                                pieces: [{
                                    gt: 400,
                                    label: "> 400 人",
                                    color: "#7f1100"
                                }, {
                                    gte: 200,
                                    lte: 400,
                                    label: "200 - 400 人",
                                    color: "#ff5428"
                                }, {
                                    gte: 100,
                                    lt: 200,
                                    label: "100 - 200 人",
                                    color: "#ff8c71"
                                }, {
                                    gte: 50,
                                    lt: 100,
                                    label: "50 - 100 人",
                                    color: "#ffd768"
                                }, {
                                    gte: 1,
                                    lt: 50,
                                    label: "1 - 50 人",
                                    color: "#ffe5c9"
                                }, {
                                    value: 0,
                                    label: "无",
                                    color: "#ffffff"
                                }],
                                show: true
                            },
                            legend: {
                                orient: 'vertical',
                                left: 'center',
                                top: '3%',
                                data: ['用户分布'],
                                show: true,
                                textStyle: {
                                    color: '#fff'
                                }
                            },
                            //地图实例
                            geo: {
                                //中国地图
                                map: 'china',
                                //禁止通过鼠标对地图进行放大缩小操作
                                roam: false,
                                zoom: 1.1,
                                //文本的字体样式
                                label: {
                                    normal: {
                                        show: true,
                                        fontSize: "14",
                                        color: "rgba(0,0,0,0.7)"
                                    }
                                },
                                itemStyle: {
                                    //默认显示时的样式
                                    normal: {
                                        borderColor: "rgba(0, 0, 0, 0.2)"
                                    },
                                    //被选中时的样式
                                    emphasis: {
                                        areaColor: 'orange',
                                        shadowOffsetX: 0,
                                        shadowOffsetY: 0,
                                        borderWidth: 0
                                    }
                                }
                            },
                            series: [
                                {
                                    name: "用户分布",
                                    type: "map",
                                    //加载该地图实例
                                    geoIndex: 0,
                                    data: dataList
                                }
                            ]
                        };

                    }
                    ;
                    //为echarts对象加载数据
                    myChart.setOption(option);
                    window.onresize = myChart.resize;
                },
                error: function () {
                    alert('请求数据失败！');
                },
            });
        }

        //对页面中的数据进行初始化
        $(document).ready(function init() {
            loadMovieNameList();
            loadMovieSells();
        });

    </script>
</head>
<body>
<nav id="head_nav" class="navbar navbar-toggleable bg-inverse navbar-inverse fixed-top"
     style="background-color: rgba(20,20,20,0.5)">
    <a class="navbar-brand " href="#"><i class="fa fa-home fa-fw" aria-hidden="true"></i>首页</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse " id="collapsibleNavbar">
        <ul class="navbar-nav " >
            <%--col-4--%>
            <li class="nav-item   col-3" >
                <span class="navbar-text"><i class="fa fa-user-circle-o fa-fw"
                                             aria-hidden="true"></i>用户：<strong>${Administrator_SESSION.userName}</strong></span>
            </li>
                <%--col-3--%>
            <li class="nav-item  col-3">
                <a class="nav-link " href="${pageContext.request.contextPath }/elementValue/toFindElementValues"><i
                        class="fa fa-file-movie-o fa-fw" aria-hidden="true"></i> 选择电影</a>
            </li>
            <li class="nav-item col-3" >
                <a class="nav-link " href="${pageContext.request.contextPath }/movie/toShowMovie"><i
                        class="fa fa-pie-chart fa-fw" aria-hidden="true"></i>电影分类</a>
            </li>
            <li class="nav-item col-3" >
                <a class="nav-link" href="${pageContext.request.contextPath }/movie/toShowDirector"><i
                        class="fa fa-area-chart fa-fw" aria-hidden="true"></i>词频分析</a>
            </li>
            <li class="nav-item   col-3" >
                <a class="nav-link " href="${pageContext.request.contextPath}/administrator/toUpdatePassword"><i
                        class="fa fa-pencil fa-fw" aria-hidden="true"></i>修改密码</a>
            </li>
            <%--退出网站--%>
            <li class="nav-item  col-3" >
                <a class="nav-link " href="${pageContext.request.contextPath }/administrator/logout"><i
                        class="fa fa-chain-broken fa-fw" aria-hidden="true"></i>退 出</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container-fluid " style="padding: 0; ">
    <video id="video-feature-4" style="width: 100%;padding: 0" autoplay="autoplay" loop="loop" muted="muted"
           src="${pageContext.request.contextPath }/static/video/index-4.mp4"
           poster="${pageContext.request.contextPath }/static/images/index-4.jpg"></video>
    <div id="top-hcontent">
        <h1><strong style="font-family: -apple-system;">ECHARTS</strong></h1>
    </div>
    <div id="top-acontent">
        <div class="btn-group">
            <a href="https://www.echartsjs.com/zh/feature.html" class="btn btn-link">特 性</a>
            <a href="https://www.echartsjs.com/examples/zh/index.html" class="btn btn-link">实 例</a>
        </div>
    </div>
</div>


<div class="container-fluid" style="background-color: aliceblue">
    <div class="row">
        <div class="col-3" style="margin-top:30px;padding-left: 30px ">
            <div>
                <ul class="nav nav-pills flex-column " role="tablist">
                    <li class=" nav-item  ">
                        <a role="tab" data-toggle="pill" class="nav-link active" href="javascript:void(0);"
                           onclick="loadMovieSells();">电影票房数据</a>
                    </li>
                    <li class="nav-item">
                        <a role="tab" data-toggle="pill" class="nav-link" href="javascript:void(0);"
                           onclick="loadMakeCountryCount();">出品地区分析</a>
                    </li>
                    <li class="nav-item">
                        <a role="tab" data-toggle="pill" class="nav-link" href="javascript:void(0);"
                           onclick="loadCommenterCityCount();">评论用户分布</a>
                    </li>
                    <li class="nav-item">
                        <a role="tab" data-toggle="pill" class="nav-link" href="javascript:void(0);"
                           onclick="loadJoinDateCount();">注册时间分析</a>
                    </li>
                    <li class="nav-item">
                        <a role="tab" data-toggle="pill" class="nav-link " href="javascript:void(0);"
                           onclick="loadCommentInfo();">评论数量变化</a>
                    </li>
                    <li class="nav-item">
                        <a role="tab" data-toggle="pill" class="nav-link " href="javascript:void(0);"
                           onclick="loadMovieCount();">观影数量分析</a>
                    </li>

                </ul>
            </div>
            <div style="margin-top: 45px">
                <form>
                    <div class="form-group ">
                        <ul class="nav nav-pills flex-column" role="tablist">
                            <li class=" nav-item ">
                                <a role="tab" data-toggle="pill" class="nav-link active" href="javascript:void(0);"
                                >电影元素对比</a>
                            </li>
                        </ul>
                    </div>
                    <div class="form-group">
                        <%--<label for="select_movie1" class="form-control-label">电  影</label>--%>
                        <div class="input-group">
                            <span class="input-group-addon"> <i class="fa fa-film fa-fw"></i></span>
                            <select id="select_movie1" class=" form-control" required></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <%--<label for="select_movie2" class="form-control-label">电  影</label>--%>
                        <div class="input-group">
                            <span class="input-group-addon"> <i class="fa fa-film fa-fw"></i></span>
                            <select id="select_movie2" class="form-control" required></select>
                        </div>
                    </div>
                    <div class=" justify-content-center">
                        <button type="button" onsubmit="returnFalse();" class="btn btn-block btn-success"
                                onclick="movieElementCompare();">对 比
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <div id="main" class=" col-9"
             style="margin-top: 30px;padding:0;height: 600px;border-radius: 10px;border: 2px solid #666666">
        </div>
    </div>
</div>
<div>
    <section id="about-section" class="jumbotron text-center">
        <div class="container">
            <h3>关注我们</h3>
            <p>可以通过以下渠道关注 ECharts数据可视化展示，及时获得更多最新动态</p>
            <div class="button btn-group">
                <a class="btn btn-link " style="margin-right: 15px" href="https://github.com/ecomfe/echarts">
                    <span class="fa fa-github ">GitHub</span>
                </a>
                <a class="btn btn-link " style="margin-left: 15px" href="https://weibo.com/echarts">
                    <span class="fa fa-weibo ">微 博</span>
                </a>

            </div>
        </div>
    </section>
</div>

</body>
</html>
