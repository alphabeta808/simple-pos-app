<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sale History Detail Page</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body>
	<%@include file="../../header.jsp"%>

	<main class="container-sm">
		<h3 class="text-center">Sale History Detail</h3>
		<form:form>
			<table id="saleIdSection">
			<c:forEach items="${saleDetail}" var="saleDetail">
				<tr>
					<td>Cashier</td>
					<td>:</td>
					<td>${saleDetail.cashier_name }</td>
				</tr>
				<tr>
					<td>Sale Number</td>
					<td>:</td>
					<td>${saleDetail.sale_number }</td>
				</tr>
				<tr>
					<td>Date</td>
					<td>:</td>
					<td>${saleDetail.date }</td>
				</tr>
				</c:forEach>
			</table>
			<table class="table table-striped text-center">
				<thead>
					<tr>
						<th scope="col">Item Name</th>
						<th scope="col">Type</th>
						<th scope="col">Price</th>
						<th scope="col">Taxable</th>
						<th scope="col">Quantity</th>
						<th scope="col">Total Price</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${saleItemDetail}" var="saleItemDetail">
						<tr>
							<td>${saleItemDetail.description}</td>
							<td>${saleItemDetail.type}</td>
							<td>${saleItemDetail.price}</td>
							<td>${saleItemDetail.taxable}</td>
							<td>${saleItemDetail.quantity}</td>
							<td>${saleItemDetail.total_price}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<table class="table table-borderless" id="saleTaxSection">
			<c:forEach items="${saleDetail}" var="saleDetail">
				<tr>
					<td>Total Sale</td>
					<td>:</td>
					<td>${saleDetail.total_sale}</td>
				</tr>
				<tr>
					<td>Tax (10%)</td>
					<td>:</td>
					<td>${saleDetail.tax_amount}</td>
				</tr>
				<tr>
					<td>Total Sale + tax</td>
					<td>:</td>
					<td>${saleDetail.total_sale_tax}</td>
				</tr>
				</c:forEach>
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