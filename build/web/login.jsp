<%-- 
    Document   : login
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
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            #login-form-wrap {
                background-color: #fff;
                width: 350px;
                border-radius: 8px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                padding: 40px;
                text-align: center;
            }

            h2 {
                font-weight: bold;
                color: #333;
                margin-bottom: 20px;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 12px;
                margin: 8px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 16px;
            }

            input[type="submit"] {
                background-color: #007bff;
                color: #fff;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            #create-account-wrap {
                margin-top: 20px;
                font-size: 14px;
                color: #666;
            }

            #create-account-wrap a {
                color: #007bff;
                text-decoration: none;
            }

            #create-account-wrap a:hover {
                text-decoration: underline;
            }

            .error-message {
                color: red;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <div id="login-form-wrap">
            <h2>EShop Login</h2>
            <form id="login-form" action="login" method="POST">
                <p>
                    <input type="text" id="username" name="username" placeholder="Username" required>
                </p>
                <p>
                    <input type="password" id="password" name="password" placeholder="Password" required>
                </p>

                <p class="error-message">${requestScope.usernameOrPasswordWrong}</p>

                <p>
                    <input type="submit" id="login" value="Login">
                </p>
            </form>
            <div id="create-account-wrap">
                <p>Not a member? <a href="register.jsp">Create Account</a></p>
            </div><!--create-account-wrap-->
        </div><!--login-form-wrap-->
    </body>
</html>
