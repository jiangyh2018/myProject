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
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Modal title</h4>
					</div>
					<div class="modal-body">qqqqq</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary">保存</button>
					</div>
				</div>
			</div>
		</div>

	<a href="employee/list1">查询所有员工信息</a>
	<br>
	<button class="btn btn-default">按钮</button>
	<br>
	<button class="btn btn-success">（成功）Success</button>
	<br>
	
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
		$("#pageInfo").append("当前第"+pageInfo.pageNum+"页，共有"+pageInfo.size+"页，总计"+pageInfo.total+"条记录");
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
	$("#empAdd").click(function(){
		$("#myModal").modal({
			keyboard:true,
			backdrop:false
		});
	});
</script>
</body>
</html>