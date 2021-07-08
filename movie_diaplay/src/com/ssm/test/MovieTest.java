package com.ssm.test;

import com.ssm.pojo.Movie;
import com.ssm.service.serviceImpl.MovieServiceImpl;
import org.junit.Test;

import java.util.List;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/15 0015
 * @version: 1.0
 */
public class MovieTest {

    @Test
    public void findMovies() {
        Movie movie = new Movie();
        movie.setRank(1);
        List<Movie> movies = new MovieServiceImpl().findMovies(movie);
        for (Movie movie1 : movies) {
            System.out.println(movie1);
        }
    }
}
