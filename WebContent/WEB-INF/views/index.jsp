<!-- TEST ELIPPSE GIT -->

<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>TLD Restaurant</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="<%= request.getContextPath() %>/Resources/images/favicon.svg" rel="icon">
<link href="<%= request.getContextPath() %>/Resources/images/apple-touch-icon.png"
	rel="apple-touch-icon">

<!-- Google Fonts -->	
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Amatic+SC:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="<%= request.getContextPath() %>/Resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<%= request.getContextPath() %>/Resources/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="<%= request.getContextPath() %>/Resources/vendor/aos/aos.css" rel="stylesheet">
<link href="<%= request.getContextPath() %>/Resources/vendor/glightbox/css/glightbox.min.css"
	rel="stylesheet">
<link href="<%= request.getContextPath() %>/Resources/vendor/swiper/swiper-bundle.min.css"
	rel="stylesheet">

<!-- Template Main CSS File -->
<link href="<%= request.getContextPath() %>/Resources/css/main.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


<!-- ======================================================== -->
<style type="text/css">

.wrap {
	width: 250px;
	height: 50px;
	background: #fff;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%,-50%);
	border-radius: 10px;
}
.stars {
	width: fit-content;
	margin: 0 auto;
	cursor: pointer;
}
.star {
	color: #FFFF33 !important;
}
.rate {
	height: 50px;
	margin-left: -5px;
	padding: 5px;
	font-size: 25px;
	position: relative;
	cursor: pointer;
}
.rate input[type="radio"] {
	opacity: 0;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%,0%);
	pointer-events: none;
}
.star-over::after {
	font-family: 'Font Awesome 5 Free';
  font-weight: 900;
	font-size: 16px;
	content: "\f005";
	display: inline-block;
	color: #FFFF33;
	z-index: 1;
	position: absolute;
	top: 17px;
	left: 10px;
}

.rate:nth-child(1) .face::after {
	content: "\f119"; /* ☹ */
}
.rate:nth-child(2) .face::after {
	content: "\f11a"; /* 😐 */
}
.rate:nth-child(3) .face::after {
	content: "\f118"; /* 🙂 */
}
.rate:nth-child(4) .face::after {
	content: "\f580"; /* 😊 */
}
.rate:nth-child(5) .face::after {
	content: "\f59a"; /* 😄 */
}
.face {
	opacity: 0;
	position: absolute;
	width: 35px;
	height: 35px;
	background: #91a6ff;
	border-radius: 5px;
	top: -50px;
	left: 2px;
	transition: 0.2s;
	pointer-events: none;
}
.face::before {
	font-family: 'Font Awesome 5 Free';
  font-weight: 900;
	content: "\f0dd";
	display: inline-block;
	color: #91a6ff;
	z-index: 1;
	position: absolute;
	left: 9px;
	bottom: -15px;
}
.face::after {
	font-family: 'Font Awesome 5 Free';
  font-weight: 900;
	display: inline-block;
	color: #fff;
	z-index: 1;
	position: absolute;
	left: 5px;
	top: -1px;
}

.rate:hover .face {
	opacity: 1;
}

/* Not sure if I like this or not. */
/* Makes the emoji stay displayed */
/* input[type="radio"]:checked + .face {
	opacity: 1 !important;
} */
</style>
</head>

<body>
	<c:if test="${not empty Message}">
    <script>
        // Hiển thị biến trong cửa sổ cảnh báo
        alert("${Message}");
        sessionStorage.clear();
    </script>
</c:if>
	<!-- ======= Header ======= -->
	<header id="header" class="header fixed-top d-flex align-items-center">
		<div
			class="container d-flex align-items-center justify-content-between">

			<a href="<%= request.getContextPath() %>/index/index.htm"
				class="logo d-flex align-items-center me-auto me-lg-0"> <!-- Uncomment the line below if you also wish to use an image logo -->
				<!-- <img src="<%= request.getContextPath() %>/Resources/images/logo.png" alt=""> -->
				<h1>
					${company.name}<span>.</span>
				</h1>
			</a>

			<nav id="navbar" class="navbar">
				<ul>
					<li><a href="#hero">Home</a></li>
					<li><a href="#menu">Menu</a></li>
					<li><a href="#about">About</a></li>
					<li><a href="#contact">Contact</a></li>
				</ul>
			</nav>
			<!-- .navbar -->

			<!-- Gio hang -->
            <div class="shopping">
                <a id ="cartLink" href = "#menu"><img src="<%= request.getContextPath() %>/Resources/images/shopping.svg"></a>
                <span class="quantity"></span>
            </div>
			
			<!-- Button Login -->
			<div id="loginButton" class="login-button">
				<a href="<%= request.getContextPath() %>/login/loginForm.htm" class="btn-login">Login</a>
			</div>

			<!-- User Logo Dropdown -->

			<div id="userLogo" class="dropdown">
				<a data-mdb-dropdown-init class="dropdown-toggle" type="button"
					id="dropdownMenuicon" data-mdb-toggle="dropdown"
					aria-expanded="false"> <img
					src="https://bootdey.com/img/Content/avatar/avatar6.png"
					alt="User Logo" class="user-logo">
				</a>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenuicon">
					<li><a class="dropdown-item" href="<%= request.getContextPath() %>/user/userinfo.htm"> <i
							class="fas fa-user-alt pe-2"></i>My Profile
					</a></li>
					<li><a class="dropdown-item" href="log_out.htm"> <i
							class="fas fa-door-open pe-2"></i>Logout
					</a></li>
				</ul>
			</div>


			<i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i> <i
				class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>

		</div>
	</header>
	<!-- End Header -->

	<!-- ======= Hero Section ======= -->
	<section id="hero" class="hero d-flex align-items-center section-bg">
		<div class="container">
			<div class="row justify-content-between gy-5">
				<div
					class="col-lg-5 order-2 order-lg-1 d-flex flex-column justify-content-center align-items-center align-items-lg-start text-center text-lg-start">
					<h2 data-aos="fade-up">
						Enjoy Vietnamese Healthy<br>Delicious Food
					</h2>
					<p data-aos="fade-up" data-aos-delay="100">Indulge in Authentic
						Vietnamese Flavors, Where Tradition Meets Taste!</p>
					<div class="d-flex" data-aos="fade-up" data-aos-delay="200">
						<a href="#menu" class="btn-book-a-table">Book Now</a>
					</div>
				</div>
				<div class="col-lg-5 order-1 order-lg-2 text-center text-lg-start">
					<img src="<%= request.getContextPath() %>/Resources/images/hero-img1.png" class="img-fluid" alt=""
						data-aos="zoom-out" data-aos-delay="300">
				</div>
			</div>
		</div>
	</section>
	<!-- End Hero Section -->

	<main id="main">

		<!-- ======= Menu Section ======= -->
		<section id="menu" class="menu">
			<div class="container1" data-aos="fade-up">

				<div class="section-header">
					<h2>Our Menu</h2>
					<p>
						Check Our <span>Yummy Menu</span>
					</p>
				</div>

				<!-- SHOW CATEGORIES -->
				<ul class="nav nav-tabs d-flex justify-content-center"
					data-aos="fade-up" data-aos-delay="200">
					<c:forEach var="category" items="${categories}">
						<li class="nav-item"><a class="nav-link" data-bs-toggle="tab"
							data-bs-target="#menu-${category.name}">
								<h4>${category.name}</h4>
						</a></li>
						<!-- End tab nav item -->
					</c:forEach>
				</ul>

				<!-- SHOW FOOD OF EVERY CATEGORY -->
				<div class="tab-content" data-aos="fade-up" data-aos-delay="300">
					<c:set var="first" value="true" />
					<c:forEach var="category" items="${categories}">
						<div class="tab-pane fade ${first ? 'active show' : ''}"
							id="menu-${category.name}">
							<div class="tab-header text-center">
								<p>Menu</p>
								<h3>${category.name}</h3>
							</div>
							<div class="row gy-5">
								<c:forEach var="food" items="${foods}">
									<c:if test="${food.category.id == category.id}">
										<div class="col-lg-4 menu-item">
											<a href="<%= request.getContextPath() %>/Resources/images/${food.url}"
												class="glightbox"><img
												src="<%= request.getContextPath() %>/Resources/images/${food.url}"
												class="menu-img img-fluid" alt=""></a>
											<h4>${food.name}</h4>
											<p class="price"><fmt:formatNumber value="${food.price}" type="number" maxFractionDigits="0" />đ</p>
											<button class="add-to-cart-btn" id="${food.id}">Add to Cart</button>
										</div>
										<!-- Menu Item -->
									</c:if>
								</c:forEach>
							</div>
						</div>
						<!-- End Menu Content -->
						<c:set var="first" value="false" />
					</c:forEach>
				</div>

			</div>
		</section>
		<!-- End Menu Section -->

		<!-- ======= About Section ======= -->
		<section id="about" class="about">
			<div class="container" data-aos="fade-up">

				<div class="section-header">
					<h2>About Us</h2>
					<p>
						Learn More <span>About Us</span>
					</p>
				</div>

				<div class="row gy-4">
					<div class="col-lg-12 text-center" data-aos="fade-up"
						data-aos-delay="300">
						<div class="content ps-0">
							<p
								style="text-align: center; font-family: 'Montserrat', sans-serif;">${company.about}</p>
						</div>
					</div>
				</div>

			</div>
		</section>
		<!-- End About Section -->

		<!-- ======= Why Us Section ======= -->

		<!-- ======= Stats Counter Section ======= -->

		<!-- ======= Testimonials Section ======= -->
		<section id="testimonials" class="testimonials section-bg">
			<div class="container" data-aos="fade-up">
				<div class="section-header">
					<h2>Testimonials</h2>
					<p>
						What Are They <span>Saying About Us</span>
					</p>
				</div>
				
				<div class="slides-1 swiper" data-aos="fade-up" data-aos-delay="100">
					<div class="swiper-wrapper">
						<!-- Đưa dữ liệu comment vào slide -->
						<c:forEach var="comment" items="${comments}">
							<div class="swiper-slide">
								<div class="testimonial-item">
									<div class="row gy-4 justify-content-center">
										<div class="col-lg-6">
											<div class="testimonial-content">
												<p>
													<i class="bi bi-quote quote-icon-left"></i>
													${comment.content} <i class="bi bi-quote quote-icon-right"></i>
												</p>
												<h3>${comment.customer.name}</h3>
												<h4>Customer</h4>
												<div class="stars">
													<c:forEach begin="1" end="${comment.rating}">
														<i class="bi bi-star-fill"></i>
													</c:forEach>
												</div>
											</div>
										</div>
										<div class="col-lg-2 text-center">
											<img src="<%= request.getContextPath() %>/Resources/images/lananh.jpg"
												class="img-fluid testimonial-img" alt="">
										</div>
									</div>
								</div>
							</div>
						</c:forEach>

					</div>
					<div class="swiper-pagination"></div>
				</div>
			</div>
		</section>

		<!-- End Testimonials Section -->

		<!-- ======= Contact Section ======= -->
		<section id="contact" class="contact">
			<div class="container" data-aos="fade-up">

				<div class="section-header">
					<h2>Contact</h2>
					<p>
						Need Help? <span>Contact Us</span>
					</p>
				</div>

				<div class="mb-3">
					<iframe
						src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.285394621375!2d106.69815377488263!3d10.789439889360123!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317528b545b5903b%3A0x2381a6fe3f690419!2zSOG7jWMgdmnhu4duIEPDtG5nIG5naOG7hyBCxrB1IGNow61uaCBWaeG7hW4gdGjDtG5nIEPGoSBz4bufIHThuqFpIFRQLiBI4buTIENow60gTWluaA!5e0!3m2!1svi!2s!4v1718348220047!5m2!1svi!2s"
						style="border: 0; width: 100%; height: 350px;" allowfullscreen=""
						loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
				</div>
				<!-- End Google Maps -->

				<div class="row gy-4">

					<div class="col-md-6">
						<div class="info-item  d-flex align-items-center">
							<i class="icon bi bi-map flex-shrink-0"></i>
							<div>
								<h3>Our Address</h3>
								<p>${company.address}</p>
							</div>
						</div>
					</div>
					<!-- End Info Item -->

					<div class="col-md-6">
						<div class="info-item d-flex align-items-center">
							<i class="icon bi bi-envelope flex-shrink-0"></i>
							<div>
								<h3>Email Us</h3>
								<p>${company.mail}</p>
							</div>
						</div>
					</div>
					<!-- End Info Item -->

					<div class="col-md-6">
						<div class="info-item  d-flex align-items-center">
							<i class="icon bi bi-telephone flex-shrink-0"></i>
							<div>
								<h3>Call Us</h3>
								<p>${company.phone}</p>
							</div>
						</div>
					</div>
					<!-- End Info Item -->

					<div class="col-md-6">
						<div class="info-item  d-flex align-items-center">
							<i class="icon bi bi-share flex-shrink-0"></i>
							<div>
								<h3>Opening Hours</h3>
								<div>
									<strong>Mon-Sat:</strong> ${company.openingHour}; <strong>Sunday:</strong>
									Closed
								</div>
							</div>
						</div>
					</div>
					<!-- End Info Item -->

		    		<!-- Rating Us -->
					<div class="col-md-8 offset-md-2">
					    <div class="card p-4">
					        <h2 class="mb-4 text-center" style="font-family: 'Pacifico', cursive;color: red;">Rating Us</h2>
					        
					        <!-- Form Contact -->
					        <form action="<%= request.getContextPath() %>/index/rating.htm" method="post">
					        	<!-- Title -->
					            <div class="form-group row mt-4">
					                <label for="reviewContent" class="col-sm-2 col-form-label" style="font-family: 'Pacifico', cursive;">Review Content</label>
					                <div class="col-sm-10">
					                    <textarea class="form-control" name="reviewContent" rows="5" placeholder="Enter your review content here" style="font-family: 'Pacifico', cursive;" required></textarea>
					                </div>
					            </div>
					            
					            <!-- Stars -->
								<div class="form-group row mt-4">
									<div class="stars">
										<label class="rate">
											<input type="radio" name="radio1" id="star1" value="1" required>
											<div class="face"></div>
											<i class="far fa-star star one-star"></i>
										</label>
										<label class="rate">
											<input type="radio" name="radio1" id="star2" value="2">
											<div class="face"></div>
											<i class="far fa-star star two-star"></i>
										</label>
										<label class="rate">
											<input type="radio" name="radio1" id="star3" value="3">
											<div class="face"></div>
											<i class="far fa-star star three-star"></i>
										</label>
										<label class="rate">
											<input type="radio" name="radio1" id="star4" value="4">
											<div class="face"></div>
											<i class="far fa-star star four-star"></i>
										</label>
										<label class="rate">
											<input type="radio" name="radio1" id="star5" value="5">
											<div class="face"></div>
											<i class="far fa-star star five-star"></i>
										</label>
									</div>
								</div>

								<!-- Button submit -->
					            <div class="form-group row mt-4">
					                <div class="col-sm-12 text-center">
					                    <button type="submit" class="btn btn-primary">Submit</button>
					                </div>
					            </div>

					        </form>
					        <!-- End Form Contact -->
					    </div>
					</div>

		    		<!-- End Rating Us -->
				</div>
			</div>
		</section>
		<!-- End Contact Section -->

	</main>
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<footer id="footer" class="footer">

		<div class="container">
			<div class="row gy-3">
				<div class="col-lg-3 col-md-6 d-flex">
					<i class="bi bi-geo-alt icon"></i>
					<div>
						<h4>Address</h4>
						<p>
							11 Nguyen Dinh Chieu, Da Kao Ward<br> District 1, Ho Chi Minh City<br>
							<br>Referencing Yummy of <br> BootstrapMade for design.<br>
						</p>
					</div>

				</div>

				<div class="col-lg-3 col-md-6 footer-links d-flex">
					<i class="bi bi-telephone icon"></i>
					<div>
						<h4>Reservations</h4>
						<p>
							<strong>Phone:</strong> ${company.phone}<br> <strong>Email:</strong>
							${company.mail}<br>
						</p>
					</div>
				</div>

				<div class="col-lg-3 col-md-6 footer-links d-flex">
					<i class="bi bi-clock icon"></i>
					<div>
						<h4>Opening Hours</h4>
						<p>
							<strong>Mon-Sat: 9AM</strong> - 21PM<br> Sunday: Closed
						</p>
					</div>
				</div>

				<div class="col-lg-3 col-md-6 footer-links">
					<h4>Follow Us</h4>
					<div class="social-links d-flex">
						<a href="https://www.facebook.com/ptithochiminh/" class="twitter"><i class="bi bi-twitter"></i></a> <a
							href="https://www.facebook.com/ptithochiminh/" class="facebook"><i class="bi bi-facebook"></i></a> <a
							href="https://www.facebook.com/ptithochiminh/" class="instagram"><i class="bi bi-instagram"></i></a> <a
							href="https://www.facebook.com/ptithochiminh/" class="linkedin"><i class="bi bi-linkedin"></i></a>
					</div>
				</div>

			</div>
		</div>

	</footer>
	<!-- End Footer -->

	<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

	<div id="preloader"></div>

	<!-- Vendor JS Files -->
	
	<script type="text/javascript">		console.log("Đây là một thông điệp được in ra console.");</script>
	
	<script src="<%= request.getContextPath() %>/Resources/vendor/aos/aos.js"></script>
	<script src="<%= request.getContextPath() %>/Resources/vendor/glightbox/js/glightbox.min.js"></script>
	<script src="<%= request.getContextPath() %>/Resources/vendor/purecounter/purecounter_vanilla.js"></script>
	<script src="<%= request.getContextPath() %>/Resources/vendor/swiper/swiper-bundle.min.js"></script>
	<script src="<%= request.getContextPath() %>/Resources/vendor/php-email-form/validate.js"></script>
	<script src="<%= request.getContextPath() %>/Resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	


	<!-- Template Main JS File -->
	<script src="<%= request.getContextPath() %>/Resources/js/main.js"></script>

	<script type="text/javascript">
		
	</script>
	<!-- xỬ LÝ USERLOGO -->
	<script>
		
	    function addToCart(foodId) {
	        // Lấy số lượng hiện tại
	        var currentQuantity = parseInt(document.getElementById("quantity").textContent);
	
	        // Tăng số lượng lên 1
	        var newQuantity = currentQuantity + 1;
	
	        // Cập nhật số lượng hiển thị
	        document.getElementById("quantity").textContent = newQuantity;
	        
	        // Tại đây, bạn có thể thực hiện các logic khác như thêm sản phẩm vào giỏ hàng, gửi yêu cầu đến máy chủ, vv.
	        console.log("Đây là một thông điệp được in ra console.");
	    }

		// Kiểm tra nếu người dùng đã đăng nhập (giả sử biến loggedIn đã được đặt thành true)
		var loggedIn = ${sessionScope.isLogged};
		
		if (loggedIn) {
			// Ẩn nút Login
			document.getElementById("loginButton").style.display = "none";
			// Hiển thị logo của người dùng
			document.getElementById("userLogo").style.display = "inline-block";
			
		}
		else{
			// Ẩn nút Login
			document.getElementById("loginButton").style.display = "inline-block";
			// Hiển thị logo của người dùng
			document.getElementById("userLogo").style.display = "none";
		}
		
	</script>

	<!-- xỬ LÝ DROPDOWN USERLOGO -->
	<script>
	    document.addEventListener("DOMContentLoaded", function() {
			var dropdownToggle = document.getElementById('dropdownMenuicon');
			var dropdownMenu = document.querySelector('.dropdown-menu');

			dropdownToggle.addEventListener('click', function() {
				dropdownMenu.classList.toggle('show');
			});

			// Đóng dropdown khi click bên ngoài
			document.addEventListener('click', function(event) {
				var isClickInside = dropdownToggle.contains(event.target);
				if (!isClickInside) {
					dropdownMenu.classList.remove('show');
				}
			});
		});
	</script>
	
	<!-- //Xử lý giỏ hàng -->
	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function() {
		    var addToCartButtons = document.querySelectorAll('.add-to-cart-btn');
		    var quantitySpan = document.querySelector('.quantity');
	
		    // Lấy danh sách foods từ Session Storage hoặc một mảng trống
		    var foods = getSessionStorageValue('foods') ? getSessionStorageValue('foods').split(',') : [];
	
		    // Hiển thị số lượng foods ban đầu từ Session Storage
		    quantitySpan.textContent = foods.length;
		    
            // Thêm số lượng foods vào href của cartLink
            if(foods.length>0)
            	cartLink.href = "<%= request.getContextPath() %>/index/cart.htm?foodId=" + sessionStorage.getItem('foods');
	
		    addToCartButtons.forEach(function(button) {
		        // Kiểm tra xem foodId đã được thêm vào Session Storage hay chưa
		        if (foods.includes(button.id)) {
		            button.textContent = 'Item Added';
		        }
	
		        button.addEventListener('click', function() {
		            // Lấy ID của food được click
		            var foodId = button.id;
	
		            // Kiểm tra xem foodId đã tồn tại trong danh sách foods chưa
		            if (!foods.includes(foodId)) {
		                // Nếu chưa tồn tại, thêm foodId vào danh sách
		                foods.push(foodId);
		                // Cập nhật Session Storage với danh sách foods mới
		                setSessionStorageValue('foods', foods.join(','));
		                // Thêm số lượng foods vào href của cartLink
		                cartLink.href = "<%= request.getContextPath() %>/index/cart.htm?foodId=" + sessionStorage.getItem('foods');
		                // Cập nhật nội dung của thẻ quantity
		                quantitySpan.textContent = foods.length;
		                // Thay đổi văn bản của button
		                button.textContent = 'Item added';
		            }
		        });
		    });
	
		    // Hàm lấy giá trị từ Session Storage
		    function getSessionStorageValue(key) {
		        return sessionStorage.getItem(key);
		    }
	
		    // Hàm lưu trữ giá trị vào Session Storage
		    function setSessionStorageValue(key, value) {
		        sessionStorage.setItem(key, value);
		    }
		});

	</script>

	<!-- Xử lý rating -->
	<script type="text/javascript">
		$(function() {
			
			$(document).on({
				mouseover: function(event) {
					$(this).find('.far').addClass('star-over');
					$(this).prevAll().find('.far').addClass('star-over');
				},
				mouseleave: function(event) {
					$(this).find('.far').removeClass('star-over');
					$(this).prevAll().find('.far').removeClass('star-over');
				}
			}, '.rate');
	
	
			$(document).on('click', '.rate', function() {
				if ( !$(this).find('.star').hasClass('rate-active') ) {
					$(this).siblings().find('.star').addClass('far').removeClass('fas rate-active');
					$(this).find('.star').addClass('rate-active fas').removeClass('far star-over');
					$(this).prevAll().find('.star').addClass('fas').removeClass('far star-over');
				} else {
					console.log('has');
				}
			});
			
		});
		

	</script>


</body>

</html>