package com.ssm.service;

import com.ssm.pojo.Positive;

import java.util.List;

public interface PositiveService {
    public List<Positive> findPositives(Positive negative);
}
