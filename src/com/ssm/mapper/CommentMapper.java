package com.ssm.mapper;

import com.ssm.pojo.Comment;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 *@params:
 *@return:
 *@created by: song yuanping
 *@date: 2020/3/15 0015
 */
@Repository("commentMapper")
public interface CommentMapper {
    List<Comment> findComments(Comment comment);
}
