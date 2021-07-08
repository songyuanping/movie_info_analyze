package com.ssm.pojo;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/15 0015
 * @version: 1.0
 */
public class Noun {
    private Integer id;
    private String type;
    private String content;
    @Override
    public String toString()
    {
        return "Noun:[ id= "+id+" type="+type+" content= "+content+" ]\n";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
