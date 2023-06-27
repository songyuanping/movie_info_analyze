package com.ssm.service;

import com.ssm.pojo.Movie;

import java.util.List;

public interface MovieService {
    List<Movie> findMovies(Movie movie);
    List<Movie> findMovieType(Movie movie);
    List<Movie> queryDirectors(Movie movie);
}
