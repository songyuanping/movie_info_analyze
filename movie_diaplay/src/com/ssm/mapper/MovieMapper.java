package com.ssm.mapper;

import com.ssm.pojo.Movie;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("movieMapper")
public interface MovieMapper {
    /*
    *@params: [movie]
     *@return: 返回符合条件的电影列表
     *@created by: song yuanping
     *@date: 2020/4/1 0001
    */
    List<Movie> findMovies(Movie movie);/**
    /**
     *@params: [movie]
     *@return: java.util.List<com.ssm.pojo.Movie>
     *@created by: song yuanping
     *@date: 2020/4/1 0001
     */
    List<Movie> findMovieType(Movie movie);
    /**
     *@params: [movie]
     *@return: 查找每部电影的导演数据
     *@created by: song yuanping
     *@date: 2020/4/7 0007
     */
    List<Movie> queryDirectors(Movie movie);
}
