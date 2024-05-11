<%-- menu.jsp --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
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
    </head>
    <body>

        <!-- Filter by brand -->
        <div class="col-md-2">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Filter by Branch</h5>
                    <ul class="list-group">
                        <c:forEach items="${requestScope.brands}" var="b">
                            <a href="customer?service=filter-brand&brand-id=${b.id}" class="list-group-item">
                                ${b.name}
                            </a>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            

        </div>
        



    </body>
</html>
