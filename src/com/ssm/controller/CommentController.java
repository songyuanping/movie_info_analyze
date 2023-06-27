package com.ssm.controller;

import com.ssm.pojo.Comment;
import com.ssm.pojo.Movie;
import com.ssm.service.CommentService;
import com.ssm.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.DecimalFormat;
import java.util.*;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/15 0015
 * @version: 1.0
 */
@Controller
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    @Autowired
    private MovieService movieService;

    @RequestMapping("/toFindComment")
    public String toFindById() {
        return "findComment";
    }

    @PostMapping("/findComment")
    public String findComment(Comment comment, Model model) {
        List<Comment> commentList = commentService.findComments(comment);
        model.addAttribute("commentList", commentList);
        return "comments";
    }

    @ResponseBody
    @GetMapping("/showMovieCount")
    //将所有的演员数据以词云图的形式进行展示
    public Map<String, Object> showMovieCount(Comment comment, Model model) {
        List<Comment> commentList = commentService.findComments(comment);
        //用户名和其所评论过的电影形成的map
        Map<String, Set<String>> commenterMap = new HashMap<>(commentList.size());
        for (Comment comment1 : commentList) {
            String commenter = comment1.getUserName().trim();
            if (commenterMap.containsKey(commenter)) {
                Set<String> set = commenterMap.get(commenter);
                set.add(comment1.getMovieName().trim());
                commenterMap.put(commenter, set);
            } else if(commenter.length()>0){
                Set<String> set = new HashSet<>();
                set.add(comment1.getMovieName().trim());
                commenterMap.put(commenter, set);
            }
        }
        //依据观影数量统计对应的用户数量
        Map<Integer,Integer> movieCountMap=new HashMap<>();
        for (String commenter:commenterMap.keySet()) {
            Integer movieCount=commenterMap.get(commenter).size();
            if (movieCountMap.containsKey(movieCount)) {
                movieCountMap.put(movieCount, movieCountMap.get(movieCount)+1);
            } else {
                movieCountMap.put(movieCount,1);
            }
        }
        Map<String, Object> ret = new HashMap<>();
        if (movieCountMap.size() > 0) {
            model.addAttribute("message", "用户观影数量分析成功！");
        } else {
            model.addAttribute("message", "用户观影数量分析失败！");
        }
        ret.put("movieCountMap", movieCountMap);
        return ret;
    }

    @ResponseBody
    @GetMapping("/showCommenterCount")
    //将所有的演员数据以词云图的形式进行展示
    public Map<String, Object> showCommenterCount(Comment comment, Model model) {
        List<Comment> commentList = commentService.findComments(comment);
        Map<String, List<Object>> commenterMap = new HashMap<>(commentList.size());
        for (Comment comment1 : commentList) {
            String commenter = comment1.getUserName().trim();
            if (commenterMap.containsKey(commenter)) {
                List<Object> list = commenterMap.get(commenter);
                list.set(0, (Integer) list.get(0) + 1);
                commenterMap.put(commenter, list);
            } else if(commenter.length()>0){
                List<Object> list = new ArrayList<>();
                list.add(1);
                commenterMap.put(commenter, list);
            }
        }
//        System.out.println(commenterMap.keySet());
        Map<String, Object> ret = new HashMap<>();
        if (commenterMap.size() > 0) {
            model.addAttribute("message", "用户名称数据分析成功！");
        } else {
            model.addAttribute("message", "用户名称数据分析失败！");
        }
        ret.put("commenterMap", commenterMap);
        return ret;
    }

    @GetMapping (value = "/toAnalyzeCommentScore")
    public String toAnalyzeCommentScore(@RequestParam(value = "movieName", defaultValue = "肖申克的救赎", required = true) String movieName, Model model){
        if(movieName!=null&&movieName.trim().length()>0)
        {
            model.addAttribute("message","电影名称输入成功！");
            model.addAttribute("movieName",movieName);
        }
        else {
            model.addAttribute("message","电影名称不能为空，请重新输入！");
        }
        return "comment/analyzeCommentScore";
    }

    @ResponseBody
    @PostMapping("/analyzeCommentScore")
    //根据电影名称查找该电影影评数据，分析评分段的评分占比情况
    public Map<String, Object> analyzeCommentScore(@RequestBody Comment comment, Model model) {
        List<Comment> commentList = commentService.findComments(comment);
        Set<Integer> scoreSet = new HashSet<>();
        for (Comment comment1 : commentList) {
            scoreSet.add(comment1.getScore());
        }
        List<Integer> scoreList = new ArrayList<>(scoreSet);
        Double[] rateList = new Double[scoreList.size()];
        for (int i = 0; i < rateList.length; i++) {
            rateList[i] = 0.0;
        }
//        scoreList.sort(Integer::compareTo);
        for (Comment comment1 : commentList) {
            int index = scoreList.indexOf(comment1.getScore());
            rateList[index] += 1;
        }
        //设置浮点数格式
        DecimalFormat decimalFormat = new DecimalFormat("0.00 ");
        for (int i = 0; i < rateList.length; i++) {
            //计算百分率
            rateList[i] = Double.parseDouble(decimalFormat.format(rateList[i] * 100 / commentList.size()));
        }
        //对数组进行联动排序
        for(int i=0;i<rateList.length-1;i++)
        {
            for(int j=i+1;j<rateList.length;j++)
            {
                if(rateList[i]<rateList[j])
                {
                    //对星级比例数组排序
                    Double d=rateList[i];
                    rateList[i]=rateList[j];
                    rateList[j]=d;
                    //对星级排序
                    Integer integer=scoreList.get(i);
                    scoreList.set(i,scoreList.get(j));
                    scoreList.set(j,integer);
                }
            }
        }
        Map<String, Object> ret = new HashMap<>();
        ret.put("scoreList", scoreList);
        ret.put("rateList", rateList);
        ret.put("movieName", comment.getMovieName());
        if (scoreList.size() > 0) {
            model.addAttribute("message", "电影评分分析数据加载成功！");
        } else {
            model.addAttribute("message", "无该电影的评论数据！");
        }
        return ret;
    }

    @GetMapping("/toShowCommentInfo")
    public String toShowCommentInfo() {
        return "comment/showCommentInfo";
    }

    //定义向页面返回的数据格式
    private class TypeItem {
        private String movieType;
        private long praiseCount;
        private long commentCount;
        private long totalScore;
        private Integer averageScore;

        public TypeItem(String movieType) {
            this.movieType = movieType;
            this.praiseCount = 0;
            this.commentCount = 0;
            this.totalScore = 0;
            this.averageScore = 0;
        }

        @Override
        public String toString() {
            return "TypeItem:[ movieType= " + movieType + " praiseCount= " + praiseCount + " commentCount= " + commentCount + " totalScore= " + totalScore + " averageScore= " + averageScore + " ]\n";
        }

        public String getMovieType() {
            return movieType;
        }

        public void setMovieType(String movieType) {
            this.movieType = movieType;
        }

        public Long getPariseCount() {
            return praiseCount;
        }

        public void setPariseCount(Long praiseCount) {
            this.praiseCount = praiseCount;
        }

        public Long getCommentCount() {
            return commentCount;
        }

        public void setCommentCount(Long commentCount) {
            this.commentCount = commentCount;
        }

        public Long getTotalScore() {
            return totalScore;
        }

        public void setTotalScore(Long totalScore) {
            this.totalScore = totalScore;
        }

        public Integer getAverageScore() {
            return averageScore;
        }

        public void setAverageScore(Integer averageScore) {
            this.averageScore = averageScore;
        }
    }

    @GetMapping("/showCommentInfo")
    @ResponseBody
    public Map<String, Object> showCommentInfo(Comment comment, Model model) {
        List<Comment> commentList = commentService.findComments(comment);
        Set<Integer> yearSet = new HashSet<>();
        Calendar calendar = Calendar.getInstance();
        commentList.sort(Comparator.comparing(Comment::getDateTime));
        List<Movie> movieList = movieService.findMovieType(new Movie());
        //以电影名称作为电影的id构成一个map以便对comment进行分类
        Map<String,Movie> movieMap=new HashMap<>(movieList.size());
        Set<String> typeSet = new HashSet<>();
        for (Movie movie1 : movieList) {
            String[] movieTypes = movie1.getMovieType().split(" ");
            typeSet.addAll(Arrays.asList(movieTypes));
            movieMap.put(movie1.getMovieName(),movie1);
        }
        List<String> typeList = new ArrayList<>(typeSet);
        for (Comment comment1 : commentList) {
            calendar.setTime(comment1.getDateTime());
            yearSet.add(calendar.get(Calendar.YEAR));
        }
        //存放评论发表的年份
        ArrayList<Integer> yearList = new ArrayList<>(yearSet);
        yearList.sort(Comparator.comparing(Integer::valueOf));
        //将评论按照发表的年份进行分类
        Map<Integer, ArrayList<Comment>> yearCommentMap = new HashMap<>(yearList.size());
        for (Integer year : yearList) {
            yearCommentMap.put(year, new ArrayList<>());
            for (Comment comment1 : commentList) {
                calendar.setTime(comment1.getDateTime());
                if (calendar.get(Calendar.YEAR) == year) {
                    yearCommentMap.get(year).add(comment1);
                } else if (calendar.get(Calendar.YEAR) > year) {
                    break;
                }
            }
        }
        Map<Integer, ArrayList<TypeItem>> yearItemMap = new HashMap<>(yearList.size());
        for (Integer year : yearList) {
            yearItemMap.put(year, new ArrayList<>());
            for (String type : typeList) {
                yearItemMap.get(year).add(new TypeItem(type));
            }
            commentList = yearCommentMap.get(year);
            ArrayList<TypeItem> typeItemArrayList = yearItemMap.get(year);
            for (Comment comment1 : commentList) {
                Movie movie;
                if(movieMap.containsKey(comment1.getMovieName())){
                    movie=movieMap.get(comment1.getMovieName());
                    String movieType = movie.getMovieType();
                    String[] types = movieType.split(" ");
                    if (types.length > 1 && types[0].equals("剧情")) {
                        movieType = types[(int) (1 + Math.random() * (types.length - 1))];
                    } else {
                        movieType = types[(int) (Math.random() * types.length)];
                    }
                    movie.setMovieType(movieType.trim());
                } else {
                    continue;
                }
                String movieType = movie.getMovieType();
                for (TypeItem typeItem : typeItemArrayList) {
                    if (movieType.equals(typeItem.getMovieType())) {
                        typeItem.setPariseCount(typeItem.getPariseCount() + comment1.getPraise());
                        typeItem.setCommentCount(typeItem.getCommentCount() + 1);
                        typeItem.setTotalScore(typeItem.getTotalScore() + comment1.getScore());
                        break;
                    }
                }
            }
            for (TypeItem typeItem : typeItemArrayList) {
                if (typeItem.getCommentCount() > 0) {
                    typeItem.setAverageScore((int) (typeItem.getTotalScore() / typeItem.getCommentCount()));
                }
            }
        }
        //将历年数据进行求和
        for (int i = 1; i < yearList.size(); i++) {
            Integer last = yearList.get(i - 1), year = yearList.get(i);
            ArrayList<TypeItem> lastTypeItemArrayList = yearItemMap.get(last);
            ArrayList<TypeItem> typeItemArrayList = yearItemMap.get(year);
            for (int j = 0; j < typeItemArrayList.size(); j++) {
                TypeItem thisItem = typeItemArrayList.get(j), lastItem = lastTypeItemArrayList.get(j);
                thisItem.setPariseCount(lastItem.getPariseCount() + thisItem.getPariseCount());
                thisItem.setCommentCount(lastItem.getCommentCount() + thisItem.getCommentCount());
                thisItem.setTotalScore(lastItem.getTotalScore() + thisItem.getTotalScore());
                if (thisItem.getCommentCount() > 0) {
                    thisItem.setAverageScore((int) (thisItem.getTotalScore() / thisItem.getCommentCount()));
                }
            }
        }
        Map<String, Object> ret = new HashMap<>();
        if (yearItemMap.size() > 0) {
            model.addAttribute("message", "电影评论数据加载成功！");
        } else {
            model.addAttribute("message", "电影评论数据加载失败！");
        }
        ret.put("yearItemMap", yearItemMap);
        ret.put("typeList", typeList);
        return ret;
    }
}
