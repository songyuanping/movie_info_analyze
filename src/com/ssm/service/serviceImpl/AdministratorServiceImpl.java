package com.ssm.service.serviceImpl;

import com.ssm.mapper.AdministratorMapper;
import com.ssm.pojo.Administrator;
import com.ssm.service.AdministratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/16 0016
 * @version: 1.0
 */
@Service
public class AdministratorServiceImpl implements AdministratorService {
    @Autowired
    private  AdministratorMapper administratorMapper;

    @Override
    public Administrator logIn(Administrator administrator) {
        List<Administrator> administratorList=administratorMapper.logIn(administrator);
        return administratorList.size()>0?administratorList.get(0):null;
    }

    @Override
    public int updateAdministrator(Administrator administrator) {
        return administratorMapper.updateAdministrator(administrator);
    }

    @Override
    public int resetPassword(Administrator administrator) {
        return administratorMapper.resetPassword(administrator);
    }

    @Override
    public int register(Administrator administrator) {
        return administratorMapper.register(administrator);
    }
}
