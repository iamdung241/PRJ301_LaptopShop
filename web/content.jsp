<%-- 
    Document   : content
    Created on : Jan 30, 2024, 2:15:55 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Products</title>
        <style>
            .product-card {
                transition: transform 0.3s ease;
            }

            .product-card:hover {
                transform: scale(1.05);
            }
        </style>
    </head>
    <body>


        <!-- Product list -->
        <div class="row col-md-10 gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
            <c:forEach items="${requestScope.products}" var="p">
                <!-- Product start -->
                <div class="col mb-5">
                    <div class="card h-100 product-card">
                        <!-- Product image-->
                        <img 
                            class="card-img-top"
                            src="${p.image_url}"
                            alt="..."
                            />
                        <!-- Product details-->
                        <div class="card-body p-4">
                            <div class="text-center">
                                <!-- Product name-->
                                <h5 class="fw-bolder">${p.name}</h5>
                                <!-- Product price -->
                                $ ${p.price}
                            </div>
                        </div>
                        <!-- Product actions-->
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                            <div class="text-center">
                                <a class="btn btn-outline-dark mt-auto" href="cart?service=addToCart&productId=${p.id}"
                                   >Add to Cart</a
                                >
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Product end -->  
            </c:forEach>

        </div>
    </body>
</html>
