package com.ssm.service;

import com.ssm.pojo.Noun;

import java.util.List;

public interface NounService {
    public List<Noun> findNouns(Noun noun);
}
