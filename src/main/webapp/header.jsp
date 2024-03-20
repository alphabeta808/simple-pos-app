<body>
	<nav class="navbar sticky-top bg-primary navbar-expand-lg bg-body-tertiary"
		data-bs-theme="dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"><h5>Point Of Sale</h5></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link focus-ring focus-ring-danger" href="dashboard">Home</a>
					</li>
					<li class="nav-item"><a class="nav-link focus-ring focus-ring-danger" href="sales">Sales
							Page</a></li>
					<li class="nav-item"><a class="nav-link focus-ring focus-ring-danger" href="items">Items
							Page</a></li>
					<li class="nav-item"><a class="nav-link focus-ring focus-ring-danger" href="history">Sales
							History Page</a></li>
					<form class="d-flex" role="search">
						<input class="form-control me-2" type="search"
							placeholder="Search" aria-label="Search">
						<button class="btn btn-outline-success" type="submit">Search</button>
					</form>
				</ul>
				<button class="btn btn-outline-danger" type="button"
					data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</button>
			</div>
		</div>
	</nav>

	<div class="modal fade" id="logoutModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<c:url var="logoutAction" value="/user/logout "></c:url>

				<form:form action="${logoutAction}">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="deleteModalLabel">Delete
							Item ?</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p>Are you sure want to logout ?</p>
						<p class="text-warning">
							<small>This action cannot be undone.</small>
						</p>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-primary">Logout</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</body>