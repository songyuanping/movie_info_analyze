package com.ssm.controller;

import com.ssm.pojo.Movie;
import com.ssm.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.jws.WebParam;
import java.text.NumberFormat;
import java.util.*;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/15 0015
 * @version: 1.0
 */
@Controller
@RequestMapping("/movie")
public class MovieController {
    @Autowired
    private MovieService movieService;

    @GetMapping("/toShowDirector")
    public String toShowDirector() {
        return "movie/showDirector";
    }


    @ResponseBody
    @GetMapping("/showDirectorCount")
    //将所有的导演数据以词云图的形式进行展示
    public Map<String, Object> showDirectorCount(Movie movie, Model model) {
        List<Movie> movieList = movieService.queryDirectors(movie);
        Map<String, List<Object>> directorMap = new HashMap<>(movieList.size());
        for (Movie movie1 : movieList) {
            String director = movie1.getDirector();
            String[] directors = director.split(" {3}");
            for (String director1 : directors) {
                if (directorMap.containsKey(director1)) {
                    List<Object> list = directorMap.get(director1);
                    list.set(0, (Integer) list.get(0) + 1);
                    list.set(1, (Double) list.get(1) + movie1.getMovieScore());
                    directorMap.put(director1, list);
                } else {
                    List<Object> list = new ArrayList<>();
                    list.add(1);
                    list.add(movie1.getMovieScore());
                    directorMap.put(director1, list);
                }
            }
        }
//        System.out.println(directorMap.keySet());
        for (String director : directorMap.keySet()) {
            List<Object> list = directorMap.get(director);
            NumberFormat numberFormat = NumberFormat.getNumberInstance();
            //设置最多显示两位小数
            numberFormat.setMaximumFractionDigits(2);
            list.set(1, numberFormat.format((Double) list.get(1) / (Integer) list.get(0)));
            directorMap.put(director, list);
        }
        Map<String, Object> ret = new HashMap<>();
        if (directorMap.size() > 0) {
            model.addAttribute("message", "导演数据加载成功！");
        } else {
            model.addAttribute("message", "导演数据加载失败！");
        }
        ret.put("directorMap", directorMap);
        return ret;
    }

    @ResponseBody
    @GetMapping("/showActorsCount")
    //将所有的演员数据以词云图的形式进行展示
    public Map<String, Object> showActorsCount(Movie movie, Model model) {
        List<Movie> movieList = movieService.findMovies(movie);
        Map<String, List<Object>> actorsMap = new HashMap<>(movieList.size());
        for (Movie movie1 : movieList) {
            String actor = movie1.getActors();
            String[] actors = actor.split(" {3}");
            for (String actor1 : actors) {
                if (actorsMap.containsKey(actor1)) {
                    List<Object> list = actorsMap.get(actor1);
                    list.set(0, (Integer) list.get(0) + 1);
                    actorsMap.put(actor1, list);
                } else {
                    List<Object> list = new ArrayList<>();
                    list.add(1);
                    actorsMap.put(actor1, list);
                }
            }
        }
//        System.out.println(actorsMap.keySet());
        Map<String, Object> ret = new HashMap<>();
        if (actorsMap.size() > 0) {
            model.addAttribute("message", "演员据加载成功！");
        } else {
            model.addAttribute("message", "演员数据加载失败！");
        }
        ret.put("actorsMap", actorsMap);
        return ret;
    }

    @ResponseBody
    @PostMapping(value = "/listMovieName")
    public List<String> listMovieName(Movie movie) {
        List<Movie> movieList = movieService.findMovies(movie);
        List<String> movieNameList = new ArrayList<>();
        for (Movie movie1 : movieList) {
            movieNameList.add(movie1.getMovieName());
        }
        return movieNameList;
    }

    @GetMapping("/toShowMovie")
    public String toShowMovie() {
        return "movie/showMovie";
    }

    @PostMapping(value = "/searchMovies")
    public String searchMovies(Movie movie, Model model) {
        List<Movie> movieList = movieService.findMovies(movie);
        movieList.sort(Comparator.comparing(Movie::getMovieScore));
        Collections.reverse(movieList);
        if (movieList.size() > 0) {
            model.addAttribute("message", "查找电影数据成功！");
        } else {
            model.addAttribute("message", "相关电影数据查找失败！");
        }
        model.addAttribute("total", movieList.size());
        model.addAttribute("movieList", movieList);
        return "elementValue/showElementValue";
    }

    @PostMapping(value = "/showScoreAndCommenter", produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<Movie> showMovieScoreAndCommenter(Movie movie, Model model) {
        List<Movie> movieList = movieService.findMovies(movie);
        movieList.sort(Comparator.comparing(Movie::getMovieScore));
        if (movieList.size() > 0) {
            model.addAttribute("message", "查找电影数据成功！");
        } else {
            model.addAttribute("message", "相关电影数据查寻失败！");
        }
        model.addAttribute("movieList", movieList);
        return movieList;
    }

    //返回电影类型组成的列表
    public List<String> findMovieTypeList(Movie movie) {
        List<Movie> movieList = movieService.findMovieType(movie);
        Set<String> typeSet = new HashSet<>();
        for (Movie movie1 : movieList) {
            String[] movieTypes = movie1.getMovieType().split(" ");
            for (String s : movieTypes) {
                typeSet.add(s.trim());
            }
        }
        return new ArrayList<>(typeSet);
    }

    @ResponseBody
    @GetMapping("/showMovieInfo")
    //将一部电影的详细信息进行展示
    public Map<String, Object> queryMovieInfo(Movie movie, Model model) {
        List<Movie> movieList = movieService.findMovies(movie);
        List<String> typeList = findMovieTypeList(movie);
        HashMap<String, ArrayList<Movie>> typeMap = new HashMap<>();
        for (String s : typeList) {
            typeMap.put(s, new ArrayList<>());
        }
        for (Movie movie1 : movieList) {
            String movieType = movie1.getMovieType();
            String[] types = movieType.split(" ");
            //给每一部电影划分出一种类型
            if (types.length > 1 && types[0].equals("剧情")) {
                movieType = types[(int) (1 + Math.random() * (types.length - 1))];
            } else {
                movieType = types[(int) (Math.random() * types.length)];
            }
            for (String type : typeList) {
                if (movieType.equals(type)) {
                    typeMap.get(type).add(movie1);
                    break;
                }
            }
        }
        for (String s : typeList) {
            if (typeMap.get(s).size() == 0) {
                typeMap.remove(s);
            }
        }
        Map<String, Object> ret = new HashMap<>();
        if (typeMap.size() > 0) {
            model.addAttribute("message", "电影数据加载成功！");
        } else {
            model.addAttribute("message", "电影数据加载失败！");
        }
        ret.put("typeMap", typeMap);
        return ret;
    }


    @ResponseBody
    @GetMapping(value = "/makeCountryCount")
    public Map<String, Object> makeCountryCount(Movie movie) {
        List<Movie> movieList = movieService.findMovies(movie);
        Map<String,List<Object>> makeCountryCountMap=new HashMap<>();
        for (Movie movie1 : movieList) {
            String[] makeCountries = movie1.getMakeCountry().split(" ");
            for (String s : makeCountries) {
                List<Object> list=new ArrayList<>();
                if(makeCountryCountMap.containsKey(s))
                {
                    //统计电影数量
                    list.add(0,(int)makeCountryCountMap.get(s).get(0)+1);
                    //累计评论次数
                    list.add(1,(long)makeCountryCountMap.get(s).get(1)+movie1.getCommenterNumber());
                    //累计电影评分
                    list.add(2,(double)makeCountryCountMap.get(s).get(2)+movie1.getMovieScore());
                    makeCountryCountMap.put(s,list);
                }
                else if(s.trim().length()>0)
                {
                    list.add(0,1);
                    list.add(1,(long)movie1.getCommenterNumber());
                    list.add(2,movie1.getMovieScore());
                    makeCountryCountMap.put(s,list);
                }
            }
        }
        List<Map.Entry<String, List<Object>>> entryList = new ArrayList<>(makeCountryCountMap.entrySet());
        entryList.sort((o1, o2) -> ((Integer)o2.getValue().get(0)).compareTo((Integer)o1.getValue().get(0)));
        List<String> makeCountryList = new ArrayList<>();
        List<List<Object>> countList = new ArrayList<>();
        for (Map.Entry<String,  List<Object>> map : entryList) {
            NumberFormat numberFormat = NumberFormat.getNumberInstance();
            //设置最多显示两位小数
            numberFormat.setMaximumFractionDigits(2);
            //计算平均评论次数
            map.getValue().set(1,(long)map.getValue().get(1)/(int)map.getValue().get(0));
            //计算电影平均评分
            map.getValue().set(2,numberFormat.format((double)map.getValue().get(2)/(int)map.getValue().get(0)));
            makeCountryList.add(map.getKey());
            countList.add(map.getValue());
        }
        Map<String, Object> ret = new HashMap<>();
        ret.put("makeCountryList", makeCountryList);
        ret.put("countList", countList);
        return ret;
    }

    @ResponseBody
    @PostMapping("/showMovieType")
    public Map<String, Object> showMovieTypeList(Movie movie) {
        List<Movie> movieList = movieService.findMovieType(movie);
        ArrayList<String> typeList = new ArrayList<>();
        for (Movie movie1 : movieList) {
            String[] movieTypes = movie1.getMovieType().split(" ");
            for (String s : movieTypes) {
                typeList.add(s.trim());
            }
        }
        Map<String, Integer> typeMap = new HashMap<>();
        for (String s : typeList) {
            if (!typeMap.containsKey(s)) {
                typeMap.put(s, 1);
            } else {
                typeMap.replace(s, typeMap.get(s) + 1);
            }
        }
        List<Map.Entry<String, Integer>> list = new ArrayList<>(typeMap.entrySet());
        list.sort((o1, o2) -> o2.getValue().compareTo(o1.getValue()));
        List<String> keyList = new ArrayList<>();
        List<Integer> valueList = new ArrayList<>();
        for (Map.Entry<String, Integer> map : list) {
            keyList.add(map.getKey());
            valueList.add(map.getValue());
        }
        Map<String, Object> ret = new HashMap<>();
        ret.put("typeList", keyList);
        ret.put("numberList", valueList);
        return ret;
    }

    @PostMapping("/findMovie")
    public String findMovieList(Movie movie, Model model) {
        List<Movie> movieList = movieService.findMovies(movie);
        model.addAttribute("movieList", movieList);
        return "movie/showMovie";
    }

    //    统计每一年各个类型的电影数量
//    @PostMapping("/queryMovieType")
//    public String queryMovieType(Movie movie, Model model){
//        Integer typeCount=8;
//        List<Movie> movieList=movieService.findMovies(movie);
//        List<String> typeList= findMovieTypeList(movie);
//        //选取类型最多的八种电影
//        typeList=typeList.subList(0,typeCount);
//        Map<Integer,String> yearMap=new HashMap<>(movieList.size());
//        for(Movie movie1:movieList)
//        {
//            Integer year=Integer.parseInt(movie1.getShowYear().trim().substring(0,4));
//            if(!yearMap.containsKey(year))
//            {
//                yearMap.put(year,movie1.getMovieType()+" ");
//            }
//            else
//            {
//                yearMap.replace(year,yearMap.get(year).concat(movie1.getMovieType()+" "));
//            }
//        }
//        Map<Integer,Integer[]> typeCountsMap=new HashMap<>(yearMap.size());
//        for(Integer year:yearMap.keySet())
//        {
//            String[] strings=yearMap.get(year).split(" ");
//            Integer[] counts=new Integer[typeCount];
//            for(int i=0;i<counts.length;i++)
//            {
//                counts[i]=0;
//            }
//            for(String s:strings)
//            {
//                for(int i=0;i<typeList.size();i++)
//                {
//                    if(s.trim().equals(typeList.get(i).trim()))
//                    {
//                        counts[i]++;
//                    }
//                }
//            }
//            typeCountsMap.put(year,counts);
//        }
//        List<Map.Entry<Integer,Integer[]>> list=new ArrayList<>(typeCountsMap.entrySet());
//        Collections.sort(list, new Comparator<Map.Entry<Integer, Integer[]>>() {
//            @Override
//            public int compare(Map.Entry<Integer, Integer[]> o1, Map.Entry<Integer, Integer[]> o2) {
//                return o1.getKey().compareTo(o2.getKey());
//            }
//        });
//        List<Integer> keyList=new ArrayList<>();
//        List<Integer[]> countsList=new ArrayList<>();
//        for(Map.Entry<Integer,Integer[]> map:list)
//        {
//            keyList.add(map.getKey());
//            countsList.add(map.getValue());
//            System.out.println("key: "+map.getKey());
//            for(int i=0;i<map.getValue().length;i++)
//            {
//                System.out.println(typeList.get(i)+" : "+map.getValue()[i]);
//            }
//        }
//        model.addAttribute("keyList",keyList);
//        model.addAttribute("countsList",countsList);
//        return "showMovie";
//    }

}
