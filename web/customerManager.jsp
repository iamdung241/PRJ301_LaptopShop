<%-- 
    Document   : customerManager
    Created on : Jan 15, 2024, 1:28:41 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Customer Manager</title>
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
        <h1 class="font-weight-semi-bold text-uppercase mb-3 text-center">
            Customers Manager
        </h1>

        <!--Search customer by name-->
        <div class="d-flex align-items-center justify-content-between mb-4">
            <form action="manageCustomer" id="searchByName" class="mb-3">
                <input type="hidden" name="service" value="searchByKeywords"/> 
                <div class="input-group shadow">
                    <input 
                        type="text" 
                        class="form-control border-right-0" 
                        placeholder="Search by name" 
                        name="keywords" 
                        value="${keywords}" 
                        /> 
                    <div class="input-group-append">
                        <button class="btn btn-primary border-left-0" type="submit">
                            <i class="fa fa-search"></i>
                        </button> 
                    </div> 
                </div> 
            </form>

        </div>

        <c:if test="${notFoundCustomer ne null}">
            <h4 class="font-weight-semi-bold text-uppercase mb-3 text-center">
                ${notFoundCustomer}
            </h4>
        </c:if>
        <div class="col-lg-12 table-responsive mb-5">
            <table class="table table-bordered text-center mb-0">
                <thead class="bg-secondary text-dark">
                    <tr>
                        <th style="background-color: #bfd1ec">ID</th>
                        <th style="background-color: #bfd1ec">Username</th>
                        <th style="background-color: #bfd1ec">Password</th>
                        <th style="background-color: #bfd1ec">Fullname</th>
                        <th style="background-color: #bfd1ec">Email</th>
                        <th style="background-color: #bfd1ec">Phone</th>
                        <th style="background-color: #bfd1ec">Address</th>
                        <th style="background-color: #bfd1ec">Banned</th>
                        <th style="background-color: #bfd1ec">Ban this user?</th>
                    </tr>
                </thead>                                       
                <tbody class="align-middle">
                    <c:forEach items="${allCustomers}" var="customer">
                        <tr>
                            <td class="align-middle">${customer.id}</td>
                            <td class="align-middle">${customer.username}</td>
                            <td class="align-middle">${customer.password}</td>
                            <td class="align-middle">${customer.fullname}</td>
                            <td class="align-middle">${customer.email}</td>
                            <td class="align-middle">${customer.phone}</td>
                            <td class="align-middle">${customer.address}</td>
                            <td class="align-middle">
                                <c:if test="${customer.banned == 1}">X</c:if>
                                </td>
                                <td class="align-middle"><a href="manageCustomer?service=ban&id=${customer.id}"><button class="btn btn-sm btn-primary">
                                        <i class="fa fa-times"></i>
                                    </button></a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    </body>

</html>
