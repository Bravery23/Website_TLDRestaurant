<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>Staff</title>
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
	<!-- Link tới Bootstrap Icons CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
	<!-- Bootstrap CSS -->
	<link href="<%= request.getContextPath() %>/Resources/vendor/bootstrap/css/bootstrap.min.css">
	
	<script>
		var cur_id = 0;
		var newestId = 0;
		//Lấy dữ liệu từ controller ròi vẽ bảng
		function drawOrdersTable() {
		  //Kết nối tới Controller (server)
		  const xhr = new XMLHttpRequest();
		  xhr.open("GET", "../staff/getOrderData.htm?curId=" + cur_id); // Adjust path
		
		  xhr.onload = function() {
		    if (xhr.status === 200) { //Thành công
		      //Vẽ bảng
		      const tableElement = document.getElementById("orderTable");
		      tableElement.innerHTML = xhr.responseText.substring(xhr.responseText.indexOf('<'));
		      newestId = xhr.responseText.substring(0, xhr.responseText.indexOf('<')); // Lấy mã mới nhất
		      
		      // Nêu có đơn mới hiển thị thông báo "thêm đơn"
		      if(cur_id !== 0 && cur_id < newestId){
			      showSuccessMessage();
		      }
		      cur_id = newestId;
		      
		    } else {
		    	alert("Lỗi kết nối server!")
		    }
		  };
		
		  xhr.send();
		  
		}
		
		//Xử lý btn Finish
		function updateOrdersTable(id) {
		  const xhr = new XMLHttpRequest();
		  xhr.open("GET", "../staff/updateOrder.htm?id=" + id); // Adjust path
		
		  xhr.onload = function() {
		    if (xhr.status === 200) {
		    	drawOrdersTable();
		    } else {
		        alert("Lỗi kết nối server: "+ xhr.status)
		    }
		  };
		
		  xhr.send();
		  
		}
		
		// Hiện thông báo
		function showSuccessMessage() {
		  // Tạo một phần tử div để chứa thông báo
		  const successMessage = document.createElement("div");
		  successMessage.textContent = "Thông báo: 1 đơn hàng mới được đặt";
		  
		  // Thiết lập CSS cho thông báo
		  successMessage.style.position = "fixed";
		  successMessage.style.bottom = "20px"; // Dịch xuống phía dưới 20px
		  successMessage.style.right = "20px"; // Dịch sang phải 20px
		  successMessage.style.backgroundColor = "#00CD00"; // Màu xanh dương nhạt
		  successMessage.style.color = "#ffffff"; // Màu chữ trắng
		  successMessage.style.padding = "15px";
		  successMessage.style.borderRadius = "8px";
		  successMessage.style.boxShadow = "0 4px 8px rgba(0,0,0,0.1)";
		  successMessage.style.fontFamily = "'Courier New', Tahoma, Geneva, Verdana, sans-serif"; // Font đẹp hơn
		  successMessage.style.fontSize = "16px";
		  successMessage.style.transition = "opacity 0.3s ease-in-out"; // Hiệu ứng mượt hơn
		  
		  // Thêm thông báo vào body của trang
		  document.body.appendChild(successMessage);
		  
		  // Xóa thông báo sau một khoảng thời gian
		  setTimeout(function() {
		    successMessage.style.opacity = "0";
		    setTimeout(function() {
		      successMessage.remove();
		    }, 300); // Xóa sau khi hiệu ứng mờ dần kết thúc
		  }, 2000); // Hiển thị thông báo trong 2 giây
		}

		// Trigger table update on page load or at specific intervals (optional)
		setInterval(drawOrdersTable, 2000); // Update every 2 seconds
		drawOrdersTable();
	</script>
</head>

<body>
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
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="orderManagement.htm"
                                aria-expanded="false">
                                <i class="mdi mdi-table"></i>
                                <span class="hide-menu">Orders management</span>
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
                        <h4 class="page-title">Orders</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
							  <div class="container mt-4">
							    <!-- Button sử dụng Bootstrap -->
							    <button type="button" class="btn btn-outline-primary btn-sm" id = "refreshButton" onclick="drawOrdersTable()">
							    	<i class="bi bi-arrow-clockwise"></i> Refresh
							    </button>
							  </div>
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
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">Order details</h4>
                            <h6 class="card-subtitle">Similar to tables, use the modifier classes .thead-light to
                                make <code>&lt;thead&gt;</code>s appear light.</h6>
                        </div>
                        <div class="table-responsive">
                            <table class="table" id="orderTable">
								<!-- Dữ liệu truyền từ js -->
                            </table>
                        </div>
                    </div>
                </div>
           </div>
           
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>

            <!-- ============================================================== -->
            <!-- End Container fluid  -->

    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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