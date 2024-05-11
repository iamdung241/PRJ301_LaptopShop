<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.CartItem, model.Product, java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header</title>
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="#!">HE182307 Ta Tuan Dung</a>
                <c:if test="${sessionScope.user ne null}">
                    <div class="d-flex align-items-center"> 
                        <a class="navbar-brand" href="#!">Welcome ${user.fullname}</a>
                        <a class="btn btn-outline-dark ms-auto" href="logout">Logout</a>
                    </div>
                </c:if>
                <c:if test="${sessionScope.user eq null}">
                    <div class="d-flex align-items-center">
                        <a class="btn btn-outline-dark" href="login.jsp">Login</a>
                        <a class="btn btn-outline-dark ms-2" href="register.jsp">Register</a>
                    </div>
                </c:if>
            </div>
        </nav>

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <c:if test="${sessionScope.user ne null and sessionScope.user.role_id == 1}">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a  style="color: graytext; font-weight: bolder;font-size: 18px" class="nav-link" href="customer">Home</a>
                        </li>
                        <li style="color: graytext; font-weight: bolder;font-size: 18px"class="nav-item">
                            <a class="nav-link" href="customer">Products</a>
                        </li>
                        <li style="color: graytext; font-weight: bolder;font-size: 18px"class="nav-item">
                            <a class="nav-link" href="#footer">Contacts</a>
                        </li>
                        <li style="color: graytext; font-weight: bolder;font-size: 18px"class="nav-item">
                            <a class="nav-link" href="orderOfUser.jsp">Show all orders</a>
                        </li>
                    </ul>

                    <a href="cart?service=showCart" class="btn btn-outline-dark">
                        <i class="bi-cart-fill me-1"></i>
                        Cart
                        <span class="badge bg-dark text-white ms-1 rounded-pill">
                            <%
                            int numberProductsInCart = 0;
                            java.util.Enumeration ens = session.getAttributeNames();

                                    while (ens.hasMoreElements()) {

                                            String id = ens.nextElement().toString();

                                            if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                                                //numberProductsInCart++;
                                            
                                                CartItem cartItem = (CartItem) session.getAttribute(id); 
                                                Product product = cartItem.getProduct();
                                                int quantity = cartItem.getQuantity();
                                                numberProductsInCart += quantity;
                                        
                                }
                            }
                            session.setAttribute("numberProductsInCart", numberProductsInCart);
                            %>

                            ${sessionScope.numberProductsInCart}
                        </span>
                    </a>
                </c:if>
            </div>
        </nav>
        <!-- Header-->
        <header style="background-color: #3f51b5;" class="py-5"> 
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Discover Amazing Deals</h1>
                    <p class="lead fw-normal text-white-50 mb-0">
                        With our unbeatable laptop sale offers
                    </p>
                </div>
            </div>
        </header>
    </body>
</html>
