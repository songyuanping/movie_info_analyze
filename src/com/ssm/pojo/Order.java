package com.ssm.pojo;

import java.util.List;

public class Order {
    private Integer id;
    private Integer number;
    private Integer user_id;
    private List<Product> productList;

    @Override
    public String toString() {
        return "Order [id=" + id + ", number=" + number + ", user_id=" + user_id + ", productList=" + productList
                + "]";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }
}
