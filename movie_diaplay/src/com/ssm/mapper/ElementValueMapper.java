package com.ssm.mapper;

import com.ssm.pojo.ElementValue;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("elementValueMapper")
public interface ElementValueMapper {
    List<ElementValue> findElementValues(ElementValue elementValue);

    List<ElementValue> selectElementValues(ElementValue elementValue);

    int insertElementValue(ElementValue elementValue);

    int deleteElementValue(ElementValue elementValue);
}
