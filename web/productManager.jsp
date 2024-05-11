<%-- 
    Document   : productManager
    Created on : Jan 25, 2024, 2:15:55 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Products Manager</title>
        <style>

            #searchByName .input-group {
                border-radius: 20px;
                overflow: hidden;
            }

            #searchByName input {
                border: 1px solid #ced4da;
                box-shadow: inset 0 1px 2px rgb(0 0 0 / 8%);
                transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
            }

            #searchByName input:focus {
                border-color: #80bdff;
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
            }

            #searchByName .btn-primary {
                border-radius: 0;
                box-shadow: none;
            }

            #searchByName .btn-primary .fa-search {
                margin-right: -6px;
            }

            #searchByName .btn-primary:focus {
                box-shadow: none;
            }
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f5f5f5;
                color: #333;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            h1 {
                font-weight: 600;
                text-align: center;
                margin-bottom: 30px;
            }
            .btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                text-align: center;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s;
            }
            .btn:hover {
                background-color: #0056b3;
            }
            form {
                display: inline-block;
                vertical-align: middle;
                margin-left: 20px;
            }
            .input-group {
                display: flex;
            }
            .form-control {
                flex: 1;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .input-group-append {
                padding: 0 10px;
            }
            .fa-search {
                font-size: 18px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Products Manager</h1>

            <!-- Insert a new product -->
            <div class="container">
                <div class="row">
                    <!-- Insert Product Button -->
                    <div class="col text-center mb-3">
                        <a href="manageProduct?service=requestInsert" class="btn btn-primary">Insert a new Product</a>
                    </div>
                </div>

                <!-- Search Product Form -->
                <c:if test="${showSearchProduct ne null}">
                    <div class="row justify-content-center mb-3">
                        <div class="col-md-8">
                            <form action="manageProduct" id="searchByName" class="input-group shadow-sm">
                                <input type="hidden" name="service" value="searchByKeywords"/>  
                                <input type="text" class="form-control" placeholder="Search by name" name="keywords" value="${keywords}"/>
                                <div class="input-group-append"> 
                                    <button class="btn btn-outline-secondary" type="submit">
                                        <i class="fa fa-search"></i>
                                    </button>  
                                </div>  
                            </form>  
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Display messages -->
            <c:if test="${notFoundProduct ne null}">
                <h4 class="text-center">${notFoundProduct}</h4>
            </c:if>
            <c:if test="${deleteDone ne null}">
                <h4 class="text-center">${deleteDone}</h4>
            </c:if>

            <!-- List all Products -->
            <c:if test="${not empty allProducts}">
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th style="background-color: #bfd1ec">ID</th>
                                <th style="background-color: #bfd1ec">Product Name</th>
                                <th style="background-color: #bfd1ec">Unit Price</th>
                                <th style="background-color: #bfd1ec">Quantity In Stock</th>
                                <th style="background-color: #bfd1ec">Release Date</th>
                                <th style="background-color: #bfd1ec">Update</th>
                                <th style="background-color: #bfd1ec">Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${allProducts}" var="product">
                                <tr>
                                    <td>${product.id}</td>
                                    <td>
                                        <img src="${product.image_url}" alt="${product.name}" style="width: 50px; vertical-align: middle;">
                                        ${product.name}
                                    </td>
                                    <td>${product.price}</td>
                                    <td>${product.quantity}</td>
                                    <td>${product.release_date}</td>
                                    <td><a href="manageProduct?service=requestUpdate&productId=${product.id}">Update</a></td>
                                    <td><a href="manageProduct?service=requestDelete&productId=${product.id}" onclick="return confirmDelete(${product.id})">Delete</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <script>
                    function confirmDelete(productId) {
                        return confirm("Are you sure you want to delete this Product (ID = " + productId + ") ?");
                    }
                </script>
            </c:if>

            <!-- Update Product -->
            <c:if test="${UpdateDone ne null}">
                <h3 class="text-center">${UpdateDone}</h3>
            </c:if>
            <c:if test="${productUpdate ne null}">
                <h1 class="text-center">Update Product</h1>
                <form action="manageProduct" id="updateProduct">
                    <input type="hidden" name="service" value="sendUpdateDetail"/>
                    <div class="table-responsive">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Product Name</th>
                                    <th>Unit Price</th>
                                    <th>Quantity In Stock</th>
                                    <th>Release Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" name="id" value="${productUpdate.id}" readonly/></td>
                                    <td><input type="text" name="name" value="${productUpdate.name}" size="55"/></td>
                                    <td><input type="number" name="price" value="${productUpdate.price}" style="width: 80px"/></td>
                                    <td><input type="number" name="quantity" value="${productUpdate.quantity}" style="width: 80px"/></td>
                                    <td><input type="text" name="release_date" value="${productUpdate.release_date}" size="8"/></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <button class="btn" onclick="document.getElementById('updateProduct').submit();">Update</button>
                </form>
            </c:if>

            <!-- Insert Product -->
            <c:if test="${InsertDone ne null}">
                <h3 class="text-center">${InsertDone}</h3>
            </c:if>
            <c:if test="${insertProduct ne null}">
                <h1 class="text-center">Insert a new Product</h1>
                <form action="manageProduct" id="insertProduct">
                    <input type="hidden" name="service" value="sendInsertDetail"/>
                    <div class="table-responsive">
                        <table>
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Unit Price</th>
                                    <th>Quantity In Stock</th>
                                    <th>Description</th>
                                    <th>Image Url</th>
                                    <th>Brand</th>
                                    <th>Release Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" name="name" size="55"/></td>
                                    <td><input type="number" name="price" style="width: 80px"/></td>
                                    <td><input type="number" name="quantity" style="width: 80px"/></td>
                                    <td><input type="text" name="description" size="15"/></td>
                                    <td><input type="text" name="image_url" size="15"/></td>
                                    <td>
                                        <select name="brand">
                                            <c:forEach items="${allBrands}" var="brand">
                                                <option value="${brand.id}">${brand.name}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td><input type="text" name="release_date" size="8"/></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <button class="btn" onclick="document.getElementById('insertProduct').submit();">Add</button>
                </form>
            </c:if>
        </div>
    </body>
</html>
