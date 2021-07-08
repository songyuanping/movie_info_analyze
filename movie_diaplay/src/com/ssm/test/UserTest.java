package com.ssm.test;


import com.ssm.pojo.Order;
import org.apache.ibatis.session.SqlSession;

import com.ssm.pojo.User;
import com.ssm.tools.MySqlSession;
import org.junit.Test;

import java.util.List;

public class UserTest {
    @Test
    public void testFindAll() {
        SqlSession sqlSession;
        try {
            sqlSession=MySqlSession.getSession();
            List<User> uList = sqlSession.selectList("com.com.ssm.mapper.UserMapper.findAll");
            for (User user : uList) {
                System.out.println(user);
            }
            sqlSession.commit();
            sqlSession.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void findUserOrder() {
        SqlSession sqlSession;
        try {
            sqlSession=MySqlSession.getSession();
            User user=new User();
            user.setId(2);
            user = sqlSession.selectOne("com.com.ssm.mapper.UserMapper.findUserOrder",user);
            for (Order order:user.getOrderList()) {
                System.out.println(order);
            }
            sqlSession.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
