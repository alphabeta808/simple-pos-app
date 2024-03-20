<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<title>POS Application</title>
</head>
<body>
	<%@include file="../../header.jsp"%>
	<main class="container-xxl">
		<h3 class="text-center">Point Of Sale Application</h3>
		<form:form>
			<table class="table table-striped text-center">
				<thead>
					<tr>
						<th scope="col">Item Code</th>
						<th scope="col">Item Name</th>
						<th scope="col">Price</th>
						<th scope="col">Taxable</th>
						<th scope="col">Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${itemList}" var="item">
						<tr>
							<td>${item.itemCode}</td>
							<td>${item.description}</td>
							<td>${item.price}</td>
							<td>${item.taxable}</td>
							<td><a href="<c:url value='/sales/add/${item.itemCode}' />"><button
										type="button" class="btn btn-success">Add Item</button></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form:form>
	</main>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous">	
	</script>
</body>
</html>
