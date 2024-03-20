<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html lang="en">
<body>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>POS Application</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>

<main>
	<nav class="navbar bg-primary navbar-expand-lg bg-body-tertiary "
		data-bs-theme="dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"><h5>Point Of Sale</h5></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="d-flex justify-content-end mx-5">
				<div class="collapse navbar-collapse " id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item mx-2">
							<button type="button" class="btn btn-dark" data-bs-toggle="modal"
								data-bs-target="#loginModal">Login</button>
						</li>
						<li class="nav-item">
							<button type="button" class="btn btn-dark" data-bs-toggle="modal"
								data-bs-target="#registerModal">Register</button>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
	<div class="d-flex justify-content-center align-items-center"
		style="height: 80vh">
		<h1>Point of Sale Application</h1>
	</div>

	<div class="modal fade" id="loginModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">

		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Login Form</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<h4>Insert User name & Password</h4>
					<c:url var="loginAction" value="/user/validation"></c:url>

					<form action="${loginAction}">
						<div class="me-2">
							<label for="username" class="col-form-label">Username</label> <input
								type="text" class="form-control" id="name" name="name">
						</div>
						<div>
							<label for="password" class="col-form-label">Password</label> <input
								type="password" class="form-control" id="password"
								name="password">
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Login</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="registerModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Register
						Form</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<c:url var="registerAction" value="/user/registration"></c:url>

					<form action="${registerAction}">
						<div class="mb-3">
							<label for="username" class="col-form-label">Username</label> <input
								type="text" class="form-control" id="username" name="name">
						</div>
						<div class="mb-3">
							<label for="password" class="col-form-label">Password</label> <input
								type="text" class="form-control" id="password" name="password">
						</div>

						<div class="d-flex mb-3">
							<div class="me-2 col-4">
								<label for="role" class="col-form-label">Role</label> <input
									type="text" class="form-control" id="role" name="role">
							</div>
							<div class="col-4 me-2">
								<label for="place" class="col-form-label">Place of birth</label>
								<input type="text" class="form-control" id="place"
									name="birthPlace">
							</div>
							<div class="col-2">
								<label for="age" class="col-form-label">age</label> <input
									type="text" class="form-control" id="age" name="age">
							</div>
						</div>
						<div class="mb-3">
							<label for="address" class="form-label">Address</label>
							<textarea class="form-control" id="address" rows="3"
								name="address"></textarea>
							<small><em>max 250 character</em></small>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Register</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</main>

<footer class="d-flex justify-content-center mb-0">
	<p>Simple point of sale application by Alfan maulana @2024</p>
</footer>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js"
	integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8="
	crossorigin="anonymous"></script>
</body>
</html>
