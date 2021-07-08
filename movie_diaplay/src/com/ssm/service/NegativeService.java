package com.ssm.service;

import com.ssm.pojo.Negative;

import java.util.List;

public interface NegativeService {
    public List<Negative> findNegatives(Negative negative);
}
