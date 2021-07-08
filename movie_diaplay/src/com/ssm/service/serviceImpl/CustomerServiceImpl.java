package com.ssm.service.serviceImpl;

import com.ssm.mapper.CustomerMapper;
import com.ssm.pojo.Customer;
import com.ssm.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/9 0009
 * @version: 1.0
 */
@Service
@Transactional
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public Customer findCustomer(Customer customer) {
        return customerMapper.findCustomer(customer);
    }
}
