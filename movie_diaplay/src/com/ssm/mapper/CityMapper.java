package com.ssm.mapper;

import com.ssm.pojo.City;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("cityMapper")
public interface CityMapper {
    List<City> findCitys(City city);
}
