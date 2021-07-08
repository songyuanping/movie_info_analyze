package com.ssm.mapper;

import com.ssm.pojo.Commenter;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("commenterMapper")
public interface CommenterMapper {
    List<Commenter> findCommenters(Commenter commenter);
}