package com.ssm.mapper;

import com.ssm.pojo.Administrator;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/16 0016
 * @version: 1.0
 */
@Repository("administratorMapper")
public interface AdministratorMapper {
    List<Administrator> logIn(Administrator administrator);
    int updateAdministrator(Administrator administrator);
    int resetPassword(Administrator administrator);
    int register(Administrator administrator);
}
