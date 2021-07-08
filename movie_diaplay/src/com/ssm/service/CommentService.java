package com.ssm.service;

import com.ssm.pojo.Comment;

import java.util.List;

public interface CommentService {
    List<Comment> findComments(Comment comment);
}
