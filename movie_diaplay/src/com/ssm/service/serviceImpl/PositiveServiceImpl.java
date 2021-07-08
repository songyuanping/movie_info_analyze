package com.ssm.service.serviceImpl;

import com.ssm.mapper.PositiveMapper;
import com.ssm.pojo.Positive;
import com.ssm.service.PositiveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/15 0015
 * @version: 1.0
 */
@Service
@Transactional
public class PositiveServiceImpl implements PositiveService {
    @Autowired
    private PositiveMapper positiveMapper;

    @Override
    public List<Positive> findPositives(Positive positive) {
        return positiveMapper.findPositives(positive);
    }
}
