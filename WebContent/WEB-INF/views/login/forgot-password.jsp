<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="../Resources/images/favicon.svg" rel="icon">

    <title>TLD - Forgot Password</title>

    <!-- Custom styles for this template -->
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.2/dist/css/bootstrap.min.css">

</head>

<body class="bg-gradient-primary">

	<c:if test="${not empty Message}">
    <script>
        // Hiển thị biến trong cửa sổ cảnh báo
        alert("${Message}");
    </script>
</c:if>

<!-- Password Reset 8 - Bootstrap Brain Component -->
	<section class="bg-light p-3 p-md-4 p-xl-5">
	  <div class="container">
	    <div class="row justify-content-center">
	      <div class="col-12 col-xxl-11">
	        <div class="card border-light-subtle shadow-sm">
	          <div class="row g-0">
	            <div class="col-12 col-md-6">
	              <img class="img-fluid rounded-start w-100 h-100 object-fit-cover" loading="lazy" src="https://img.freepik.com/free-vector/forgot-password-concept-illustration_114360-1095.jpg?w=740&t=st=1713530372~exp=1713530972~hmac=dcc1348f703bbde964853d5976b5c0e5afcb76271628813b24d9396941714df4" alt="Welcome back you've been missed!">
	            </div>
	            <div class="col-12 col-md-6 d-flex align-items-center justify-content-center">
	              <div class="col-12 col-lg-11 col-xl-10">
	                <div class="card-body p-3 p-md-4 p-xl-5">
	                  <div class="row">
	                    <div class="col-12">
	                      <div class="mb-5">
	                        <h2 class="h4 text-center">Password Reset</h2>
	                        <h3 class="fs-6 fw-normal text-secondary text-center m-0">Provide the email address associated with your account to recover your password.</h3>
	                      </div>
	                    </div>
	                  </div>
	                  
	                  <!-- FORM -->
	                  <form action="<%= request.getContextPath() %>/login/forgot-password.htm" method = "POST">
	                    <div class="row gy-3 overflow-hidden">
	                      <div class="col-12">
	                        <div class="form-floating mb-3">
	                          <input type="email" class="form-control" name="email" id="email" placeholder="name@example.com" required>
	                          <label for="email" class="form-label">Email</label>
	                        </div>
	                      </div>
	                      <div class="col-12">
	                        <div class="d-grid">
	                          <button class="btn btn-dark btn-lg" type="submit">Reset Password</button>
	                        </div>
	                      </div>
	                    </div>
	                  </form>
	                  <!-- END FORM -->
	                  
	                  <div class="row">
	                    <div class="col-12">
	                      <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-center mt-5">
	                        <a href="loginForm.htm" class="link-secondary text-decoration-none">Login</a>
	                        <a href="signupForm.htm" class="link-secondary text-decoration-none">Register</a>
	                      </div>
	                    </div>
	                  </div>
	                </div>
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>