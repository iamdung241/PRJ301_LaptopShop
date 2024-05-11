/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Vector;
import model.User;

/**
 *
 * @author Admin
 */
public class RegisterController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        
        Vector<User> vector = (new UserDAO()).getAllUser();
        for (User user : vector) {
            if (user.getUsername().equals(username)) {
                req.setAttribute("existedUsername", "Username is already exists, try again!");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
            }
        }

        UserDAO dao = new UserDAO();
        User user = new User(username, password, fullname, email, phone, address, 1);
        dao.insertUser(user);
        req.setAttribute("registerSuccess", "Register Successful. Click here to Login.");
        req.getRequestDispatcher("register.jsp").forward(req, resp);
        
    }
    
}
