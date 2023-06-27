package com.ssm.service.serviceImpl;

import com.ssm.mapper.NounMapper;
import com.ssm.pojo.Noun;
import com.ssm.service.NounService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/16 0016
 * @version: 1.0
 */
@Service
public class NounServiceImpl implements NounService {
    @Autowired
    private  NounMapper nounMapper;
    @Override
    public List<Noun> findNouns(Noun noun) {
        return nounMapper.findNouns(noun);
    }
}
