package com.ssm.mapper;

import com.ssm.pojo.Positive;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("positiveMapper")
public interface PositiveMapper {
    public List<Positive> findPositives(Positive positive);
}
