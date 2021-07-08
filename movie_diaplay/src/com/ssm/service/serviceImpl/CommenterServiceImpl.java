package com.ssm.service.serviceImpl;

import com.ssm.mapper.CommenterMapper;
import com.ssm.pojo.Commenter;
import com.ssm.service.CommenterService;
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
public class CommenterServiceImpl implements CommenterService{
    @Autowired
    private CommenterMapper commenterMapper;

    @Override
    public List<Commenter> findCommenters(Commenter commenter) {
        return commenterMapper.findCommenters(commenter);
    }
}
