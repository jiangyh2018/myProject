package com.jah.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jah.ssm.bean.Department;
import com.jah.ssm.bean.Msg;
import com.jah.ssm.service.DepartmentService;

@Controller
@RequestMapping("/dept")
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	
	@RequestMapping("/getAllDepts")
	@ResponseBody
	public Msg getAllDepts(){
		List<Department> depts=departmentService.selectAll();
		
		return Msg.success().add("depts", depts);
	}
	
}
