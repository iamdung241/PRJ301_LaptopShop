/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

//import dal.BillDAO;
//import dal.OrderDAO;
//import dal.OrderDetailDAO;
import dal.BillDAO;
import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.Enumeration;
import java.util.Vector;
import model.Bill;
import model.BillDetail;
import model.CartItem;
import model.Order;
import model.Product;
import model.User;

/**
 *
 * @author Admin
 */
public class CartController extends HttpServlet {

    private final String CART_URL = "cart.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String service = req.getParameter("service");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login");
        } else {

            if (service.equals("showCart")) {
                resp.sendRedirect(CART_URL);
            }

            if (service.equals("addToCart")) {
                Integer productId = Integer.parseInt(req.getParameter("productId"));
                Product product = (new ProductDAO()).getProductsById(productId);
                if (session.getAttribute(productId.toString()) == null) {
                    CartItem cartItem = new CartItem(product, 1);
                    session.setAttribute(productId.toString(), cartItem);
                } else {
                    int newQuantity = ((CartItem) session.getAttribute(productId.toString())).getQuantity() + 1;
                    CartItem cartItem = new CartItem(product, newQuantity);
                    session.setAttribute(productId.toString(), cartItem);
                }

                resp.sendRedirect("customer");
            }

            if (service.equals("removeItem")) {
                //delete one item 
                String id = req.getParameter("id");
                session.removeAttribute(id);
                resp.sendRedirect(CART_URL);
                //delete item by quantity - 1
                //checkfirst
//            String id = req.getParameter("id");
//            CartItem cartItem = (CartItem) session.getAttribute(id);
//            if (cartItem.getQuantity() == 1) {
//                session.removeAttribute(id);
//            } else {//product existProductCart) session.getAttribute(id);
//                cartItem.setQuantity(cartItem.getQuantity() - 1);
//                session.setAttribute(id, cartItem);
//            }
//            //select view
//            RequestDispatcher dispth = req.getRequestDispatcher(CART_URL);
//            //run, show
//            dispth.forward(req, resp);

            }

            if (service.equals("removeAll")) {
                Enumeration en = session.getAttributeNames();
                while (en.hasMoreElements()) {
                    String id = en.nextElement().toString();
                    if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                        session.removeAttribute(id);
                    }
                }
                resp.sendRedirect(CART_URL);

            }

            if (service.equals("update")) {
                Enumeration em = session.getAttributeNames();

                while (em.hasMoreElements()) {
                    String id = em.nextElement().toString(); //get key

                    if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                        int quantity = Integer.parseInt(req.getParameter("p" + id));
                        CartItem cartItem = (CartItem) session.getAttribute(id);
                        cartItem.setQuantity(quantity);
                        session.setAttribute(id, cartItem);
                    }
                }
                resp.sendRedirect(CART_URL);
            }

            if (service.equals("checkOut")) {
                java.util.Date date = new java.util.Date();
                Date currentDate = new Date(date.getTime());
                //insert order
                Order order = new Order(currentDate, user);
                int orderId = (new OrderDAO()).insert(order, user);
                //insert order detail
                Enumeration em = session.getAttributeNames();

                while (em.hasMoreElements()) {
                    String id = em.nextElement().toString(); //get key

                    if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                        CartItem cartItem = (CartItem) session.getAttribute(id);
                        (new OrderDetailDAO()).insert((new OrderDAO()).getOrdersById(orderId), cartItem);
                    }
                }

                //insert bill
                int billId = (new BillDAO()).insert((new OrderDAO()).getOrdersById(orderId), user, "wait");

                //remove all products in cart
                Enumeration en = session.getAttributeNames();
                while (en.hasMoreElements()) {
                    String id = en.nextElement().toString();
                    if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                        session.removeAttribute(id);
                    }
                }

                req.setAttribute("checkOutDone", "checkOutDone");
                req.setAttribute("BillId", billId);
                req.getRequestDispatcher(CART_URL).forward(req, resp);
            }

            if (service.equals("showBill")) {
                int billId = Integer.parseInt(req.getParameter("billId"));

                Vector<BillDetail> billDetails = (new BillDAO()).showBillDetail(billId);
                req.setAttribute("billDetails", billDetails);
                req.setAttribute("showBill", "showBill");
                req.getRequestDispatcher(CART_URL).forward(req, resp);
            }
            if (service.equals("delete")) {
                int billId = Integer.parseInt(req.getParameter("billId"));
                BillDAO dao = new BillDAO();
                int n = dao.deleteBill(billId);

                if (n == 1) {
                    req.setAttribute("deleteDone", "Delete order (Id = " + billId + ") done!");
                } else {
                    req.setAttribute("deleteDone", "Failed to delete order (Id  = " + billId + ") because this bill is in processing.");
                }
                req.getRequestDispatcher(CART_URL).forward(req, resp);
            }

        }
    }

}
