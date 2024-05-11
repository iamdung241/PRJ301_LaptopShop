<%-- 
    Document   : register
    Created on : Feb 6, 2024, 5:45:12 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
        <style>
            body {
                background-color: #f5f5f5;
                font-family: "Open Sans", sans-serif;
                color: #2b3e51;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            #login-form-wrap {
                background-color: #fff;
                width: 400px;
                border-radius: 8px;
                box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.1);
                padding: 40px;
            }

            h2 {
                font-weight: bold;
                text-align: center;
                text-transform: uppercase;
                margin-bottom: 40px;
                color: #2b3e51;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 12px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 16px;
                transition: border-color 0.3s ease;
            }

            input[type="text"]:focus,
            input[type="password"]:focus {
                border-color: #3ca9e2;
            }

            input[type="submit"] {
                background-color: #3ca9e2;
                border: none;
                color: white;
                padding: 14px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                width: 100%;
            }

            input[type="submit"]:hover {
                background-color: #329dd5;
            }

            .form-footer {
                margin-top: 20px;
                text-align: center;
            }

            .form-footer a {
                color: #3ca9e2;
                text-decoration: none;
            }

            .form-footer a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div id="login-form-wrap">
            <h2>EShop Register</h2>
            <form id="login-form" action="register" method="post">
                <p>
                    <input type="text" id="username" name="username" placeholder="Username" required>
                </p>
                <c:if test="${existedUsername ne null}">
                    <p style="color: red; font-size: 1.25rem; text-align: center">${existedUsername}</p>
                </c:if>
                <p>
                    <input type="password" id="password" name="password" placeholder="Password" required>
                </p>
                <p>
                    <input type="text" id="fullname" name="fullname" placeholder="Fullname" required>
                </p>
                <p>
                    <input type="text" id="email" name="email" placeholder="Email" required>
                </p>
                <p>
                    <input type="text" id="phone" name="phone" placeholder="Phone" required>
                </p>
                <p>
                    <input type="text" id="address" name="address" placeholder="Address" required>
                </p>
                <p>
                    <input type="submit" id="register" value="Register">
                </p>
                <c:if test="${registerSuccess ne null}">
                    <p style="color: green; font-size: 1rem; text-align: center">
                        <a href="login.jsp">${registerSuccess}</a>
                    </p>
                </c:if>
            </form>
            <div class="form-footer">
                <p>Already have an account? <a href="login.jsp">Login Now</a></p>
            </div>
        </div>
    </body>
</html>


