package com.ssm.test;

import com.ssm.pojo.Person;
import com.ssm.tools.MySqlSession;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

public class PersonTest {
    @Test
    public void findPersonById()
    {
        SqlSession sqlSession;
        try{
            sqlSession= MySqlSession.getSession();
            Person person=new Person();
            person.setId(1);
            person=sqlSession.selectOne("com.com.ssm.mapper.PersonMapper.findPersonById",person);
            System.out.println(person);
            sqlSession.close();
        }catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
