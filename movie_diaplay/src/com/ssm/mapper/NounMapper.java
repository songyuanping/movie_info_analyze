package com.ssm.mapper;

import com.ssm.pojo.Noun;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository("nounMapper")
public interface NounMapper {
    List<Noun> findNouns(Noun noun);
}
