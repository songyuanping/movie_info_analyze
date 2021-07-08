package com.ssm.pojo;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/15 0015
 * @version: 1.0
 */
public class Movie {
    private Integer id;
    private Integer rank;
    private String movieName;
    private String actors;
    private String director;
    private String showYear;
    private String makeCountry;
    private String movieType;
    private Double movieScore;
    private Integer commenterNumber;
    private String filmInfo;

    @Override
    public String toString() {
        return "\nMovie:[id=" + id + " rank=" + rank + " movieName=" + movieName +
                " actors=" + actors + " director=" + director + " showYear=" + showYear +
                " makeCountry=" + makeCountry + " movieType=" + movieType
                + " movieScore=" + movieScore + " commenterNumber=" + commenterNumber + " filmInfo=" + filmInfo + "]\n";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getActors() {
        return actors;
    }

    public void setActors(String actors) {
        this.actors = actors;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getShowYear() {
        return showYear;
    }

    public void setShowYear(String showYear) {
        this.showYear = showYear;
    }

    public String getMakeCountry() {
        return makeCountry;
    }

    public void setMakeCountry(String makeCountry) {
        this.makeCountry = makeCountry;
    }

    public String getMovieType() {
        return movieType;
    }

    public void setMovieType(String movieType) {
        this.movieType = movieType;
    }

    public Double getMovieScore() {
        return movieScore;
    }

    public void setMovieScore(Double movieScore) {
        this.movieScore = movieScore;
    }

    public Integer getCommenterNumber() {
        return commenterNumber;
    }

    public void setCommenterNumber(Integer commenterNumber) {
        this.commenterNumber = commenterNumber;
    }

    public String getFilmInfo() {
        return filmInfo;
    }

    public void setFilmInfo(String filmInfo) {
        this.filmInfo = filmInfo;
    }
}
