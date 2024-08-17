<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>User Information</title>
<link href="../Resources/images/favicon.svg" rel="icon">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<style type="text/css">



body {
	background: #f7f7ff;
	margin-top: 20px;
}

    .alert {
        padding: 15px;
        margin-bottom: 20px;
        border: 1px solid transparent;
        border-radius: 4px;
    }

    .alert-success {
        color: #3c763d;
        background-color: #dff0d8;
        border-color: #d6e9c6;
    }
    
    .alert-error {
    color: #a94442;
    background-color: #f2dede;
    border-color: #ebccd1;
}
    

.card {
	position: relative;
	display: flex;
	flex-direction: column;
	min-width: 0;
	word-wrap: break-word;
	background-color: #fff;
	background-clip: border-box;
	border: 0 solid transparent;
	border-radius: .25rem;
	margin-bottom: 1.5rem;
	box-shadow: 0 2px 6px 0 rgb(218 218 253/ 65%), 0 2px 6px 0
		rgb(206 206 238/ 54%);
}

.me-2 {
	margin-right: .5rem !important;
}

.img-bill-icon {
	width: 24px; /* Chiều rộng mong muốn */
	height: auto; /* Chiều cao tự động dựa trên tỉ lệ chiều rộng */
	text-align: center;
}
</style>
<script>
    function validateForm() {
        // Get form elements
        const name = document.getElementById('inputName').value;
        const phone = document.getElementById('inputPhone').value;
        const email = document.getElementById('inputEmail').value;
        var role = "${sessionScope.role}";

        // Regular expressions for validation
        const phonePattern = /^[0-9]{10}$/;
        const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

        // Validation checks
        if (!phone || !phonePattern.test(phone)) {
            alert('Please enter a valid phone number (10 digits).');
            return false;
        }
        if ((!email || !emailPattern.test(email)) && role !== "Admin") {
            alert('Please enter a valid email address.');
            return false;
        }
        if (!username || !usernamePattern.test(username)) {
            alert('Please enter a valid username.');
            return false;
        }

        // If all validations pass
        return true;
    }
</script>
</head>
<body>

	<div class="container">
		<div class="main-body">
			<div class="row">
				<div class="col-lg-4">
					<div class="card">
						<div class="card-body">
							<div class="d-flex flex-column align-items-center text-center">
								<img src="https://bootdey.com/img/Content/avatar/avatar6.png"
									alt="Admin" class="rounded-circle p-1 bg-primary" width="110">
								<div class="mt-3">
									<h4>${customer.name}</h4>
									<p class="text-muted font-size-sm">${customer.number}</p>
									<p class="text-muted font-size-sm">${email}</p>
								</div>

								<!-- Popup Change Password -->
								<div class="text-center mt-3">
								<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#changePasswordModal" id = "btnChangPassword">Change Password </button>
								
								<!-- Modal -->
								<div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h5 class="modal-title" id="changePasswordModalLabel">Change Password</h5>
								        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
								          <span aria-hidden="true">&times;</span>
								        </button>
								      </div>
								      <form action="ChangePassword.htm" method="POST" id="changePasswordForm">
								      <div class="modal-body">
								          <%--<div class="form-group">
								            <label for="oldPassword">Mật khẩu cũ</label>
								            <input type="password" class="form-control" id="oldPassword">
								          </div>
								          --%>
								              <p  id ="notMatchMessage"></p>
								              
								          <div class="form-group">
								            <label for="newPassword">Mật khẩu mới</label>
								            <input name = "newPassword" type="password" class="form-control" id="newPassword">
								          </div>
								          <div class="form-group">
								            <label for="confirmPassword">Nhập lại</label>
								            <input type="password" class="form-control" id="confirmPassword">
								          </div>
								          <input type="hidden" name="curUser" value="${customer.username}">
								        <p id="error_confirm"></p>
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
								        <button type="submit" class="btn btn-primary" id="saveChangesBtn">Save changes</button>
								      </div>
								      </form>
								    </div>
								  </div>
								</div> <!-- End Modal -->

								</div>
							
							
							</div>
						</div>
					</div>
				</div>

				<!-- Thông tin chi tiết -->

				<div class="col-lg-8">
				<form action="saveChange.htm" method="POST" id = "detailInfor" onsubmit="return validateForm()">
				<div class="card">
				
				<c:if test="${not empty message}">
    				<div class="alert alert-success" id ="updateMessage">
        				${message}
    				</div>
    			
				</c:if>
				
						<div class="card-body">
							<div class="row mb-3">
								<div class="col-sm-3">
									<h6 class="mb-0">Full Name</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<input name = "name" id = "inputName" type="text" class="form-control" value="${customer.name}">
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-sm-3">
									<h6 class="mb-0">Username</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<input name = "username"  type="text" class="form-control"
										value="${customer.username}" readonly>
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-sm-3">
									<h6 class="mb-0" id = "emailLabel">Email</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<input name = "email" type="text" class="form-control"
										value="${customer.email}" id = "inputEmail">
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-sm-3">
									<h6 class="mb-0">Phone</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<input name = "phone" id = "inputPhone" type="text" class="form-control" value="${customer.number}" >
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3"></div>
								<div class="col-sm-9 text-secondary">
									<button type="submit" class="btn btn-primary px-4" id = "saveChangesBtnBig">Save Changes</button>
									<a href="../index/index.htm" class="btn btn-primary" id = "btnBack">&#8962; Back</a>									
								</div>
							</div>
						</div>
					</div>
				</form>
					<!-- Lịch sử đặt hàng -->
					<div class="row">
						<div class="col-sm-12">
							<div class="card">
								<div class="card-body" id = "orderList">
								   <!-- TABLE ORDERED LIST -->
									<h5 class="d-flex align-items-center mb-3">Ordered list</h5>
									<table class="table">
										<thead>
											<tr>
												<th scope="col">No.</th>
												<th scope="col">Date</th>
												<th scope="col">Time</th>
												<th scope="col">Total</th>
												<th scope="col">Detail</th>
												<th scope="col">Status</th>
											</tr>
										</thead>
										<tbody>
				                        <!-- JSTL forEach loop to iterate over orderList -->
				                        <c:forEach items="${orderList}" var="order" varStatus="status">
				                            <tr>
				                                <td>${status.index + 1}</td> <!-- Số thứ tự -->
				                                <td>${order.orderDay}</td> <!-- Ngày đặt hàng -->
				                                <td>${order.orderTime}</td> <!-- Thời gian đặt hàng -->
				                                <td><fmt:formatNumber value="${order.totalPrice}" type="number" maxFractionDigits="0" />đ </td> <!-- Tổng số tiền -->
				                                <td>
				                                    <a href="<c:url value='orderdetail.htm?orderId=${order.id}' />">
				                                        <img class="img-bill-icon" src="https://pic.onlinewebfonts.com/thumbnails/icons_400063.svg" alt="Bill Icon">
				                                    </a>
				                                </td> <!-- Link đến trang chi tiết đơn hàng -->
				                                <td> <!-- status -->
						                           <c:choose>
						                                <c:when test="${order.status.trim() eq 'Completed'}">
						                                    <span class="badge badge-pill badge-success">
						                                        <i class="bi bi-check-circle"></i> Completed
						                                    </span>
						                                </c:when>
						                                <c:otherwise>
						                                    <span class="badge badge-pill badge-warning">
						                                        <i class="bi bi-hourglass-split"></i> Pending
						                                    </span>
						                                </c:otherwise>
						                            </c:choose>
							                    </td>
				                            </tr>
				                        </c:forEach>
				                        <!-- End JSTL forEach loop -->
										</tbody>
									</table>
									<!-- END TABLE -->
								</div>
							</div>
						</div>
					</div> <!-- End Lịch sử đặt hàng -->
				
				
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Xử lý popup đổi mật khẩu -->
<script>
	$(document).ready(function(){
	    $("#saveChangesBtn").click(function(event){
	        var newPassword = $("#newPassword").val();
	        var confirmPassword = $("#confirmPassword").val();
	
	        if(newPassword !== confirmPassword) {
	            $("#notMatchMessage").addClass('alert alert-error').text("Mật khẩu mới và xác nhận mật khẩu không khớp!").show();
	
	            setTimeout(function() {
	                $("#notMatchMessage").hide();
	            }, 2000);
	            event.preventDefault();
	        }
	
	        // If everything is valid, you can perform your form processing here,
	        // e.g., send the form data to the server to change the password.
	    });
	
	    setTimeout(function() {
	        $("#updateMessage").hide();
	    }, 5000);
	
	    // Handle role
	    var role = "${sessionScope.role}";
		var email = "${email}";
		var cus_email = "${customer.email}";
	    var backButton = document.getElementById('btnBack');
	    var saveChangesBtn = document.getElementById('saveChangesBtnBig');
	    var form = document.getElementById('detailInfor');
	    var pwForm = document.getElementById('changePasswordForm');
        var emailInput = document.getElementById('inputEmail');
        var emailLabel = document.getElementById('emailLabel');
        var inputElement = document.querySelector('input[name="username"]');
        var inputphone = document.querySelector('input[name="phone"]');
        var inputname = document.querySelector('input[name="name"]');
        var inputemail = document.querySelector('input[name="email"]');

        
        //Role admin
	    if (role === "Admin") {
	    	backButton.href = "../admin/admin.htm";
	    	emailInput.style.display = 'none';
	    	emailLabel.style.display = 'none';
	        
	        $("#orderList").hide();
	        
	        // add admin
	        if (email === "newadmin@gmail.com") {
	            $("#btnChangPassword").hide();
	            form.action = '../admin/addAdmin.htm'; 
	            inputElement.removeAttribute('readonly');
	            
	        }
			
	        //Update admin
	        else if (cus_email === "") {
	            // Logic for empty email (admin)
	        	form.action = '../admin/modifyAdmin.htm';
	        	pwForm.action = '../admin/changePassword.htm';
	        	
	        }
	        
	        //show customer
	        else {
	            // Logic for other admin management
	        	backButton.href = "../admin/customer.htm";
	        	$("#btnChangPassword").hide();
	        	saveChangesBtn.style.display = 'none';
	        	emailInput.style.display = 'block';
		    	emailLabel.style.display = 'block';
		    	inputemail.setAttribute('readonly',true);
		    	inputname.setAttribute('readonly',true);
		    	inputphone.setAttribute('readonly',true);
		    	$("#orderList").show();
	        }
	        $("#btnBack").text("Back");
	    } 
	    //Khách hàng sửa khách hàng
	    else {
	    	
	    }
	});
</script>


</body>
</html>