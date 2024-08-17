<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Admin - Edit Product</title>
    <!-- Favicon icon -->
    <link href="<%= request.getContextPath() %>/Resources/images/favicon.svg" rel="icon">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        body { margin-top: 20px; background-color: #f2f6fc; color: #69707a; }
        .img-account-profile { height: 10rem; }
        .rounded-circle { border-radius: 50% !important; }
        .card { box-shadow: 0 0.15rem 1.75rem 0 rgb(33 40 50/ 15%); }
        .card .card-header { font-weight: 500; }
        .card-header:first-child { border-radius: 0.35rem 0.35rem 0 0; }
        .card-header { padding: 1rem 1.35rem; margin-bottom: 0; background-color: rgba(33, 40, 50, 0.03); border-bottom: 1px solid rgba(33, 40, 50, 0.125); }
        .form-control, .dataTable-input { display: block; width: 100%; padding: 0.875rem 1.125rem; font-size: 0.875rem; font-weight: 400; line-height: 1; color: #69707a; background-color: #fff; background-clip: padding-box; border: 1px solid #c5ccd6; -webkit-appearance: none; -moz-appearance: none; appearance: none; border-radius: 0.35rem; transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out; }
        .nav-borders .nav-link.active { color: #0061f2; border-bottom-color: #0061f2; }
        .nav-borders .nav-link { color: #69707a; border-bottom-width: 0.125rem; border-bottom-style: solid; border-bottom-color: transparent; padding-top: 0.5rem; padding-bottom: 0.5rem; padding-left: 0; padding-right: 0; margin-left: 1rem; margin-right: 1rem; }
    </style>
</head>
<body>
<c:if test="${not empty Message}">
    <script>
        // Hiển thị biến trong cửa sổ cảnh báo
        alert("${Message}");
    </script>
</c:if>
<!-- Form -->
<form action="#" method="POST" id="infoProduct" enctype="multipart/form-data">
<div class="container-xl px-4 mt-4">
    <nav class="nav nav-borders">
        <a class="nav-link active ms-0" href="#">Food Editor</a>
    </nav>
    <hr class="mt-0 mb-4">
    <div class="row">
        <!-- Product Picture -->
        <div class="col-xl-4">
            <div class="card mb-4 mb-xl-0">
                <div class="card-header">Product Picture</div>
                <div class="card-body text-center">
                    <img class="img-account-profile rounded-circle mb-2" id="previewImage"
                         src="<%= request.getContextPath() %>/Resources/images/menu/menu-item-1.png">
                    <div class="small font-italic text-muted mb-4">JPG or PNG size 610px x 610px is the best</div>
                    <input type="file" id="file" name="file" class="form-control" accept="image/*">
                </div>
            </div>
        </div>

        <!-- Product Detail -->
        <div class="col-xl-8">
            <div class="card mb-4">
                <div class="card-header">Product Details</div>
                <div class="card-body">
                    
                        <div class="mb-3">
                            <label class="small mb-1" for="name">Product Name</label>
                            <input name="name" class="form-control" id="name" type="text"
                                   placeholder="Enter product's name" value="${product.name}" required>
                        </div>

                        <div class="row gx-3 mb-3">
                            <div class="mb-3">
                                <label class="small mb-1" for="price">Price</label>
                                <input name="price" class="form-control" id="price" type="number"
                                       placeholder="Enter product's price" value="${product.price}" required>
                            </div>


                        </div>

                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1" for="category">Category</label>
                                <select name="category" class="form-control" id="category">
                                    <option value="new">New Category --></option>
                                    <c:forEach items="${list}" var="category">
                                        <option value="${category.name}"
                                                <c:if test="${category.id eq product.category.id}">selected</c:if>>${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="small mb-1" for="new">New Category</label>
                                <input name="new" class="form-control" id="new" type="text"
                                       placeholder="Enter new category" required value="">
                            </div>
                        </div>

                        <button class="btn btn-primary" type="submit">Save changes</button>
                        <a href="deleteProduct.htm?productId=${product.id}" class="btn btn-danger">Delete</a>
                        <a href="product.htm?page=${page}" class="btn btn-secondary">Cancel</a>
                    
                </div>
            </div>
        </div>
    </div>
</div>
</form>
<!--End Form -->

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var categorySelect = document.getElementById("category");
        var newCategoryInput = document.getElementById("new");

        categorySelect.addEventListener("change", function () {
            if (categorySelect.value === "new") {
                newCategoryInput.required = true;
                newCategoryInput.disabled = false;
            } else {
                newCategoryInput.required = false;
                newCategoryInput.disabled = true;
                newCategoryInput.value = ""; // Clear the new category input
            }
        });

        handleListValue();

        $('#file').change(function () {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#previewImage').attr('src', e.target.result);
            };
            reader.readAsDataURL(this.files[0]);
        });
    });

    function handleListValue() {
        var listValue = "${product.name}";
        var categorySelect = document.getElementById("category");
        var newCategoryInput = document.getElementById("new");
        var infoProduct = document.getElementById("infoProduct");
        var previewImage = document.getElementById("previewImage");

        if (listValue.length == 0) {
            var deleteButton = document.querySelector('.btn-danger'); // Select delete button
            var saveButton = document.querySelector('button[type="submit"]'); // Select save changes button

            deleteButton.style.display = "none"; // Hide delete button
            saveButton.innerText = "Add"; // Change text of save changes button to "Add"
            infoProduct.action = "addProduct.htm";
            
        } else {
            newCategoryInput.required = false;
            newCategoryInput.disabled = true;
            newCategoryInput.value = ""; // Clear the new category input
            infoProduct.action = "modifyProduct.htm?productId=" + "${product.id}";
            previewImage.src = "<%= request.getContextPath() %>/Resources/images/${product.url}"
        }
    }
</script>
</body>
</html>