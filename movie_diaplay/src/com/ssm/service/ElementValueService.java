package com.ssm.service;

import com.ssm.pojo.ElementValue;

import java.util.List;

public interface ElementValueService {
    public List<ElementValue> findElementValues(ElementValue elementValue);
    public List<ElementValue> selectElementValues(ElementValue elementValue);
    public int insertElementValue(ElementValue elementValue);
    public int deleteElementValue(ElementValue elementValue);
}
