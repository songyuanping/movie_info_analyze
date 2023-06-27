package com.ssm.service;

import com.ssm.pojo.Commenter;

import java.util.List;

public interface CommenterService {
    List<Commenter> findCommenters(Commenter commenter);
}
