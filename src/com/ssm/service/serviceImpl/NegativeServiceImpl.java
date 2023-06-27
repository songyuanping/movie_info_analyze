package com.ssm.service.serviceImpl;

import com.ssm.mapper.NegativeMapper;
import com.ssm.pojo.Negative;
import com.ssm.service.NegativeService;
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
public class NegativeServiceImpl implements NegativeService {
    @Autowired
    private NegativeMapper negativeMapper;

    @Override
    public List<Negative> findNegatives(Negative negative) {
        return negativeMapper.findNegatives(negative);
    }
}
