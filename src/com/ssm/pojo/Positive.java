package com.ssm.pojo;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/15 0015
 * @version: 1.0
 */
public class Positive {
    private Integer id;
    private String description;
    @Override
    public String toString()
    {
        return "Positive:[ id= "+id+" description="+description+" ]\n";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
