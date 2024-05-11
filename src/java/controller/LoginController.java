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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;

/**
 *
 * @author Admin
 */
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = (new UserDAO()).login(username, password);

        //Login flow
        if (user == null) {
            req.setAttribute("usernameOrPasswordWrong", "Username or Password is invalid!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        } else if (user.getRole_id() == 0) {
            session.setAttribute("user", user);
//            req.getRequestDispatcher("indexAdmin.jsp").forward(req, resp);
            resp.sendRedirect("indexAdmin.jsp");

        } else if (user.getRole_id() == 1) {
            session.setAttribute("user", user);
//            req.getRequestDispatcher("customer").forward(req, resp);
            resp.sendRedirect("customer");
        } else if (user.getBanned() == 0) {
            //resp.sendRedirect("AccessDenied.jsp");
            req.getRequestDispatcher("accessDenied.jsp").forward(req, resp);
            session.removeAttribute("user");
        }
    }

}
