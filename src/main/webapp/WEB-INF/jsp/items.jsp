<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<title>Item Page</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

</head>
<body>
	<%@include file="../../header.jsp"%>
	<main class="container-xxl">
		<div class="d-flex justify-content-center mt-3">
			<h3>List of Item</h3>
		</div>
		<button class="btn btn-dark" data-bs-toggle="modal"
			data-bs-target="#addItemModal">Add New Item</button>
		<br> <br>
		<form>
			<table class="table table-striped text-center">
				<thead>
					<tr>
						<th scope="col">ITEM CODE</th>
						<th scope="col">ITEM NAME</th>
						<th scope="col">TYPE</th>
						<th scope="col">PRICE</th>
						<th scope="col">TAXABLE</th>
						<th scope="col">ACTION</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${itemList}" var="item">
						<tr>
							<td>${item.itemCode}</td>
							<td>${item.description}</td>
							<td>${item.type}</td>
							<td>${item.price}</td>
							<td>${item.taxable}</td>
							<td><button type="button"
									class="edit btn btn-secondary me-2" data-bs-toggle="modal"
									data-bs-target="#editItemModal"
									data-bs-itemCode='${item.itemCode}'
									data-bs-itemName='${item.description }'
									data-bs-itemType='${item.type}'
									data-bs-itemPrice='${item.price}'
									data-bs-itemTax='${item.taxable}'>Edit</button>

								<button type="button" class="delete btn btn-danger"
									data-bs-toggle="modal" data-bs-target="#deleteItemModal"
									data-bs-itemCode='${item.itemCode}'>Delete</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</main>

	<div class="modal fade" id="addItemModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<c:url var="addAction" value="/item/add"></c:url>

				<form:form action="${addAction}" modelAttribute="item">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Add New
							Item</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>Item Code</label> <input type="text" class="form-control"
								required="required" name="itemCode">
						</div>
						<div class="form-group">
							<label>Item Name</label> <input type="text" class="form-control"
								required="required" name="description">
						</div>
						<div class="form-group">
							<label>Type</label> <input type="text" class="form-control"
								required="required" name="type">
						</div>
						<div class="form-group">
							<label>Price</label> <input type="text" class="form-control"
								required="required" name="price">
						</div>
						<div class="form-group">
							<label>Taxable</label> <input type="text" class="form-control"
								required="required" name="taxable">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary">Add</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="editItemModal" tabindex="-1"
		aria-labelledby="editModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<c:url var="updateAction" value="/item/update"></c:url>

				<form:form action="${updateAction}">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="editModalLabel">Update Item</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>Item Code</label> <input type="text"
								class="itemCode form-control" required="required"
								name="itemCode">
						</div>
						<div class="form-group">
							<label>Item Name</label> <input type="text"
								class="itemName form-control" required="required"
								name="description">
						</div>
						<div class="form-group">
							<label>Type</label> <input type="text"
								class="itemType form-control" required="required" name="type">
						</div>
						<div class="form-group">
							<label>Price</label> <input type="text"
								class="itemPrice form-control" required="required" name="price">
						</div>
						<div class="form-group">
							<label>Taxable</label> <input type="text"
								class="itemTax form-control" required="required" name="taxable">
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">Update</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>


	<div class="modal fade" id="deleteItemModal" tabindex="-1"
		aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<c:url var="deleteAction" value="/item/delete "></c:url>

				<form:form action="${deleteAction}">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="deleteModalLabel">Delete
							Item ?</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p>
							Are you sure want to delete these item ? with item code: <span
								id="spanID"></span>
						</p>
						<input type="hidden" name="itemCode" class="itemCode">
						<p class="text-danger">
							<small>This action cannot be undone.</small>
						</p>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-primary">Delete</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var editItemModal = document.getElementById('editItemModal')
		editItemModal.addEventListener('show.bs.modal', function(event) {
			// Button that triggered the modal
			var button = event.relatedTarget
			// Extract info from data-bs-* attributes
			var item_code = button.getAttribute('data-bs-itemCode')
			var item_name = button.getAttribute('data-bs-itemName')
			var item_type = button.getAttribute('data-bs-itemType')
			var item_price = button.getAttribute('data-bs-itemPrice')
			var item_tax = button.getAttribute('data-bs-itemTax')

			var itemCodeInput = editItemModal
					.querySelector('.modal-body .itemCode')
			var itemNameInput = editItemModal
					.querySelector('.modal-body .itemName')
			var itemTypeInput = editItemModal
					.querySelector('.modal-body .itemType')
			var itemPriceInput = editItemModal
					.querySelector('.modal-body .itemPrice')
			var itemTaxInput = editItemModal
					.querySelector('.modal-body .itemTax')

			itemCodeInput.value = item_code
			itemNameInput.value = item_name
			itemTypeInput.value = item_type
			itemPriceInput.value = item_price
			itemTaxInput.value = item_tax
		});

		var deleteItemModal = document.getElementById('deleteItemModal')
		deleteItemModal.addEventListener('show.bs.modal', function(event) {

			var button = event.relatedTarget
			var item_code = button.getAttribute('data-bs-itemCode')

			var itemCodeInput = deleteItemModal
					.querySelector('.modal-body .itemCode')

			var spanToChance = deleteItemModal.querySelector("#spanID")

			itemCodeInput.value = item_code

			spanToChance.innerText = item_code
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