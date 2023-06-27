package com.ssm.service.serviceImpl;

import com.ssm.mapper.CommentMapper;
import com.ssm.pojo.Comment;
import com.ssm.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/15 0015
 * @version: 1.0
 */
@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentMapper commentMapper;

    @Override
    public List<Comment> findComments(Comment comment) {
        return commentMapper.findComments(comment);
    }
}
