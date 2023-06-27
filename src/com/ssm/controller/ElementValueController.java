package com.ssm.controller;

import com.ssm.pojo.*;
import com.ssm.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;


/**
 * @description:处理对评论数据的分析处理
 * @author: song yuanping
 * @createDate: 2020/3/16 0016
 * @version: 1.0
 */
@Controller
@RequestMapping("/elementValue")
public class ElementValueController {
    @Autowired
    private ElementValueService elementValueService;
    @Autowired
    private MovieService movieService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private NegativeService negativeService;
    @Autowired
    private PositiveService positiveService;
    @Autowired
    private NounService nounService;

    public int insertElementValue(ElementValue elementValue) {
        return elementValueService.insertElementValue(elementValue);
    }

    @ResponseBody
    @PostMapping(value = "/movieCompare")
    public Map<String,Object> elementCompare(@RequestBody List<ElementValue> elementValueList, Model model)
    {
        int showSize=6;
        ElementValue elementValue1=elementValueList.get(0);
        List<ElementValue> elementValueList_1=showElementAnalyze(elementValue1,model);
        ElementValue elementValue2=elementValueList.get(1);
        List<ElementValue> elementValueList_2=showElementAnalyze(elementValue2,model);
        //对元素数组从小到大排序
        elementValueList_1.sort(Comparator.comparing(ElementValue::getPositiveCount));
        elementValueList_2.sort(Comparator.comparing(ElementValue::getPositiveCount));
        List<ElementValue> elementValueList1=elementValueList_1.subList(elementValueList_1.size()-showSize,elementValueList_1.size());
        List<ElementValue> elementValueList2=elementValueList_2.subList(elementValueList_2.size()-showSize,elementValueList_2.size());
        List<String> keyWordList=new ArrayList<>();
        for(ElementValue elementValue:elementValueList1)
        {
            keyWordList.add(elementValue.getKeyWard());
        }
        for (ElementValue elementValue3 : elementValueList2) {
            boolean flag = false;
            for (String s : keyWordList) {
                if (elementValue3.getKeyWard().equals(s)) {
                    flag = true;
                    break;
                }
            }
            if (!flag) {
                keyWordList.add(elementValue3.getKeyWard());
            }
        }
        Map<String,Integer> keyWordMap1=new HashMap<>(keyWordList.size());
        Map<String,Integer> keyWordMap2=new HashMap<>(keyWordList.size());
        for(String keyWord:keyWordList)
        {
            keyWordMap1.put(keyWord, 0);
            keyWordMap2.put(keyWord,0);
            for(ElementValue elementValue:elementValueList_1) {
                if (elementValue.getKeyWard().equals(keyWord)) {
                    keyWordMap1.put(keyWord, elementValue.getPositiveCount());
                    break;
                }
            }
            for(ElementValue elementValue:elementValueList_2){
                if(elementValue.getKeyWard().equals(keyWord)){
                    keyWordMap2.put(keyWord,elementValue.getPositiveCount());
                    break;
                }
            }
        }
        List<String> movieNameList=new ArrayList<>();
        movieNameList.add(elementValue1.getMovieName());
        movieNameList.add(elementValue2.getMovieName());
        List<Integer> elementCountList1=new ArrayList<>(keyWordMap1.values());
        List<Integer> elementCountList2=new ArrayList<>(keyWordMap2.values());
        Map<String,Object> ret=new HashMap<>();
        ret.put("movieNameList",movieNameList);
        ret.put("keyWordList",keyWordList);
        ret.put("elementCountList1",elementCountList1);
        ret.put("elementCountList2",elementCountList2);
        return ret;
    }

    @GetMapping (value = "/toShowElementAnalyze")
    public String toShowElementAnalyze(@RequestParam(value = "movieName", defaultValue = "肖申克的救赎", required = true) String movieName, Model model){
        if(movieName!=null&&movieName.trim().length()>0)
        {
            model.addAttribute("message","电影名称输入成功！");
            model.addAttribute("movieName",movieName);
        }
        else {
            model.addAttribute("message","电影名称不能为空，请重新输入！");
        }
        return "elementValue/showElementAnalyze";
    }

    // 对返回结果用柱状图进行展示
    @ResponseBody
    @PostMapping(value = "/showElementAnalyze")
    public List<ElementValue> showElementAnalyze(@RequestBody ElementValue elementValue, Model model) {
        List<ElementValue> elementValueList = elementValueService.selectElementValues(elementValue);
        if (elementValue.getMovieName() != null) {
            Movie movie = new Movie();
            movie.setMovieName(elementValue.getMovieName());
            List<Movie> movieList = movieService.findMovies(movie);
            if (movieList.size() == 0) {
                model.addAttribute("message", "未查询到相关电影数据！");
                return elementValueList;
            }
            movie = movieList.get(0);
            elementValueService.deleteElementValue(elementValue);
            Noun noun1 = new Noun();
            noun1.setType(movie.getMovieType());
            List<Noun> nounArrayList = nounService.findNouns(noun1);
            HashMap<String, Integer[]> nounMap = new HashMap<>(nounArrayList.size());
            for (Noun noun2 : nounArrayList) {
                if (!nounMap.containsKey(noun2.getContent().trim())) {
                    Integer[] count = new Integer[2];
                    count[0] = count[1] = 0;
                    nounMap.put(noun2.getContent().trim(), count);
                }
            }
            Set<String> nounSet = nounMap.keySet();
            List<Positive> positiveList = positiveService.findPositives(new Positive());
            List<Negative> negativeList = negativeService.findNegatives(new Negative());
            HashSet<String> positiveSet = new HashSet<>();
            HashSet<String> negativeSet = new HashSet<>();
            for (Positive positive : positiveList) {
                positiveSet.add(positive.getDescription());
            }
            for (Negative negative : negativeList) {
                negativeSet.add(negative.getDescription());
            }
            Comment comment = new Comment();
            comment.setMovieName(movie.getMovieName());
            //查询属于该电影的影评数据
            List<Comment> commentList = commentService.findComments(comment);
            //利用符号对评论进行分割
            String regEx = "[。？！；，?.!,;]";
            for (Comment comment1 : commentList) {
                //统计每一种元素的好评和差评次数
                for (String s : nounSet) {
                    //该句中是否匹配电影元素词汇
                    if (!comment1.getComment().contains(s)) {
                        continue;
                    }
                    //利用分隔符对评论内容进行分割
                    String[] sentence = comment1.getComment().split(regEx);
                    for (String s1 : sentence) {
                        //逐一检查句中是否包含正面评价词汇，有则将该元素的正面评价数量加1
                        for (String s2 : positiveSet) {
                            if (s1.contains(s2)) {
                                nounMap.get(s)[0]++;
                            }
                        }
                        //逐一检查句中是否包含负面评价词汇，有则将该元素的负面评价数量加1
                        for (String s2 : negativeSet) {
                            if (s1.contains(s2)) {
                                nounMap.get(s)[1]++;
                            }
                        }
                    }
                }
            }
            elementValueList = new ArrayList<>();
            //将统计结果进行封装
            for (String s : nounSet) {
                ElementValue elementValue1 = new ElementValue();
                elementValue1.setMovieName(movie.getMovieName());
                elementValue1.setMovieType(movie.getMovieType());
                elementValue1.setKeyWard(s);
                elementValue1.setPositiveCount(nounMap.get(s)[0]);
                elementValue1.setNegativeCount(nounMap.get(s)[1]);
                insertElementValue(elementValue1);
                elementValueList.add(elementValue1);
            }
        }
        if (elementValueList.size() == 0) {
            model.addAttribute("message", "未查询到相关电影的评论分析数据！");
        }
        else
        {
            model.addAttribute("message", "电影"+elementValue.getMovieName()+"的评论数据分析成功！");
        }
        return elementValueList;
    }

    @GetMapping(value = "/toFindElementValues")
    public String toFindElementValues(@RequestParam(value = "currentPageNumber", defaultValue = "1", required = false) int currentPageNumber, Model model) {
        int pageSize = 24, startIndex = pageSize * (currentPageNumber - 1), endIndex = startIndex + pageSize;
        List<Movie> allMovieList = movieService.findMovies(new Movie());
        endIndex = endIndex < allMovieList.size() ? endIndex : allMovieList.size() - 1;
        List<Movie> movieList = allMovieList.subList(startIndex, endIndex);
        int pages = allMovieList.size() / pageSize;
        if (allMovieList.size() % pageSize != 0) {
            pages++;
        }
        List<Integer> navigatePageNumberList = new ArrayList<>();
        for (int i = 1; i <= pages; i++) {
            navigatePageNumberList.add(i);
        }
        model.addAttribute("pageNumber", currentPageNumber);
        model.addAttribute("pages", pages);
        model.addAttribute("total", allMovieList.size());
        model.addAttribute("navigatePageNumberList", navigatePageNumberList);
        model.addAttribute("movieList", movieList);
        return "elementValue/showElementValue";
    }
}
