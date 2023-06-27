package com.ssm.controller;

import com.ssm.pojo.User1;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/8 0008
 * @version: 1.0
 */
//@Controller
public class LoginController {
    // 转向注册页面
    @RequestMapping("/toLogin")
    public String toRegister() {
        return "login";
    }

    @PostMapping(value="/login")
    public String logIn(User1 user, HttpSession session, Model model) {
        System.out.println(user);
        if(user.getUsername()!=null&&user.getUsername().equals( "admin")
                &&user.getPassword().equals( "123"))
        {
            //将用户名添加到session中
            session.setAttribute( "USER_SESSION", user);
            return "main";
        }
        else {
            model.addAttribute("msg","用户名或密码错误，请重新登录！");
        }
        return "login";
    }

    @RequestMapping("/logout")
    public String logOut(User1 user,HttpSession session) {
        session.invalidate();
        //重定向到登錄頁面
        return "login";
    }
}
