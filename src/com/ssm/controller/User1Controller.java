package com.ssm.controller;

import com.ssm.pojo.User1;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/8 0008
 * @version: 1.0
 */
@Controller
public class User1Controller {

    @RequestMapping("/toJson")
    public String toJson() {
        return "json";
    }
    //接收页面请求的JSON数据，并返回JSON格式结果
    @ResponseBody
    @PostMapping("/testJson")
    public User1 testJson(@RequestBody User1 user) {
        System.out.println(user);
        return user;
    }

    @RequestMapping("/toRestful")
    public String toRestful() {
        return "restful";
    }

    //接收页面请求的JSON数据，并返回JSON格式结果
    //get提交的数据没有封装在pojo中
    @ResponseBody
    @GetMapping(value = "/user/{id}")
    public User1 testRestful(@PathVariable("id") String id) {
        User1 user = new User1();
        user.setId(Integer.valueOf(id));
        user.setUsername("郑浩");
        System.out.println(user);
        return user;
    }
}
