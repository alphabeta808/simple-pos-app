<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>History Page</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body>
	<%@include file="../../header.jsp"%>
	
	<main class="container-xxl">
	<h3 class="text-center">Sale History</h3>
		<form:form>
			<table class="table table-striped text-center">
				<thead>
					<tr>
						<th scope="col">Sale Number</th>
						<th scope="col">Cashier Name</th>
						<th scope="col">Date</th>
						<th scope="col">Total Sale</th>
						<th scope="col">Payment</th>
						<th scope="col">Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${saleList}" var="sale">
						<tr>
							<td>${sale.sale_number}</td>
							<td>${sale.cashier_name}</td>
							<td>${sale.date}</td>
							<td>${sale.total_sale}</td>
							<td>${sale.payment}</td>
							<td><a href="<c:url value='/history/detail/${sale.sale_number}' />"><button
										type="button" class="btn btn-success">Sale Detail</button></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form:form>
	</main>
	
	<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js"
	integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8="
	crossorigin="anonymous"></script>
</body>
</html>