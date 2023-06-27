package com.ssm.tools;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.Reader;

public class MySqlSession
{
		private static SqlSessionFactory sqlSessionFactory=null;
		private static String config= "resources/mybatis-config.xml";
		static {
			try{
				Reader reader=Resources.getResourceAsReader(config);
				sqlSessionFactory=new SqlSessionFactoryBuilder().build(reader);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		public static SqlSession getSession()
		{
			return sqlSessionFactory.openSession();
		}
}