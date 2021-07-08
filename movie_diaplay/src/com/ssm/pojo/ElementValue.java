package com.ssm.pojo;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/15 0015
 * @version: 1.0
 */
public class ElementValue {
    private Integer id;
    private String movieName;
    private String movieType;
    private String keyWard;
    private Integer positiveCount;
    private Integer negativeCount;

    @Override
    public String toString() {
        return "elementValue: [id=" + id + " movieName=" + movieName +
                " movieType=" + movieType + " keyWard=" + keyWard + " positiveCount=" + positiveCount +
                " negativeCount= " + negativeCount + "]";
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

    public String getMovieType() {
        return movieType;
    }

    public void setMovieType(String movieType) {
        this.movieType = movieType;
    }

    public String getKeyWard() {
        return keyWard;
    }

    public void setKeyWard(String keyWard) {
        this.keyWard = keyWard;
    }

    public Integer getPositiveCount() {
        return positiveCount;
    }

    public void setPositiveCount(Integer positiveCount) {
        this.positiveCount = positiveCount;
    }

    public Integer getNegativeCount() {
        return negativeCount;
    }

    public void setNegativeCount(Integer negativeCount) {
        this.negativeCount = negativeCount;
    }
}
