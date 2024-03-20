<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Page</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body>
	<%@include file="../../header.jsp"%>

	<main class="container-xl" >
		<h3>Orders Item</h3>
		<form:form >
		<table id="saleIdSection">
			<tr>
				<td>
					Cashier
				</td>
				<td> : </td>
				<td><input type="hidden" id="cashier_name" name="cashier_name" value="${sessionScope.cashier }"/>${sessionScope.cashier }</td>
			</tr>
			<tr>
				<td>
					Sale Number
				</td>
				<td> : </td>
				<td><input type="text" name="sale_number" id="sale_number" class="form-control"/></td>
			</tr>
			<tr>
				<td>
					Date  
				</td>
				<td> : </td>
				<td>${date }<input type="hidden" id="date" name="date" value="${date }"/></td>
			</tr>				
		</table>
			<table class="table table-striped text-center" id="saleItemSection">
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
					<c:forEach items="${sale_session}" var="item">
						<tr>
							<td>${item.description}<input type="hidden" id="description" name="description" value="${item.description}"/></td>
							<td>${item.type}<input type="hidden" id="type" name="type" value="${item.type }"/></td>
							<td>${item.price}<input type="hidden" id="price" name="price" value="${item.price }"/></td>
							<td>${item.taxable }<input type="hidden" id="taxable" name="taxable" value="${item.taxable }"/></td>
							<td><a href="<c:url value='/sales/decrease/${item.itemCode}' />" >
							<input type="button" value="<"/></a><span class="mx-1">${item.quantity }<input type="hidden" id="quantity" name="quantity" value="${item.quantity }"/></span>
							<a href="<c:url value='/sales/increase/${item.itemCode}' />" >
							<input type="button" value=">"/></a></td>
							<td>${item.total_price}<input type="hidden" id="total_price" name="total_price" value="${item.total_price }"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<table class="table table-borderless" id="saleTaxSection">
				<tr>
					<td>Total Sale</td>
					<td>:</td>
					<td>${(sessionScope.totalSale>0)?sessionScope.totalSale:0}<input type="hidden" id="total_sale" name="total_sale" value="${(sessionScope.totalSale>0)?sessionScope.totalSale:0}"/></td>
				</tr>
				<tr>
					<td>Tax (10%)</td>
					<td>:</td>
					<td>${(sessionScope.tax>0)?sessionScope.tax:0}<input type="hidden" id="tax_amount" name="tax_amount" value="${(sessionScope.tax>0)?sessionScope.tax:0}"/></td>
				</tr>
				<tr>
					<td>Total Sale + tax</td>
					<td>:</td>
					<td>${(sessionScope.totalSaleWithTax>0)?sessionScope.totalSaleWithTax:0}<input type="hidden" id="total_sale_tax" name="total_sale_tax" value="${(sessionScope.totalSaleWithTax>0)?sessionScope.totalSaleWithTax:0}"/></td>
				</tr>
			</table>
		</form:form>
			<div id="paymentSection" class="d-flex mb-3">
				<div class="form-check me-3">
				  <input class="form-check-input" type="radio" name="paymentRadio" id="cashRadio" checked onclick="showField();">
				  <label class="form-check-label" for="cashRadio">
				    CASH
				  </label>
				</div>
				<div class="form-check me-3">
				  <input class="form-check-input" type="radio" name="paymentRadio" id="qrisRadio" onclick="hideField();">
				  <label class="form-check-label" for="qrisRadio">
				    QRIS
				  </label>
				</div>
				<div id="cash" class="me-3">
					<input type="text" id="cashPayment" name="cashPayment" onchange="calculateReturn();" class="form-control form-control-sm me-3">
				</div>
				<div id="qris" style="display: none">
					<input type="text" id="qrisPayment" class="form-control form-control-sm" name="qrisPayment" value="${(sessionScope.totalSaleWithTax>0)?sessionScope.totalSaleWithTax:0}" disabled readonly>
				</div>
				<div id="return" style="display : none">
					<div class="row g-3 align-items-center">
					  <div class="col-auto">
					    <label for="returnPayment" class="col-form-label">Return payment</label>
					  </div>
					  <div class="col-auto">
					    <input type="text" id="returnPayment" class="form-control form-control-sm" disabled readonly>
					  </div>
					</div>
				</div>
			</div>
			<div class="d-flex justify-content-end mb-2">
				<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#paySaleModal">FINISH</button>
			</div>		
	</main>
	
	<div class="modal fade" id="paySaleModal" tabindex="-1"
		aria-labelledby="saleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<c:url var="payAction" value="/sales/pay-sale"></c:url>
				<form:form action="${payAction}" modelAttribute="sale">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="saleModalLabel">Finish Sale ?</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p>Are you sure want to pay these sales ?</p>
						<p class="text-danger"><small>This action cannot be undone.</small></p>
						<input type="hidden" id="cashier_name" name="cashier_name"/>
						<input type="hidden" name="sale_number" id="sale_number"/>
						<input type="hidden" id="date" name="date"/>
						<input type="hidden" id="description" name="description"/>
						<input type="hidden" id="type" name="type"/>
						<input type="hidden" id="price" name="price"/>
						<input type="hidden" id="taxable" name="taxable"/>
						<input type="hidden" id="quantity" name="quantity"/>
						<input type="hidden" id="total_price" name="total_price"/>
						<input type="hidden" id="total_sale" name="total_sale"/>
						<input type="hidden" id="tax_amount" name="tax_amount"/>
						<input type="hidden" id="total_sale_tax" name="total_sale_tax"/>
						<input type="hidden" id="cashPayment" name="cashPayment">
						<input type="hidden" id="qrisPayment" name="qrisPayment">
						<input type="hidden" id="returnPayment" name="returnPayment">

						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-primary">Pay sale</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">
		function showField(){
			  document.getElementById('cash').style.display = 'block';
			  document.getElementById('return').style.display = 'block';
			  document.getElementById('qris').style.display = 'none';
			}
		
		function hideField(){
			  document.getElementById('cash').style.display = 'none';
			  document.getElementById('return').style.display = 'none';
			  document.getElementById('qris').style.display = 'block';
			}
		
		function calculateReturn(){
			var returnCalculation = document.getElementById('paymentSection')
			var totalSale = ${sessionScope.totalSaleWithTax}
			var cash = returnCalculation
					.querySelector('#cashPayment').value;
			
			var returnPayment = returnCalculation.querySelector("#returnPayment")
			returnPayment.value = cash - totalSale;		
		}
		
		var paySaleModal = document.getElementById('paySaleModal')
		paySaleModal.addEventListener('show.bs.modal', function(event) {
			var saleIdSection = document.getElementById("saleIdSection")
			var saleItemSection = document.getElementById("saleItemSection")
			var saleTaxSection = document.getElementById("saleTaxSection")
			var returnCalculation = document.getElementById('paymentSection')
			
			var cashierName = saleIdSection.querySelector("#cashier_name").value
			var saleNumber = saleIdSection.querySelector("#sale_number").value
			var date = saleIdSection.querySelector("#date").value
			var itemName = saleItemSection.querySelector("#description").value
			var type = saleItemSection.querySelector("#type").value
			var price = saleItemSection.querySelector("#price").value
			var taxable = saleItemSection.querySelector("#taxable").value
			var quantity = saleItemSection.querySelector("#quantity").value
			var totalPrice = saleItemSection.querySelector("#total_price").value
			var totalSale = saleTaxSection.querySelector("#total_sale").value
			var taxAmount = saleTaxSection.querySelector("#tax_amount").value
			var total = saleTaxSection.querySelector("#total_sale_tax").value
			var cash = returnCalculation.querySelector('#cashPayment').value
			var qris = returnCalculation.querySelector('#qrisPayment').value
			var returnPayment = returnCalculation.querySelector("#returnPayment").value
			
			var cashier_name = paySaleModal.querySelector('.modal-body #cashier_name')
			var sale_number = paySaleModal.querySelector('.modal-body #sale_number')
			var sale_date = paySaleModal.querySelector('.modal-body #date')
			var item_name = paySaleModal.querySelector('.modal-body #description')
			var item_type = paySaleModal.querySelector('.modal-body #type')
			var item_price = paySaleModal.querySelector('.modal-body #price')
			var item_tax = paySaleModal.querySelector('.modal-body #taxable')
			var item_quantity = paySaleModal.querySelector('.modal-body #quantity')			
			var item_totalPrice = paySaleModal.querySelector('.modal-body #total_price')
			var sale_total = paySaleModal.querySelector('.modal-body #total_sale')
			var sale_tax = paySaleModal.querySelector('.modal-body #tax_amount')
			var sale_tax_total = paySaleModal.querySelector('.modal-body #total_sale_tax')
			var cash_payment = paySaleModal.querySelector('.modal-body #cashPayment')
			var qris_payment = paySaleModal.querySelector('.modal-body #qrisPayment')
			var return_payment = paySaleModal.querySelector('.modal-body #returnPayment')
			
			
			cashier_name.value = cashierName
			sale_number.value = saleNumber
			sale_date.value = date
			item_name.value = itemName
			item_type.value = type

			item_price.value = parseInt(price)
			item_tax.value = taxable
			item_quantity.value = parseInt(quantity)
			item_totalPrice.value = parseInt(totalPrice)
			sale_total.value = totalSale
			sale_tax.value = taxAmount
			sale_tax_total.value = parseInt(total)
			if(cash > 0){
				cash_payment.value = parseInt(cash)
				qris_payment.value = 0
				return_payment.value = parseInt(returnPayment)				
			} else {
				cash_payment.value = 0
				qris_payment.value = parseInt(qris)
				return_payment.value = 0
			}
		});
		
    </script>
	
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js"
		integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8="
		crossorigin="anonymous"></script>
</body>
</html>