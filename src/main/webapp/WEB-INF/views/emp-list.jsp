<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	pageContext.setAttribute("contextPath", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="${contextPath }/static/js/jquery-1.7.2.js"></script>
<link rel="stylesheet"
	href="${contextPath }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<script
	src="${contextPath }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>员工列表</title>
</head>
<body>
	<div class="container">
		<c:if test="${pageInfo.list!=null }">
			<div class="row">
				<div class="col-md-4 col-md-offset-6">
					<button class="btn btn-primary">编辑</button>
					<button class="btn btn-danger">删除</button>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<table class="table table-hover table-bordered">
						<tr>
							<th><input type="checkbox"></th>
							<th>序号</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
						<c:forEach items="${pageInfo.list }" var="emp">
							<tr>
								<td><input type="checkbox" name="empId"
									value="${emp.empId}"></td>
								<td>${emp.empId}</td>
								<td>${emp.empName}</td>
								<td>${emp.gender}</td>
								<td>${emp.email}</td>
								<td>${emp.department.deptName}</td>
								<td>
									<button class="btn btn-primary btn-xs">
										<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
									</button>
									<button class="btn btn-danger btn-xs">
										<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
									</button>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>

			<div class="row">
				<div class="col-md-4">当前第${pageInfo.pageNum }页，共有${pageInfo.pages }页，总计${pageInfo.total }条记录</div>
				<div class="col-md-5">
					<nav aria-label="Page navigation">
					<ul class="pagination">
						<li><a href="${contextPath }/employee/list1">首页</a></li>
						<c:if test="${pageInfo.pageNum-1>0 }">
							<li><a
								href="${contextPath }/employee/list1?pageNum=${pageInfo.pageNum-1 }"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						<c:forEach items="${pageInfo.navigatepageNums }" var="na">
							<c:if test="${na==pageInfo.pageNum }">
								<li class="active"><a>${na }</a></li>
							</c:if>
							<c:if test="${na!=pageInfo.pageNum }">
								<li><a href="${contextPath }/employee/list1?pageNum=${na }">${na }</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${pageInfo.pageNum<pageInfo.pages }">
							<li><a
								href="${contextPath }/employee/list1?pageNum=${pageInfo.pageNum+1 }"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
						<li><a href="${contextPath }/employee/list1?pageNum=${pageInfo.pages }">尾页</a></li>
					</ul>
					</nav>
				</div>
			</div>
		</c:if>
	</div>
</body>
</html>