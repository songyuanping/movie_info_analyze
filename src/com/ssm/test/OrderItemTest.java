package com.ssm.test;

import com.ssm.pojo.Order;
import com.ssm.tools.MySqlSession;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

public class OrderItemTest {
    @Test
    public void findAllProductsInOrder()
    {
        SqlSession sqlSession;
        try{
            sqlSession= MySqlSession.getSession();
            Order order=new Order();
            order.setId(1);
            System.out.println(order);
            order=sqlSession.selectOne("com.com.ssm.mapper.OrderItemMapper.findAllProductsInOrder",order);
            System.out.println(order);
            sqlSession.close();
        }catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
