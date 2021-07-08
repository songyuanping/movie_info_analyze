package com.ssm.controller;

import com.ssm.pojo.City;
import com.ssm.pojo.Commenter;
import com.ssm.service.CityService;
import com.ssm.service.CommenterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/4/25 0025
 * @version: 1.0
 */
@Controller
@RequestMapping("/commenter")
public class CommenterController {
    @Autowired
    private CommenterService commenterService;

    @Autowired
    private CityService cityService;

    @ResponseBody
    @GetMapping(value = "/showJoinDateCount")
    public Map<String, Object> joinDateCount(Commenter commenter, Model model) {
        List<Commenter> commenterList = commenterService.findCommenters(commenter);
        //以评论用户的加入时间作为key值，统计每一年加入豆瓣网的用户数量
        Calendar calendar = Calendar.getInstance();
        Map<Integer, Integer> joinDateMap = new HashMap<>();
        for (Commenter commenter1 : commenterList) {
            calendar.setTime(commenter1.getJoinDate());
            int year = calendar.get(Calendar.YEAR);
            if (joinDateMap.containsKey(year)) {
                joinDateMap.put(year, joinDateMap.get(year) + 1);
            } else {
                joinDateMap.put(year, 1);
            }
        }
        List<Map.Entry<Integer, Integer>> entryList = new ArrayList<>(joinDateMap.entrySet());
        entryList.sort(Comparator.comparing(Map.Entry::getKey));
        List<Integer> yearList = new ArrayList<>();
        List<Integer> countList = new ArrayList<>();
        for (Map.Entry<Integer, Integer> map : entryList) {
            yearList.add(map.getKey());
            countList.add(map.getValue());
        }
        Map<String, Object> ret = new HashMap<>();
        ret.put("yearList", yearList);
        ret.put("countList", countList);
        if (yearList.size() > 0) {
            model.addAttribute("message", "用户注册年份数据分析成功！");
        } else {
            model.addAttribute("message", "用户注册年份数据分析失败！");
        }
        return ret;
    }

    @ResponseBody
    @GetMapping(value = "/liveCityCount")
    public Map<String, Object> liveCityCount(Commenter commenter, Model model) {
        List<Commenter> commenterList = commenterService.findCommenters(commenter);
        List<City> citys = cityService.findCitys(new City());
        Set<String> citySet = new HashSet<>();
        for (City city : citys) {
            if (city.getCityName().trim().length() > 0) {
                citySet.add(city.getCityName());
            }
        }
        List<String> cityList = new ArrayList<>(citySet);
        Map<String, List<Object>> liveCityCountMap = new HashMap<>();
        for (int i = 0; i < commenterList.size(); i++) {
            Commenter commenter1 = commenterList.get(i);
            String liveCity = commenter1.getLiveCity().trim();
            for (String city : cityList) {
                if (liveCity.contains(city)) {
                    List<Object> list = new ArrayList<>();
                    if (liveCityCountMap.containsKey(city)) {
                        //统计该居住地的评论者数量
                        list.add(0, (int) liveCityCountMap.get(city).get(0) + 1);
                        //累计该居住地的好友数量
                        list.add(1, (long) liveCityCountMap.get(city).get(1) + commenter1.getFriendCount());
                        //累计该居住地的粉丝数量
                        list.add(2, (long) liveCityCountMap.get(city).get(2) + commenter1.getFollowerCount());
                        liveCityCountMap.put(city, list);
                    } else {
                        list.add(0, 1);
                        list.add(1, (long) commenter1.getFriendCount());
                        list.add(2, (long) commenter1.getFollowerCount());
                        liveCityCountMap.put(city, list);
                    }
                    break;
                }
                if (cityList.get(cityList.size() - 1).equals(city) && !liveCity.contains(city)) {
                    commenter1.setLiveCity(cityList.get((int) Math.floor(Math.random() * cityList.size())));
                    commenterList.add(commenter1);
                }
            }
        }
        List<Map.Entry<String, List<Object>>> entryList = new ArrayList<>(liveCityCountMap.entrySet());
        entryList.sort((o1, o2) -> ((Integer) o2.getValue().get(0)).compareTo((Integer) o1.getValue().get(0)));
        List<String> liveCityList = new ArrayList<>();
        List<List<Object>> countList = new ArrayList<>();
        for (Map.Entry<String, List<Object>> map : entryList) {
            //计算平均好友数量
            map.getValue().set(1, (long) map.getValue().get(1) / (int) map.getValue().get(0));
            //计算电影平均评分
            map.getValue().set(2, (long) map.getValue().get(2) / (int) map.getValue().get(0));
            liveCityList.add(map.getKey());
            countList.add(map.getValue());
        }
        Map<String, Object> ret = new HashMap<>();
        ret.put("liveCityList", liveCityList);
        ret.put("countList", countList);
        if (liveCityList.size() > 0) {
            model.addAttribute("message", "用户居住地数据分析成功！");
        } else {
            model.addAttribute("message", "用户居住地数据分析失败！");
        }
        return ret;
    }
}
