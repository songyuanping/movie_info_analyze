package com.ssm.pojo;

import java.util.List;

public class Product {
    private Integer id;
    private String name;
    private Integer price;
    private List<Order> orderList;
    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", price=" + price + ", orderList=" + orderList + "]";
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

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public List<Order> getOrderList() {
        return orderList;
    }

    public void setOrderList(List<Order> orderList) {
        this.orderList = orderList;
    }
}
