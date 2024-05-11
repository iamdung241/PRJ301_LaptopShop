<%-- 
    Document   : index
    Created on : Feb 2, 2024, 4:10:56 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <style>
            /* CSS for menu */
            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                background-color: #f8f9fa; /* Background color */
            }

            .card-title {
                font-size: 1.2rem;
                font-weight: bold;
                color: #343a40; /* Title color */
                margin-bottom: 1.5rem;
            }

            .list-group {
                padding-left: 0; /* Loại bỏ padding mặc định của list */
            }

            .list-group-item {
                background-color: transparent;
                border: none;
                border-radius: 0;
                padding: 10px 20px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                text-decoration: none; /* Loại bỏ gạch chân */
                color: #212529; /* Màu chữ */
            }

            .list-group-item:hover {
                background-color: #e9ecef; /* Hover background color */
            }
        </style>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Laptop Shop</title>
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
            rel="stylesheet"
            />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <%@include file="panner.jsp" %>

        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <!-- Search start -->
                <div class="col mb-5 w-50 offset-md-4">
                    <form action="customer" method="GET" class="input-group">
                        <input
                            type="text"
                            name="keyword"
                            class="form-control"
                            placeholder="Search by product name"
                            style="width: 70%" <!-- Thay đổi chiều rộng của input -->

                        <button class="btn btn-outline-secondary" type="submit">
                            Search
                        </button>
                        <input type="hidden" name="service" value="search">
                    </form>
                </div>
<!--                <div class="col-md-2">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Sort by Price</h5>
                            <ul class="list-group">
                                <a style="text-decoration: none" href="customer?service=sort&sortID=0">Decrease</a>
                                <a style="text-decoration: none" href="customer?service=sort&sortID=1">Increase</a>
                            </ul>
                        </div>
                    </div>
                </div>-->

                <!-- Search end --> 

                <div class="row">
                    <%@include file="menu.jsp" %>

                    <%@include file="content.jsp" %>
                </div>
            </div>
        </section>

        <%@include file="footer.jsp" %>


        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>

