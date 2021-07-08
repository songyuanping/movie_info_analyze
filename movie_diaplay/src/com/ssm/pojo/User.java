package com.ssm.pojo;

import java.util.List;

/**
 * @author Administrator
 */
public class User {
    private Integer id;
    private String name;
    private Integer age;
    private String password;
    private String phone;
    private List<Order> orderList;

    @Override
    public String toString() {
        return "User [id=" + id + ", name=" + name + ", age=" + age + ", password=" + password + ", phone=" + phone
                + "]";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public List<Order> getOrderList() {
        return orderList;
    }

    public void setOrderList(List<Order> orderList) {
        this.orderList = orderList;
    }
}
