package com.ssm.service.serviceImpl;

import com.ssm.mapper.MovieMapper;
import com.ssm.pojo.Movie;
import com.ssm.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/15 0015
 * @version: 1.0
 */
@Service
public class MovieServiceImpl implements MovieService {

    @Autowired
    private  MovieMapper movieMapper;

    @Override
    public List<Movie> findMovies(Movie movie) {
        return movieMapper.findMovies(movie);
    }

    @Override
    public List<Movie> findMovieType(Movie movie) {
        return movieMapper.findMovieType(movie);
    }

    @Override
    public List<Movie> queryDirectors(Movie movie) {
        return movieMapper.queryDirectors(movie);
    }
}
