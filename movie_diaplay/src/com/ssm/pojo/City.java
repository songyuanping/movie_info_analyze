package com.ssm.pojo;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/4/25 0025
 * @version: 1.0
 */
public class City {
    private Integer id;
    private String cityName;
    @Override
    public String toString()
    {
        return "Positive:[ id= "+id+" cityName="+cityName+" ]\n";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }
}
