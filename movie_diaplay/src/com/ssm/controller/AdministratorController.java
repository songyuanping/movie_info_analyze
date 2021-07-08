package com.ssm.controller;

import com.ssm.pojo.Administrator;
import com.ssm.service.AdministratorService;
import com.ssm.tools.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.Random;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/16 0016
 * @version: 1.0
 */
@Controller
@RequestMapping("/administrator")
public class AdministratorController {
    @Autowired
    private AdministratorService administratorService;

    @Autowired
    private JavaMailSender javaMailSender;

    @PostMapping(value = "/login")
    public String logIn(Administrator administrator, HttpSession session, Model model) {
        MD5 encoder = new MD5();
        String password = administrator.getPassword().trim();
        String userName = administrator.getUserName().trim();
        if (password.length() == 0 || userName.length() == 0) {
            model.addAttribute("message", "用户名或密码不能为空，请重新登录！");
            return "system/login";
        }
        for (int i = 0; i < 6; i++) {
            password = encoder.encrypt(password);
        }
        administrator.setPassword(password);
        Administrator administrator1 = administratorService.logIn(administrator);
        if (administrator1.getPassword().equals(password) && administrator1.getUserName().equals(userName)) {
            session.setAttribute("Administrator_SESSION", administrator1);
            return "system/main";
        }else {
            //将用户名添加到session中
            model.addAttribute("message", "用户名或密码错误，请重新登录！");
            return "system/login";
        }
    }

    @GetMapping(value = "/toRegister")
    public String toRegister() {
        return "system/register";
    }

    @PostMapping(value = "/register")
    public String register(Administrator administrator, Model model) {
        MD5 encoder = new MD5();
        String password = administrator.getPassword().trim();
        for (int i = 0; i < 6; i++) {
            password = encoder.encrypt(password);
        }
        //查询之前的登录密码
        Administrator administrator1 = administratorService.logIn(administrator);
        if (administrator1 != null) {
            model.addAttribute("message", "该手机号已注册，请登录！");
        } else {
            administrator.setPassword(password);
            int row = administratorService.register(administrator);
            if (row != 1) {
                model.addAttribute("message", "请填写有效的账户和密码信息！");
                return "system/register";
            } else {
                model.addAttribute("message", "注册成功，请登录本系统！");
            }
        }
        return "system/login";
    }

    @GetMapping(value = "/toUpdatePassword")
    public String toUpdatePassword() {
        return "system/editPassword";
    }

    @PostMapping(value = "/updatePassword")
    public String updatePassword(Administrator administrator, Model model) {
        MD5 encoder = new MD5();
//        String phone = administrator.getPhone().trim();
        String password = administrator.getPassword().trim();

//        System.out.println("in UpdatePassword before: " + password);

        for (int i = 0; i < 6; i++) {
            password = encoder.encrypt(password);
        }
        //查询之前的登录密码
        Administrator administrator1 = administratorService.logIn(administrator);
        if (password.equals(administrator1.getPassword())) {
            model.addAttribute("message", "新密码不能与旧密码相同！");
        } else {
            administrator.setPassword(password);
            int row = administratorService.updateAdministrator(administrator);
            if (row != 1) {
                model.addAttribute("message", "请填写有效的账户和密码信息！");
            } else {
                model.addAttribute("message", "修改管理员密码信息操作成功，请重新登录！");
                return "system/login";
            }
        }
        return "system/editPassword";
    }

    @GetMapping(value = "/toSendEmail")
    public String toSendEmail() {
        return "system/sendEmail";
    }

    @PostMapping(value = "/sendEmail")
    public String sendEmail(Administrator administrator, Model model) {
        MD5 encoder = new MD5();
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        //设置邮件发送方
        String emailFrom = "13361616067@qq.com";
        mailMessage.setFrom(emailFrom);
        //添加抄送人
        mailMessage.setCc(emailFrom);
        //设置邮件接收方
        mailMessage.setTo(administrator.getEmail());
        //设置主题
        mailMessage.setSubject("重置密码");
        //生成随机密码
        char[] pass=new char[6];
        for(int i=0;i<pass.length;i++)
        {
            if(i<pass.length/2){
                pass[i]=(char)('a'+ (int)(Math.random()*26));
            }
            else
            {
                pass[i]=(char)('0'+(int)(Math.random()*10));
            }
        }
        String password = String.valueOf(pass),pre=password;
        //对密码进行加密
        for (int i = 0; i < 6; i++) {
            password = encoder.encrypt(password);
        }
        //查询之前的登录密码
        administrator.setPassword(password);
        int row = administratorService.resetPassword(administrator);
        if (row != 1) {
            model.addAttribute("message", "请填写有效的用户名和邮箱信息！");
            return "system/sendEmail";
        }
        mailMessage.setText(administrator.getUserName()+" 已在本网站重置密码，新密码为："+pre+"。请尽快按照页面提示登录网站，切勿泄漏和转发他人。");
        //发送邮件
        javaMailSender.send(mailMessage);
        model.addAttribute("message", "您的密码已重置成功，请重新登录！");
        return "system/login";
    }

    @RequestMapping(value = "/logout")
    public String logOut(Administrator administrator, HttpSession session,Model model) {
        session.invalidate();
        model.addAttribute("您已离开本网站，欢迎您再次登录！");
        //重定向到登錄頁面
        return "system/login";
    }
}
