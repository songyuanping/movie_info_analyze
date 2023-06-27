package com.ssm.service;

import com.ssm.pojo.Administrator;

public interface AdministratorService {
    Administrator logIn(Administrator administrator);
    int updateAdministrator(Administrator administrator);
    int resetPassword(Administrator administrator);
    int register(Administrator administrator);
}
