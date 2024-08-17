<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords"
        content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, Nice lite admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, Nice admin lite design, Nice admin lite dashboard bootstrap 5 dashboard template">
    <meta name="description"
        content="Nice Admin Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
    <meta name="robots" content="noindex,nofollow">
    <title>Admin - Products</title>
    <!-- Favicon icon -->
    <link href="<%= request.getContextPath() %>/Resources/images/favicon.svg" rel="icon">
    <!-- Custom CSS -->
    <link href="<%= request.getContextPath() %>/Resources/dashboard/assets/libs/chartist/dist/chartist.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="<%= request.getContextPath() %>/Resources/dashboard/dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
	<style type="text/css">
		.menu-item-image {
		  max-width: 20%;
		  height: auto;
		}
	</style>
</head>

<body>
	<c:if test="${not empty Message}">
    <script>
        // Hiển thị biến trong cửa sổ cảnh báo
        alert("${Message}");
q    </script>
</c:if>
    <!-- ============================================================== -->
    <!-- Preloader - style you can find in spinners.css -->
    <!-- ============================================================== -->
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper" data-navbarbg="skin6" data-theme="light" data-layout="vertical" data-sidebartype="full"
        data-boxed-layout="full">
        <!-- ============================================================== -->
        <!-- Topbar header - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <header class="topbar" data-navbarbg="skin6">
            <nav class="navbar top-navbar navbar-expand-md navbar-light">
                <div class="navbar-header" data-logobg="skin5">
                    <!-- This is for the sidebar toggle which is visible on mobile only -->
                    <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)">
                        <i class="ti-menu ti-close"></i>
                    </a>
                    <!-- ============================================================== -->
                    <!-- Logo -->
                    <!-- ============================================================== -->
                    <div class="navbar-brand">
                        <a href="dashboard.htm" class="logo">
                            <!-- Logo icon -->
                            <b class="logo-icon">
                                <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                                <!-- Dark Logo icon -->
                                <img src="<%= request.getContextPath() %>/Resources/dashboard/assets/images/logo-icon.png" alt="homepage" class="dark-logo" />
                                <!-- Light Logo icon -->
                                <img src="<%= request.getContextPath() %>/Resources/dashboard/assets/images/logo-light-icon.png" alt="homepage" class="light-logo" />
                            </b>
                            <!--End Logo icon -->
                            <!-- Logo text -->
                            <span class="logo-text">
                                <!-- dark Logo text -->
                                <img src="<%= request.getContextPath() %>/Resources/dashboard/assets/images/logo-text.png" alt="homepage" class="dark-logo" />
                                <!-- Light Logo text -->
                                <img src="<%= request.getContextPath() %>/Resources/dashboard/assets/images/logo-light-text.png" class="light-logo" alt="homepage" />
                            </span>
                        </a>
                    </div>
                    <!-- ============================================================== -->
                    <!-- End Logo -->
                    <!-- ============================================================== -->
                    <!-- ============================================================== -->
                    <!-- Toggle which is visible on mobile only -->
                    <!-- ============================================================== -->
                    
                </div>
                <!-- ============================================================== -->
                <!-- End Logo -->
                <!-- ============================================================== -->
                <div class="navbar-collapse collapse" id="navbarSupportedContent" data-navbarbg="skin6">
                    <!-- ============================================================== -->
                    <!-- toggle and nav items -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav float-start me-auto">
                        <!-- ============================================================== -->
                        <!-- Search -->
                        <!-- ============================================================== -->
                        <li class="nav-item search-box">
                            <a class="nav-link waves-effect waves-dark" href="javascript:void(0)">
                                <div class="d-flex align-items-center">
                                    <i class="mdi mdi-magnify font-20 me-1"></i>
                                    <div class="ms-1 d-none d-sm-block">
                                        <span>Search</span>
                                    </div>
                                </div>
                            </a>
                            <form class="app-search position-absolute">
                                <input type="text" class="form-control" placeholder="Search &amp; enter">
                                <a class="srh-btn">
                                    <i class="ti-close"></i>
                                </a>
                            </form>
                        </li>
                    </ul>
                    <!-- ============================================================== -->
                    <!-- Right side toggle and nav items -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav float-end">
                        <!-- ============================================================== -->
                        <!-- User profile and search -->
                        <!-- ============================================================== -->
						<a href="profile.htm" class="nav-link dropdown-toggle text-muted waves-effect waves-dark pro-pic"  >
                                <img src="<%= request.getContextPath() %>/Resources/dashboard/assets/images/users/1.jpg" alt="user" class="rounded-circle" width="31">
                         </a>
                        <!-- ============================================================== -->
                        <!-- User profile and search -->
                        <!-- ============================================================== -->
                    </ul>
                </div>
            </nav>
        </header>
        <!-- ============================================================== -->
        <!-- End Topbar header -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <aside class="left-sidebar" data-sidebarbg="skin5">
            <!-- Sidebar scroll-->
            <div class="scroll-sidebar">
                <!-- Sidebar navigation-->
                <nav class="sidebar-nav">
                    <ul id="sidebarnav">
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="dashboard.htm"
                                aria-expanded="false">
                                <i class="mdi mdi-av-timer"></i>
                                <span class="hide-menu">Dashboard</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="order.htm"
                                aria-expanded="false">
                                <i class="mdi mdi-table"></i>
                                <span class="hide-menu">Orders</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="product.htm"
                                aria-expanded="false">
                                <i class="mdi mdi-food"></i>
                                <span class="hide-menu">Products</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="customer.htm"
                                aria-expanded="false">
                                <i class="mdi mdi-account"></i>
                                <span class="hide-menu">Customers</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="review.htm"
                                aria-expanded="false">
                                <i class="mdi mdi-comment-text"></i>
                                <span class="hide-menu">Review</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="admin.htm"
                                aria-expanded="false">
                                <i class="mdi mdi-account-star-variant"></i>
                                <span class="hide-menu">Admin</span>
                            </a>
                        </li>

                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="<%= request.getContextPath() %>/index/log_out.htm"
                                aria-expanded="false">
                                <i class="mdi mdi-logout"></i>
                                <span class="hide-menu">Log out</span>
                            </a>
                        </li>
                    </ul>
                </nav>
                <!-- End Sidebar navigation -->
            </div>
            <!-- End Sidebar scroll-->
        </aside>
        <!-- ============================================================== -->
        <!-- End Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper  -->
        <!-- ============================================================== -->
        <div class="page-wrapper">
            <!-- ============================================================== -->
            <!-- Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-5 align-self-center">
                        <h4 class="page-title">Products</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Products</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid">
            
            	<!-- PRODUCT TABLE -->
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">Products table</h4>
                            <h6 class="card-subtitle">Similar to tables, use the modifier classes .thead-light to
                                make <code>&lt;thead&gt;</code>s appear light.</h6>
                        </div>
                        <div class="table-responsive">
                            <table class="table">
                                <thead class="table-light">
                                    <tr>
										<th scope="col">No.</th>
										<th scope="col">Id</th>
										<th scope="col">Name</th>
										<th scope="col">Price</th>
										<th scope="col">Category</th>
										<th scope="col">Edit</th>
                                    </tr>
                                </thead>
                                <tbody>
			                       <!-- JSTL forEach loop to iterate over orderList -->
			                       <c:forEach items="${list}" var="food" varStatus="status">
			                           <tr>
			                               <td>${(curPage-1)*10 + status.index + 1}</td> 
			                               <td>${food.id}</td> 
			                               <td>${food.name}</td> 
			                               <td><fmt:formatNumber value="${food.price}" type="number" maxFractionDigits="0" />đ</td> 
			                               <td>${food.category.name	}</td>
			                               <td>
			                                   <a href="<c:url value='editProduct.htm?productId=${food.id}&page=${curPage}' />">
			                                       <i class="mdi mdi-format-list-bulleted"></i>
			                                   </a>
			                               </td> <!-- Link đến trang edit product -->
			                           </tr>
			                       </c:forEach>
			                       <!-- End JSTL forEach loop -->
                                </tbody>
                            </table>
                            
                            <!-- Page -->
							<nav aria-label="">
							  <ul class="pagination pagination-sm">
							  
							     <li class="page-item disabled" >
							        <a class="page-link" >Page:</a>
							     </li>
							    <!-- Sử dụng forEach để tạo các thẻ <li> và <a> cho từng trang từ 2 đến numPage -->
							    <c:forEach begin="1" end="${numPage}" var="pageNumber">
							      <c:set var="disabled" value="${pageNumber == curPage ? 'disabled' : ''}" />
							      <li class="page-item ${disabled}" >
							        <a class="page-link" href="product.htm?page=${pageNumber}">
							          ${pageNumber}
							        </a>
							      </li>
							    </c:forEach>
							    
							    <!-- button add -->
							    <li class="page-item}" >
							        <a class="page-link" href="addProduct.htm">Add Product</a>
							     </li>
							  </ul>
							</nav>
							
                        </div>
                    </div>
                </div>
                
                <!-- CATEGORY TABLE -->
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">Category table</h4>
                            <h6 class="card-subtitle">Similar to tables, use the modifier classes .thead-light to
                                make <code>&lt;thead&gt;</code>s appear light.</h6>
                        </div>
                        <div class="table-responsive">
                            <table class="table">
                                <thead class="table-light">
                                    <tr>
										<th scope="col">No.</th>
										<th scope="col">Id</th>
										<th scope="col">Name</th>
										<th scope="col">Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
			                       <!-- JSTL forEach loop to iterate over orderList -->
			                       <c:forEach items="${category}" var="category" varStatus="status">
			                           <tr>
			                               <td>${status.index + 1}</td> 
			                               <td>${category.id}</td> 
			                               <td>${category.name}</td> 
			                               <td>
			                                   <a href="<c:url value='deleteCategory.htm?categoryId=${category.id}' /> " style="color: red;">
			                                       <i class="mdi mdi-delete-forever"></i>
			                                   </a>
			                               </td> <!-- Xóa -->
			                           </tr>
			                       </c:forEach>
			                       <!-- End JSTL forEach loop -->
                                </tbody>
                            </table>
							
                        </div>
                    </div>
                </div>
				
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->

            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="<%= request.getContextPath() %>/Resources/dashboard/assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="<%= request.getContextPath() %>/Resources/dashboard/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script src="<%= request.getContextPath() %>/Resources/dashboard/assets/extra-libs/sparkline/sparkline.js"></script>
    <!--Wave Effects -->
    <script src="<%= request.getContextPath() %>/Resources/dashboard/dist/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="<%= request.getContextPath() %>/Resources/dashboard/dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="<%= request.getContextPath() %>/Resources/dashboard/dist/js/custom.min.js"></script>
    <!--This page JavaScript -->
    <!--chartis chart-->
    <script src="<%= request.getContextPath() %>/Resources/dashboard/assets/libs/chartist/dist/chartist.min.js"></script>
    <script src="<%= request.getContextPath() %>/Resources/dashboard/assets/libs/chartist-plugin-tooltips/dist/chartist-plugin-tooltip.min.js"></script>
    <script src="<%= request.getContextPath() %>/Resources/dashboard/dist/js/pages/dashboards/dashboard1.js"></script>
</body>

</html>