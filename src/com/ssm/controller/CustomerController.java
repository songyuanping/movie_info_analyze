package com.ssm.controller;

import com.ssm.pojo.Customer;
import com.ssm.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/9 0009
 * @version: 1.0
 */
@Controller
public class CustomerController {
    @Autowired
    private CustomerService customerService;

    @RequestMapping("/toFind")
    public String toFindById() {
        return "findCustomer";
    }

    @PostMapping("/findCustomer")
    public String findCustomer(Customer customer, Model model)
    {
        Customer customer1 = customerService.findCustomer(customer);
        model.addAttribute("customer", customer1);
        return "customer";
    }
}
