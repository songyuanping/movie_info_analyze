package com.ssm.pojo;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/16 0016
 * @version: 1.0
 */
public class Administrator {
    private Integer id;
    private String userName;
    private String password;
    private String email;
    private String phone;
    @Override
    public String toString()
    {
        return "Administrator [ id= "+id+",userName= "+userName+", password="+password+"]\n";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
