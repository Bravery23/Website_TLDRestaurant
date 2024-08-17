<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Cart</title>
	<link href="../Resources/images/favicon.svg" rel="icon">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="../Resources/css/cart/cart.css" rel="stylesheet">
	
</head>
<body>
	<div class="card">
            <div class="row">
                <div class="col-md-8 cart">
                
                	<!-- Tittle -->
                    <div class="title">
                        <div class="row">
                            <div class="col"><h4><b>Shopping Cart</b></h4></div>
                            <div class="col align-self-center text-right text-muted" id = "totalFood"></div>	
                        </div>
                    </div>    
                    
                    <!-- Hiển thị danh sách food -->
					<c:forEach items="${list}" var="food">
					    <div class="row border-top border-bottom">
					        <div class="row main align-items-center">
					            <div class="col-2"><img class="img-fluid" src="<%= request.getContextPath() %>/Resources/images/${food.url}"></div>
					            <div class="col">
					                <div class="row text-muted"><c:out value="${food.category.name}" /></div>
					                <div class="row"><c:out value="${food.name}" /></div>
					            </div>
					            <div class="col">
					                <a href="#" class="decrement" data-id="${food.id}">-</a>
					                <a href="#" class="border quantity" id="quantity${food.id}" data-id="${food.id}">1</a>
					                <a href="#" class="increment" data-id="${food.id}">+</a>
					            </div>
					            <div class="col"> <span class="price" id="price${food.id}" data-price = "${food.price}"><fmt:formatNumber value="${food.price}" type="number" maxFractionDigits="0" />đ</span> <span class="close"><a href="#">&#10005;</a></span></div>
					        </div>
					    </div>
					</c:forEach>
					
					<!-- Mũi tên back to shop -->
                    <div class="back-to-shop"><a href="index.htm">&leftarrow; Back to shop</a><span class="text-muted"></span></div>
                </div>
                
                <!-- Summary -->
                <div class="col-md-4 summary">
                    <div><h5><b>Summary</b></h5></div>
                    <hr>
                    <div class="row">
                        <div class="col" style="padding-left:0;">TOTAL: </div>
                        <div class="col text-right" id = "totalQuantity"></div>
                    </div>
                    <form>
                        <p>SHIPPING</p>
                        <select><option class="text-muted">Standard-Delivery- &euro;5.00</option></select>
                        <p>GIVE CODE</p>
                        <input id="code" placeholder="Enter your code">
                    </form>
                    <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                        <div class="col">TOTAL PRICE</div>
                        <div class="col text-right" id = "totalPrice"></div>
                    </div>
                    
                    <!-- Tạo Form ẩn để truyền foodId và quantity tương ứng qua controller -->
	                <form id="cartForm" method="post" action="<%= request.getContextPath() %>/api/vnpay/createPayment.htm">
					    <!-- Loop qua danh sách foodId và quantity -->
					    <c:forEach items="${list}" var="food">
					        <input type="hidden" name="foodIds" value= "${food.id}">
					        <input type="hidden" name="quantities" id = "quantities${food.id}" value="1">
					        <input type="hidden" name="priceElement" id = "priceElement${food.id}" value="${food.price}">
					    </c:forEach>
					    <input type="hidden" id="amount" name="amount" value= "">
					    <button class="btn" id = "checkoutButton">CHECKOUT</button>
					</form>
					<!-- End Form -->
					
                </div>
                
            </div>
            
        </div>
        
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript">
		//Tăng giảm số lượng food
		updateAllTotalPriceAndQuantity();
		document.querySelectorAll('.increment, .decrement').forEach(button => {
		    button.addEventListener('click', function(e) {
		        e.preventDefault();
		        const foodId = this.getAttribute('data-id');
		        const quantityElement = document.getElementById('quantity' + foodId);
		        let quantity = parseInt(quantityElement.textContent);
		        const priceElement = document.getElementById('price' + foodId);
		        let foodPrice = parseFloat(priceElement.dataset.price); // Lấy giá trị từ thuộc tính data-price
	
		        if (this.classList.contains('increment')) {
		            quantity++;
		        } else {
		            if (quantity > 1) {
		                quantity--;
		            }
		        }
		        
		        // Tính toán lại TotalPrice (dựa trên foodPrice và quantity mới) và cập nhật Amount
		        let TotalPrice = foodPrice * quantity;
	            
		        // Cập nhật các thông số trên cart
		        quantityElement.textContent = quantity;
		        priceElement.textContent = TotalPrice+'đ'; // Để hiển thị giá tiền với hai chữ số sau dấu phẩy
		        updateAllTotalPriceAndQuantity();
		        
		     	// Gán giá trị vào input hidden tương ứng
		        document.getElementById('quantities' + foodId).value = quantity; 
		        document.getElementById('priceElement' + foodId).value = TotalPrice;
		        
		    });
		});
	
		function updateAllTotalPriceAndQuantity() {
		    // Lấy tất cả các phần tử .quantity và .price
		    const quantityElements = document.querySelectorAll('.quantity');
		    const priceElements = document.querySelectorAll('.price');

		    // Khởi tạo biến tổng
		    let totalQuantity = 0;
		    let totalPrice = 0;
		    let totalFood = 0;

		    // Duyệt qua mỗi phần tử và cộng tổng giá trị TotalPrice
		    quantityElements.forEach((quantityElement, index) => {
		        // Lấy số lượng từ phần tử .quantity
		        const quantity = parseInt(quantityElement.textContent);
		        totalQuantity += quantity;

		        // Lấy giá trị TotalPrice từ thuộc tính data-price của mỗi phần tử .price
		        const price = parseFloat(priceElements[index].dataset.price);
		        totalPrice += price * quantity;
		        
		        //Đếm số lượng food
		        totalFood++;
		        
		    });

		    // Cập nhật giá trị tổng vào phần tử HTML tương ứng
		    document.getElementById('totalPrice').textContent =  totalPrice+'đ';
		    document.getElementById('totalQuantity').textContent = totalQuantity > 1 ? totalQuantity +' items' : totalQuantity +' item';
		    document.getElementById('totalFood').textContent = totalFood > 1 ? totalFood +' foods' : totalFood +' food';
		    
		    //Cập nhật amount để gửi qua controller
		    var hiddenInput = document.getElementById("amount");
            hiddenInput.value = totalPrice; // Đặt giá trị cho thẻ input ẩn
		    
		    //Nếu không có item thì không cho bấm button CHECKOUT (phát triền sau)

		 
		}
		
		//Xóa food khỏi cart (xóa id khỏi session rồi return về controller)
		document.querySelectorAll('.close a').forEach(closeButton => {
		    closeButton.addEventListener('click', function(e) {
		        e.preventDefault();
		        
		        // Xác định phần tử cha (mặt hàng) cần xóa
		        const foodItem = this.closest('.row.main');
		        
		        // Lấy id của mặt hàng được bấm để xóa
		        const foodId = foodItem.querySelector('.quantity').getAttribute('data-id');
		        
		        // Lấy chuỗi lưu trữ từ sessionStorage
		        let storedIds = sessionStorage.getItem('foods');
		        
		        // Chuyển chuỗi lưu trữ thành mảng các id
		        let items = storedIds ? storedIds.split(',') : [];
		        
		        // Loại bỏ id của mặt hàng được bấm khỏi mảng id
		        const index = items.indexOf(foodId);
		        if (index !== -1) {
		            items.splice(index, 1);
		        }
		        
		        // Cập nhật lại chuỗi lưu trữ trong sessionStorage
		        sessionStorage.setItem('foods', items.join(','));
		        
                // Redirect về controller
                var href = "<%= request.getContextPath() %>/index/cart.htm?foodId=" + sessionStorage.getItem('foods');
                window.location.href = href;

		    });
		});
		
		// Kiểm tra xem có tồn tại thuộc tính "username" trong sessionStorage hay không
		sessionStorage.setItem('username', 'exampleValue');
		if (!sessionStorage.getItem("username")) {
		    // Chọn form và nút checkout
		    var cartForm = document.getElementById("cartForm");
		    var checkoutButton = document.getElementById("checkoutButton");
		    
		    // Set lại action của form
		    cartForm.setAttribute("action", "../login/loginForm.htm");

		    // Set lại text của nút checkout
		    checkoutButton.textContent = "LOGIN";

		} 

	</script>

</body>

</html>