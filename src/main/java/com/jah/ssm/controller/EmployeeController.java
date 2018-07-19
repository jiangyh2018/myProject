package com.jah.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jah.ssm.bean.Employee;
import com.jah.ssm.bean.Msg;
import com.jah.ssm.service.EmployeeService;

@RequestMapping("/employee")
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping("/checkName")
	@ResponseBody
	public Msg checkName(@RequestParam(value="name")String name){
		int num=employeeService.countName(name);
		return Msg.success().add("num", num);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public Msg add(@RequestParam(value = "name") String empName, @RequestParam(value="email") String email,
			@RequestParam(value="gender") String gender,@RequestParam(value="dId")Integer dId) {
		System.out.println(empName+"-"+email+"-"+gender+"-"+dId);
		employeeService.insertEmp(new Employee(null, empName, gender, email, dId));
		return Msg.success();
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Msg list(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum){
		
		PageHelper.startPage(pageNum, 5);
		List<Employee> emps=employeeService.getAll();
		
		PageInfo pageInfo=new PageInfo(emps, 5);
		
		return Msg.success().add("pageInfo",pageInfo);
	}

	@RequestMapping("/list1")
	public String list(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum, Model model) {
		// 使用PageHelper分页插件完成分页，传入页码以及每页的数量
		PageHelper.startPage(pageNum, 5);
		//后面紧跟的查询就是分页查询
		List<Employee> emps = employeeService.getAll();
		//使用PageInfo包装查询后的结果，封装了详细的分页信息以及查询结果。
		PageInfo pageInfo = new PageInfo(emps, 5);

		model.addAttribute("pageInfo", pageInfo);

		return "emp-list";
	}
}
