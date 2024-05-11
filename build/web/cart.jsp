<%-- 
    Document   : cart
    Created on : Feb 14, 2024, 2:15:55 PM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.CartItem, model.Product, java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Cart</title>
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <!-- Custom CSS -->
        <style>
            /* Add your custom CSS styles here */
            .btn-custom {
                background-color: #007bff;
                border-color: #007bff;
            }

            .btn-custom:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }
            .card-header.text-center {
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: brown;
            }

        </style>
    </head>
    <body>
        <%@include file="panner.jsp" %>
        <!-- Body -->
        <c:if test="${deleteDone ne null}">
                    <h4 class="text-center">${deleteDone}</h4>
                </c:if>
        <div class="container-fluid pt-5" id="product">
            <div class="row px-xl-5">
                <!-- Cart Start -->
                <div class="container-fluid pt-5">
                    <div class="row px-xl-5">
                        <c:if test="${showBill eq null}">
                            <div class="col-lg-8 table-responsive mb-5">

                                <table class="table table-bordered text-center mb-0">
                                    <thead class="bg-secondary text-dark">
                                        <tr>
                                            <th style="background-color: #bfd1ec">ID</th>
                                            <th style="background-color: #bfd1ec">Product Name</th>
                                            <th style="background-color: #bfd1ec">Price</th>
                                            <th style="background-color: #bfd1ec">Quantity</th>
                                            <th style="background-color: #bfd1ec">Total</th>
                                            <th style="background-color: #bfd1ec">Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody class="align-middle">
                                        <% double total_raw = 0;
                                            java.util.Enumeration enms = session.getAttributeNames();
                                            while (enms.hasMoreElements()) {
                                                String id = enms.nextElement().toString();
                                                if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                                                    CartItem cartItem = (CartItem) session.getAttribute(id); 
                                                    Product product = cartItem.getProduct();
                                                    int quantity = cartItem.getQuantity();
                                        %>
                                    <form action="cart" id="add-cart">
                                        <input type="hidden" name="service" value="update"/>
                                    </form>
                                    <tr>
                                        <!-- ProductID -->
                                        <td class="align-middle"><%= product.getId()%></td>
                                        <!-- ProductName -->
                                        <td class="align-middle">
                                            <img src="<%= product.getImage_url()%>" alt="<%= product.getName()%>" style="width: 50px" />
                                            <%= product.getName()%>
                                        </td>
                                        <!-- ProductPrice -->
                                        <td class="align-middle">$<%= product.getPrice()%></td>
                                        <!-- Quantity -->
                                        <td class="align-middle">
                                            <div class="input-group quantity mx-auto" style="width: 100px" >
                                                <input onchange="this.form.submit()" style="background-color: #bfd1ec" type="number" class="form-control form-control-sm  text-center" value="<%= quantity%>" form="add-cart" name="p<%= id%>" min="0"/>
                                            </div>
                                        </td>
                                        <!-- SubTotal -->
                                        <td class="align-middle">$<%= Math.round((product.getPrice() * quantity) * 10) / 10.0 %></td>
                                        <!-- Remove -->
                                        <td class="align-middle">
                                            <a href="cart?service=removeItem&id=<%= id%>" class="btn btn-sm btn-danger">
                                                <i class="bi bi-trash"></i> 
                                            </a>
                                        </td>
                                    </tr>
                                    <% total_raw += (product.getPrice() * quantity);
                                        }
                                    }
                                    DecimalFormat df = new DecimalFormat("#.00");
                                    String total = df.format(total_raw);
                                    %>
                                    </tbody>
                                </table>

                                <div class="row">
                                    <div class="col-md-6">
                                        <button style="background-color: #b6effb; border: none"class="btn btn-block btn-custom my-3 py-3" onclick="document.getElementById('add-cart').submit();">
                                            Update Cart
                                        </button>
                                    </div>
                                    <div class="col-md-6 d-flex justify-content-end">
                                        <a href="cart?service=removeAll" class="btn btn-block btn-danger my-3 py-3">
                                            Remove all
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <%--bill here--%>
                            <div class="col-lg-4">
                                <div class="card border-secondary mb-5">
                                    <div style="background-color: #bfd1ec" class="card-header  border-0 text-center">
                                        <h4  class="font-weight-semi-bold m-0">Cart Summary</h4>
                                    </div>

                                    <div class="card-body">
                                        <div class="d-flex justify-content-between mb-3 pt-1">
                                            <h6 class="font-weight-medium">Subtotal</h6>
                                            <h6 class="font-weight-medium">$<%= total%></h6>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <h6 class="font-weight-medium">Shipping</h6>
                                            <h6 class="font-weight-medium">$0</h6>
                                        </div>
                                    </div>
                                    <div class="card-footer border-secondary bg-transparent">
                                        <div class="d-flex justify-content-between mt-2">
                                            <h5 class="font-weight-bold">Total</h5>
                                            <h5 class="font-weight-bold">$<%= total%></h5>
                                        </div>
                                        <a style="background-color: #b6effb; border: none"href="cart?service=checkOut" class="btn btn-block btn-custom my-3 py-3">
                                            Checkout
                                        </a>
                                    </div>
                                    <c:if test="${checkOutDone ne null}">
                                        <div style="background-color: #99ffff" class="card-header border-0 text-center">
                                            Checkout Done! See <span style="margin: 0 2px;">your</span><a href="cart?service=showBill&billId=${BillId}"/> <span style="margin: 0 2px;">Bill</span></a> here
                                        </div>
<!--                                        <div style="background-color: #99ffff" class="card-header border-0 text-center">
                                            Don't want to buy? <span style="margin: 0 2px;">your</span><a href="cart?service=delete&billId=${BillId}"/> <span style="margin: 0 2px;">Click</span></a> here
                                        </div>-->
                                    </c:if>

                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
                <!-- Cart End -->
                <!--show bill detail--> 
                <c:if test="${deleteDone ne null}">
                    <h4 class="text-center">${deleteDone}</h4>
                </c:if>
                <c:if test="${showBill ne null}">

                    <div class="col-lg-8 table-responsive mb-5">
                        <h1 class="font-weight-semi-bold text-uppercase mb-3 text-center">
                            Your Bill Here! 
                        </h1>
<!--                        <h6>Don't want to buy?<a href="cart?service=delete&billId=120">Click here</a></h6>-->

                        <table class="table table-bordered text-center mb-0">
                            <thead class="bg-secondary text-dark">
                                <tr>
                                    <th>Created Date</th>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>SubTotal</th>
                                </tr>
                            </thead>
                            <tbody class="align-middle">
                                <c:set var="total" value="0" />
                                <c:forEach var="billDetail" items="${billDetails}">
                                    <tr>
                                        <td class="align-middle">${billDetail.created_date}</td>
                                        <td class="align-middle">
                                            <img src="${billDetail.image_url}" alt="" style="width: 50px" />
                                            ${billDetail.productName}
                                        </td>
                                        <td class="align-middle">${billDetail.productQuantity}</td>
                                        <td class="align-middle">${Math.round(billDetail.subTotal)*1.0}</td>
                                    </tr>
                                    <c:set var="subtotal" value="${billDetail.subTotal}" />
                                    <c:set var="total" value="${total + subtotal}" />
                                    
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="col-lg-4" style="transform: translateY(65px)">
                        <div class="card border-secondary mb-5">
                            <div class="card-header bg-secondary border-0">
                                <h4 class="font-weight-semi-bold m-0">Cart Summary</h4>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-3 pt-1">
                                    <h6 class="font-weight-medium">Subtotal</h6>
                                    <h6 class="font-weight-medium">$${Math.round(total)*1.0}</h6>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <h6 class="font-weight-medium">Shipping</h6>
                                    <h6 class="font-weight-medium">$0</h6>
                                </div>
                            </div>
                            <div class="card-footer border-secondary bg-transparent">
                                <div class="d-flex justify-content-between mt-2">
                                    <h5 class="font-weight-bold">Total</h5>
                                    <h5 class="font-weight-bold">$${Math.round(total)*1.0}</h5>
                                </div>
                            </div>

                        </div>
                    </div>

                </c:if>
            </div>
        </div>


        <%@include file="footer.jsp" %>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
