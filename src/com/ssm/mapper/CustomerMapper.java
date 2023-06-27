package com.ssm.mapper;

import com.ssm.pojo.Customer;
import org.springframework.stereotype.Repository;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/9 0009
 * @version: 1.0
 */
@Repository("customerMapper")
public interface CustomerMapper {
    public Customer findCustomer(Customer customer);
}
