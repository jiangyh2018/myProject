<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%  pageContext.setAttribute("contextPath", request.getContextPath()); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="static/js/jquery-1.12.4.min.js"></script>
<link rel="stylesheet"
	href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<!--员工添加模态框  -->
<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
      	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
		<form class="form-horizontal" id="addForm">
			<div class="form-group">
				<label for="inputName3" class="col-sm-2 control-label">姓名</label>
				<div class="col-sm-10">
					<input type="text" name="name" class="form-control" id="inputName3"
						placeholder="姓名">
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">邮箱</label>
				<div class="col-sm-10">
					<input type="email" name="email" class="form-control" id="inputEmail3"
						placeholder="邮箱">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">
					性别
				</label>
				<div class="col-sm-10">
					<label class="radio-inline"> <input type="radio"
						name="gender" id="inlineRadio1" value="M">
						男
					</label> 
					<label class="radio-inline"> <input
						type="radio" name="gender" id="inlineRadio2"
						value="F">女
					</label>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">部门</label>
				<div class="col-sm-4">
					<select class="form-control" name="dId" id="dId">
						<option value="">请选择</option>
					</select>
				</div>
			</div>
		</form>
		</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" onclick="addEmployee()">保存</button>
      </div>
    </div>
  </div>
</div>

	<a href="employee/list1">查询所有员工信息</a>
	<br>
<!-- 	<button class="btn btn-default">按钮</button>
	<br>
	<button class="btn btn-success">（成功）Success</button>
	<br>
 -->	
	<div class="container">
		<div class="row">
				<div class="col-md-4 col-md-offset-6">
					<button class="btn btn-primary" id="empAdd">新增</button>
					<button class="btn btn-danger">删除</button>
				</div>
		</div>

		<div class="row">
			<div class="col-md-8">
				<table class='table table-hover table-bordered' id="empsTlb">
					<thead>
						<tr>
							<th><input type='checkbox'></th>
							<th>序号</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
		
		<div class="row">
				<div class="col-md-4" id="pageInfo"></div>
				<div class="col-md-5" id="pageNav"></div>
			</div>
			
	</div>
	
<script type="text/javascript">
var totalRecord;
	$(function() {
		to_page(1);
		
	});
	function to_page(pn){
		$.ajax({
			type:"post",
			url:"${contextPath}/employee/list",
			data:"pageNum="+pn+"&date="+new Date(),
			success:function(result) {
				//1.解析数据并显示员工的数据列表
				build_emps_table(result);
				
				//2.解析并显示分页信息
				build_page_info(result);
				
				//3.解析并显示分页条
				build_page_nav(result);
			}
		});
	}
			
	function build_emps_table(result){
		$("#empsTlb tbody").empty();
		var emps=result.map.pageInfo.list;
		$.each(emps,function(index,emp){
// 					alert("emp: "+emp);
			var idTbl=$("<td></td>").append("<input type='checkbox' name='empId' value="+emp.empId+"/>");
			var empIdTbl=$("<td></td>").append(emp.empId);
			var empIdTbl=$("<td></td>").append(emp.empId);
			var empNameTbl=$("<td></td>").append(emp.empName);
			var gender=emp.gender=='M'?"男":"女";
			var empGenderTbl=$("<td></td>").append(gender);
			var empEmailTbl=$("<td></td>").append(emp.email);
			var deptNameTbl=$("<td></td>").append(emp.department.deptName);
			var editBtnTbl=$("<button></button>").addClass("btn btn-primary btn-xs")
									.append("<span aria-hidden='true'></span>编辑").addClass("glyphicon glyphicon-pencil");
			var deleteBtnTbl=$("<button></button>").addClass("btn btn-danger btn-xs")
							.append("<span aria-hidden='true'></span>删除").addClass("glyphicon glyphicon-trash");
			var btnTbl=$("<td></td>").append(editBtnTbl).append(" ").append(deleteBtnTbl);
			$("<tr></tr>").append(idTbl)
							.append(empIdTbl)
							.append(empNameTbl)
							.append(empGenderTbl)
							.append(empEmailTbl)
							.append(deptNameTbl)
							.append(btnTbl)
							.appendTo("#empsTlb tbody");
		});
	}
			
	function build_page_info(result){
		$("#pageInfo").empty();
		var pageInfo=result.map.pageInfo;
		$("#pageInfo").append("当前第"+pageInfo.pageNum+"页，共有"+pageInfo.pages+"页，总计"+pageInfo.total+"条记录");
		totalRecord=pageInfo.total;
	}
			
	function build_page_nav(result){
		$("#pageNav").empty();
		var pageInfo=result.map.pageInfo;
		
		var ulLi=$("<ul></ul>").addClass("pagination");
		
		var firstPageLi=$("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
		var prePageLi=$("<li></li>").append($("<a></a>").attr("href","#").append("<span aria-hidden='true'>&laquo;</span>"));
		//当是首页时，禁止点击
		if(pageInfo.isFirstPage==true){
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		}else{
			//添加点击事件
			firstPageLi.click(function(){
				to_page(1);
			});
			prePageLi.click(function(){
				to_page(pageInfo.pageNum-1);
			});
		}
		
		var nextPageLi=$("<li></li>").append($("<a aria-label='Next'></a>").attr("href","#").append("&raquo;"));
		var lastPageLi=$("<li></li>").append($("<a></a>").attr("href","#").append("末页"));
		//当是末页时，禁止点击
		if(pageInfo.isLastPage==true){
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		}else{
			//添加点击事件
			nextPageLi.click(function(){
				to_page(pageInfo.pageNum+1);
			});
			lastPageLi.click(function(){
				to_page(pageInfo.pages);
			});
		}
		
		ulLi.append(firstPageLi).append(prePageLi);
		$.each(pageInfo.navigatepageNums,function(index,item){
			var navLi=$("<li></li>").append($("<a></a>").attr("href","#").append(item));
			ulLi.append(navLi);
			//显示的当页高亮
			if(pageInfo.pageNum==item){
				navLi.addClass("active");
			}else{
				//添加点击事件
				navLi.click(function(){
					to_page(item);
				});
			}
		});
		
		ulLi.append(nextPageLi).append(lastPageLi);
		ulLi.appendTo("#pageNav");
	}
	//新增模态框的显示
	$("#empAdd").click(function(){
		//为name输入框添加mouseleave事件
		$("#inputName3").blur(function(){
			checkName();
		});
		//初始化部门选择框
		getDepts();
		$("#myModal").modal({
			keyboard:true,
			backdrop:false
		});
	});
	//新增的提交
	function addEmployee(){
		//校验表单
		if(!validateAddForm()){
			return;
		}
		if(!confirm('确定提交吗?')){
			return;
		}
		/* var name=$("#inputName3").val();
		var email=$("#inputEmail3").val();
		var gender=$("input[name='gender']:checked").val();
		var dId=$("#dId option:selected").val(); */
		/* alert(name+"-"+email+"-"+gender+"-"+dId); */
		var data=$("#addForm").serialize();
		$.ajax({
			type:'POST',
			url:'${contextPath}/employee/add',
			data:data,		//'name='+name+'&email='+email+'&gender='+gender+'&dId='+dId,
			success:function(data){
				//隐藏模态框
				$("#myModal").modal('hide');
				/* $("#addForm").reset(); */
				//2.跳转到最后一页
				to_page(totalRecord);
			}
		});
	}
	//校验表单数据
	function validateAddForm(){
		
	}
	//初始化部门选择框
	function getDepts(){
		$.ajax({
			type:'GET',
			url:'${contextPath}/dept/getAllDepts',
			success:function(data){
				//console.log(data);
				var depts=data.map.depts;
				$.each(depts,function(index,dept){
					$("#dId").append("<option value="+dept.deptId+">"+dept.deptName+"</option>");
				});
			}
		});
	}
	//校验姓名是否重复
	function checkName(){
		var name=$("#inputName3").val();
		//console.log(name);
		if(name==null || name==""){
			if($("#inputName3").next("span")!=null){
				$("#inputName3").next("span").empty();
			}
			$("#inputName3").after("<span style='color:red'>姓名不能为空！</span>");
			return;
		}
		$("#inputName3").next("span").empty();
		$.ajax({
			tpye:'GET',
			url:'${contextPath}/employee/checkName',
			data:'name='+name,
			success:function(res){
				if(res.map.num!=0){
					$("#inputName3").next("span").empty();
					$("#inputName3").after("<span style='color:red'>姓名已存在，请重新输入</span>");
				}
			}
		});
	}
</script>
</body>
</html>