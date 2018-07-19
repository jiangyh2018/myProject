package com.jah.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jah.ssm.bean.Department;
import com.jah.ssm.bean.DepartmentExample;
import com.jah.ssm.dao.DepartmentMapper;

@Service
public class DepartmentService {
	@Autowired
	private DepartmentMapper departmentMapper;
	
	public List<Department> selectAll(){
		
		return departmentMapper.selectByExample(null);
	}
}
