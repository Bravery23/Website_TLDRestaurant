<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Detail</title>
<link href="../Resources/images/favicon.svg" rel="icon">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container">
		<!-- Lịch sử đặt hàng -->
		<div class="row">
			<div class="col-sm-12">
				<div class="card">
					<div class="card-body">
						<!-- TABLE ORDERED LIST -->
						<h5 class="d-flex align-items-center mb-3">Ordered detail</h5>
						<table class="table">
							<thead>
								<tr>
									<th scope="col">No.</th>
									<th scope="col">Food</th>
									<th scope="col">Price</th>
									<th scope="col">Quantity</th>
									<th scope="col">Total</th>
								</tr>
							</thead>
							<tbody>
							    <!-- Sử dụng JSTL forEach để lặp qua danh sách Order_Details -->
							    <c:forEach var="orderDetail" items="${detail}" varStatus="status">
							        <tr>
							            <td>${status.index + 1}</td> <!-- Số thứ tự -->
							            <td>${orderDetail.food.name}</td> <!-- Tên món ăn -->
							            <td><fmt:formatNumber value="${orderDetail.price/orderDetail.quantity}" type="number" maxFractionDigits="0" />đ</td> <!-- Giá -->
							            <td>${orderDetail.quantity}</td> <!-- Số lượng -->
							            <td><fmt:formatNumber value="${orderDetail.price}" type="number" maxFractionDigits="0" />đ</td> <!-- Tổng cộng -->
							        </tr>
							    </c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="4"><strong>GRAND TOTAL</strong></td>
									<td><strong><fmt:formatNumber value="${detail[0].order.totalPrice}" type="number" maxFractionDigits="0" />đ</strong></td>
								</tr>
							</tfoot>
						</table>
						<!-- END TABLE -->
						<a href="order.htm?page=${curPage}" class = "btn btn-primary">Back</a>
					</div>
				</div>
			</div>
			
		</div>
		<!-- End table -->
		
	</div>
	


</body>
</html>