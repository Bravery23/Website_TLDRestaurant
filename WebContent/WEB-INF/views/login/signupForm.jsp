<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>TLD Sign Up</title>
<link href="../Resources/images/favicon.svg" rel="icon">

<!-- Font Icon -->
<link rel="stylesheet"
	href="../Resources/vendor/fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link href="../Resources/css/login/signup.css" rel="stylesheet">

<!-- fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">

    <script>
        function validateForm() {
            // Get form elements
            const name = document.getElementById('name').value;
            const phone = document.getElementById('phone').value;
            const email = document.getElementById('re_email').value;
            const username = document.getElementById('username').value;
            const password = document.getElementById('pass').value;
            const agreeTerm = document.getElementById('agree-term').checked;

            // Regular expressions for validation
            const phonePattern = /^[0-9]{10}$/;
            const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            const usernamePattern = /^[a-zA-Z0-9_]{3,20}$/;

            // Validation checks
            if (!name) {
                alert('Please enter your name.');
                return false;
            }
            if (!phone || !phonePattern.test(phone)) {
                alert('Please enter a valid phone number (10 digits).');
                return false;
            }
            if (!email || !emailPattern.test(email)) {
                alert('Please enter a valid email address.');
                return false;
            }
            if (!username || !usernamePattern.test(username)) {
                alert('Please enter a valid username.');
                return false;
            }
            if (!password) {
                alert('Please enter a password.');
                return false;
            }
            if (!agreeTerm) {
                alert('You must agree to the terms of service.');
                return false;
            }

            // If all validations pass
            return true;
        }
    </script>
    
</head>
<body>
	<c:if test="${not empty Message}">
    <script>
        // Hiển thị biến trong cửa sổ cảnh báo
        alert("${Message}");
    </script>
	</c:if>
	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form">
						<h2 class="form-title">Sign up</h2>
						
						<!-- FORM -->
						<form action = "<%= request.getContextPath() %>/login/signUp.htm" method="POST" class="register-form" id="register-form" onsubmit="return validateForm()">
							<div class="form-group">
								<label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label> 
								<input type="text" name="name" id="name" placeholder="Your Name" required />
							</div>
							<div class="form-group">
								<label for="phone"><i class="zmdi zmdi-phone"></i></label> 
								<input type="tel" name="phone" id="phone" placeholder="Your Phone Number" required />
							</div>
							<div class="form-group">
								<label for="re_email"><i class="zmdi zmdi-email"></i></label> 
								<input type="email" name="re_email" id="re_email" placeholder="Your email" required />
							</div>
							<div class="form-group">
								<label for="username"><i class="zmdi zmdi-account"></i></label>
								<input type="text" name="username" id="username" placeholder="Your Username" required />
							</div>

							<div class="form-group">
								<label for="pass"><i class="zmdi zmdi-lock"></i></label> 
								<input type="password" name="pass" id="pass" placeholder="Password" required />
							</div>
							<div class="form-group">
								<input type="checkbox" name="agree-term" id="agree-term" class="agree-term" /> 
								<label for="agree-term" class="label-agree-term"><span><span></span></span>I agree all statements in 
									<a href="#" class="term-service">Terms of service</a></label>
							</div>
							<div class="form-group form-button">
								<input type="submit" onclick="validateForm()" name="signup" id="signup"
									class="form-submit" value="Register" />
							</div>
						</form>
						<!-- END FORM -->
						
					</div>
					<div class="signup-image">
						<figure>
							<img
								src="https://logowik.com/content/uploads/images/restaurant9491.logowik.com.webp"
								alt="sing up image">
						</figure>
						<a href="<%= request.getContextPath() %>/login/loginForm.htm" class="signup-image-link">I am already
							member</a>
					</div>
				</div>
			</div>
		</section>

	</div>

	<!-- 
    <script src="../vendor/js/jquery.min.js"></script>
    <script src="../vendor/js/main.js"></script>JS -->
    

</body>
</html>