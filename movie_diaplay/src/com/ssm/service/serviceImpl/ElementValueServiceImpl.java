package com.ssm.service.serviceImpl;

import com.ssm.mapper.ElementValueMapper;
import com.ssm.pojo.ElementValue;
import com.ssm.service.ElementValueService;
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
public class ElementValueServiceImpl implements ElementValueService {
    @Autowired
    private ElementValueMapper elementValueMapper;

    @Override
    public List<ElementValue> findElementValues(ElementValue elementValue) {
        return elementValueMapper.findElementValues(elementValue);
    }

    @Override
    public List<ElementValue> selectElementValues(ElementValue elementValue) {
        return elementValueMapper.selectElementValues(elementValue);
    }

    @Override
    public int insertElementValue(ElementValue elementValue) {
        return elementValueMapper.insertElementValue(elementValue);
    }

    @Override
    public int deleteElementValue(ElementValue elementValue) {
        return elementValueMapper.deleteElementValue(elementValue);
    }
}
