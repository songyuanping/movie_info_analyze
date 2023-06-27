package com.ssm.controller;

import com.ssm.pojo.Person;
import com.ssm.pojo.User1;
import com.ssm.pojo.User1VO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class FirstController {

    //...省略向用户批量修改页面跳转方法
    @RequestMapping("/editUsers")
    public String editUsers(User1VO userList,Model model) {
//        User1VO中的变量名为user1s
        List<User1> user1s = userList.getUser1s();
        String s="";
        for (User1 user : user1s) {
            if (user.getId() != null) {
                s+="修改了id为" + user.getId() + "的用户名为：" + user.getUsername()+"的用户\n";
            }
        }
        model.addAttribute("msg", s);
        return "first";
    }

    @RequestMapping("/deleteUsers")
    public String deleteUsers(Integer[] ids, Model model) {
        String s = "";
        if (ids != null) {
            for (Integer id : ids) {
                s += "删除了id为" + id + "的用户！\n";
            }
        } else {
            s += "ids=null";
        }
        model.addAttribute("msg", s);
        return "first";
    }

    @RequestMapping("/findIDCard")
    public String registerUser(Person person, Model model) {
        Integer id = person.getId();
        String code = person.getCard().getCode();
        model.addAttribute("msg", "接收到了id=" + id + " card.code=" + code);
        return "first";
    }

    @RequestMapping("/registerUser")
    public String registerUser(User1 user, Model model) {
        String username = user.getUsername();
        String password = user.getPassword();
        System.out.println("username=" + username);
        System.out.println("password=" + password);
        model.addAttribute("msg", "接收到了username=" + username + " password=" + password);
        return "first";
    }

    @RequestMapping(value = "/selectUser", method = RequestMethod.GET)
    public String selectUser(@RequestParam(value = "user_id") Integer id, Model model) {
        System.out.println("id=" + id);
        model.addAttribute("msg", "接收到了user_id! user_id=" + id);
        return "first";
    }

    @RequestMapping(value = "/firstController", method = RequestMethod.GET)
    public String handle(Model model) {
        model.addAttribute("msg", "噢噢噢噢灰色空间活动经费GV交互！SpringMVC!");
        return "first";
    }
}
