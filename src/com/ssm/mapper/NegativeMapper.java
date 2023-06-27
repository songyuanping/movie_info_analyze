package com.ssm.mapper;

import com.ssm.pojo.Negative;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("negativeMapper")
public interface NegativeMapper {
    public List<Negative> findNegatives(Negative negative);
}
