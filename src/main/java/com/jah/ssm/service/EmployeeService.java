package com.jah.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jah.ssm.bean.Employee;
import com.jah.ssm.dao.EmployeeMapper;
@Service
public class EmployeeService {

	@Autowired
	private EmployeeMapper employeeMapper;
	
	public int countName(String name){
		return employeeMapper.countByEmpName(name);
	}
	
	public void insertEmp(Employee emp){
		employeeMapper.insertSelective(emp);
	}
	
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}
}
