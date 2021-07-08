package com.ssm.pojo;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/7 0007
 * @version: 1.0
 */
public class User1 {
    private Integer id;
    private String username;
    private String password;

    @Override
    public String toString()
    {
        return "USer1 ["+id+","+username+","+password+"]";
    }
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
