package com.ssm.pojo;

import java.sql.Date;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/15 0015
 * @version: 1.0
 */
public class Comment {
    private Integer id;
    private String movieName;
    private String userName;
    private String comment;
    private Integer praise;
    private Date dateTime;
    private Integer score;

    @Override
    public String toString() {
        return "\nComment:[id=" + id + "movieName=" + movieName + "userName=" + userName +
                "comment=" + comment + "praise=" + praise + "dateTime=" + dateTime +
                "score=" + score + "]\n";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Integer getPraise() {
        return praise;
    }

    public void setPraise(Integer praise) {
        this.praise = praise;
    }

    public Date getDateTime() {
        return dateTime;
    }

    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
}
