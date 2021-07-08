package com.ssm.service.serviceImpl;

import com.ssm.mapper.CityMapper;
import com.ssm.pojo.City;
import com.ssm.service.CityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/4/25 0025
 * @version: 1.0
 */
@Service
public class CityServiceImpl implements CityService {
    @Autowired
    private CityMapper cityMapper;

    @Override
    public List<City> findCitys(City city) {
        return cityMapper.findCitys(city);
    }
}
