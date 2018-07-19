package com.jah.ssm.test;

import com.jah.ssm.bean.Department;
import com.jah.ssm.bean.Employee;
import com.jah.ssm.dao.DepartmentMapper;
import com.jah.ssm.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.testng.annotations.Test;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class EmployeeTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Test
	public void insertTest() {

		Department department = new Department();
		department.setDeptId(3);
		department.setDeptName("测试部");

		departmentMapper.insert(department);
	}

	@Test
	public void insertSelectiveTest2() {
		Employee employee = new Employee();
		employee.setEmpName("hzf");
		employee.setGender("F");
		employee.setEmail("222@qq.com");
		employee.setdId(2);

		employeeMapper.insert(employee);
	}
	
	@Test
	public void testSelectByPrimaryKeyWithDepart(){
		Employee employee=employeeMapper.selectByPrimaryKeyWithDept(1);
		System.out.println("employee: "+employee);
	}
	
	@Autowired
	SqlSession sqlSession;
	/**
	 * 批量插入多个员工
	 */
	@Test
	public void testBatch(){
		EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);//获取可以批量查询的mapper
		String name=null;
		for(int i=0;i<100;i++){
			name=UUID.randomUUID().toString().substring(0, 3);
			System.out.println(name);
			
			mapper.insert(new Employee(null, name+i, "M", name+"@qq.com", 1));
		}
		System.out.println("批量完成！");
	}
}
