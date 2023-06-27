package com.ssm.service;

import com.ssm.pojo.City;

import java.util.List;

public interface CityService {
    List<City> findCitys(City city);
}
