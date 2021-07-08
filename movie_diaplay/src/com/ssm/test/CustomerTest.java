package com.ssm.test;

import com.ssm.pojo.Customer;
import com.ssm.tools.MySqlSession;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

public class CustomerTest {

	public void testFindById() {
		SqlSession sqlSession;
		try {
			sqlSession=MySqlSession.getSession();
			Customer customer = sqlSession.selectOne("com.com.com.ssm.mapper.CustomerMapper.findById",4);
			System.out.println(customer.toString());
			sqlSession.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void testFindByName(){
			SqlSession sqlSession;
			try {
				sqlSession=MySqlSession.getSession();
				Customer customer=new Customer();
				customer.setUsername( "yun");
				List<Customer> customers=sqlSession.selectList("com.com.com.ssm.mapper.CustomerMapper.findByName",customer);
				for (Customer cust : customers) {
					System.out.println(cust);
				}
				sqlSession.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
	}
	public void testAdd()  {
		SqlSession sqlSession ;
		try {
			sqlSession=MySqlSession.getSession();
			Customer customer = new Customer();
			customer.setUsername("mayun2");
			customer.setJobs("student");
			customer.setPhone("13812347767");
			int rows = sqlSession.insert("com.com.com.ssm.mapper.CustomerMapper.add",customer);
			if(rows > 0) {
				System.out.println("������ӳɹ�");
			}else {
				System.out.println("�������ʧ��");
			}
			sqlSession.commit();
			sqlSession.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
			
	}

	@Test
	public void testFindByUsernameAndJobs()
	{
		SqlSession sqlSession=null;
		try{
			sqlSession=MySqlSession.getSession();
			Customer customer=new Customer();
			customer.setUsername("yun");
			customer.setJobs("student");
			List<Customer> customers=sqlSession.selectList("com.com.ssm.mapper.CustomerMapper.findByUsernameAndJobs",customer);
			for(Customer customer1:customers)
			{
				System.out.println(customer1);
			}
			sqlSession.commit();
			sqlSession.close();
		}catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	@Test
	public void findByJobsAndPhone()
	{
		SqlSession sqlSession;
		try{
			sqlSession=MySqlSession.getSession();
			Customer customer=new Customer();
			customer.setJobs("student");
			customer.setPhone("13812347769");
			List<Customer> customers=sqlSession.selectList("com.com.ssm.mapper.CustomerMapper.findByJobsAndPhone",customer);
			for(Customer customer1:customers)
			{
				System.out.println(customer1);
			}
			sqlSession.commit();
			sqlSession.close();
		}catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	@Test
	public void findByColumns()
	{
		SqlSession sqlSession;
		try{
			sqlSession=MySqlSession.getSession();
			Customer customer=new Customer();
//			customer.setUsername("yun");
//			customer.setJobs("student");
			List<Customer> customers=sqlSession.selectList("com.com.ssm.mapper.CustomerMapper.findByColumns",customer);
			for(Customer customer1:customers)
			{
				System.out.println(customer1);
			}
			sqlSession.commit();
			sqlSession.close();
		}catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	@Test
	public void findByUsername()
	{
		SqlSession sqlSession;
		try{
			sqlSession=MySqlSession.getSession();
			Customer customer=new Customer();
			customer.setUsername("yun");
			List<Customer> customers=sqlSession.selectList("com.com.ssm.mapper.CustomerMapper.findByUsername",customer);
			for(Customer customer1:customers)
			{
				System.out.println(customer1);
			}
			sqlSession.commit();
			sqlSession.close();
		}catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	@Test
	public void findCustomersByIds()
	{
		SqlSession sqlSession;
		try{
			sqlSession=MySqlSession.getSession();
			List<Integer> list=new ArrayList<>();
			for(int i=1;i<=10;i++)
			{
				list.add(i);
			}
			List<Customer> customers=sqlSession.selectList("com.com.ssm.mapper.CustomerMapper.findCustomersByIds",list);
            for(Customer customer1:customers)
            {
                System.out.println(customer1);
            }
			sqlSession.close();
		}catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	@Test
    public void testUpdate()  {
        SqlSession sqlSession ;
        try {
            sqlSession=MySqlSession.getSession();
            Customer customer=new Customer();
            customer.setId(1);
            customer.setUsername("码云");
            customer.setJobs("学生");
            customer.setPhone("13867676771");
            sqlSession.update("com.com.ssm.mapper.CustomerMapper.update", customer);
            sqlSession.commit();
            sqlSession.close();
            System.out.println(customer);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    public void testDelete() {
        SqlSession sqlSession;
        try {
            sqlSession= MySqlSession.getSession();
            Customer customer=new Customer();
            customer.setId(6);
            sqlSession.delete( "com.com.com.ssm.mapper.CustomerMapper.delete", customer);
            customer=sqlSession.selectOne("com.com.com.ssm.mapper.CustomerMapper.findById", customer);
            sqlSession.commit();
            sqlSession.close();
            System.out.println(customer);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
