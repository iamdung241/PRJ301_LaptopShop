/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.BrandDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Vector;
import model.Brand;
import model.Product;

/**
 *
 * @author Admin
 */
public class CustomerController extends HttpServlet {

    private final String MAIN_URL = "index.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String service = req.getParameter("service");

        Vector<Brand> brands = (new BrandDAO()).getAll();

        if (service == null) {
            service = "listAll";
        }

        if (service.equals("listAll")) {
            Vector<Product> products = (new ProductDAO()).getAll();

            req.setAttribute("brands", brands);
            req.setAttribute("products", products);
            req.getRequestDispatcher(MAIN_URL).forward(req, resp);
        }

        if (service.equals("search")) {
            String keyword = req.getParameter("keyword");
            Vector<Product> products = (new ProductDAO()).getProductsByKeywords(keyword);

            req.setAttribute("brands", brands);
            req.setAttribute("products", products);
            req.getRequestDispatcher(MAIN_URL).forward(req, resp);
        }

        if (service.equals("filter-brand")) {
            int brandId = Integer.parseInt(req.getParameter("brand-id"));
            Vector<Product> products = (new ProductDAO()).getProductsByBrand(brandId);

            req.setAttribute("brands", brands);
            req.setAttribute("products", products);
            req.getRequestDispatcher(MAIN_URL).forward(req, resp);
        }
        if (service.equals("filter-price")) {
            int priceId = Integer.parseInt(req.getParameter("price-id"));
            //Vector<Product> products = (new ProductDAO()).getProductsByPrice(priceId);
            if (priceId == 1) {
                Vector<Product> products = (new ProductDAO()).getProductsByPrice(500, 700);
                req.setAttribute("brands", brands);
                req.setAttribute("products", products);
                req.getRequestDispatcher(MAIN_URL).forward(req, resp);
            }
            if (priceId == 2) {
                Vector<Product> products = (new ProductDAO()).getProductsByPrice(700, 1000);
                req.setAttribute("brands", brands);
                req.setAttribute("products", products);
                req.getRequestDispatcher(MAIN_URL).forward(req, resp);
            }
            if (priceId == 3) {
                Vector<Product> products = (new ProductDAO()).getProductsByPrice(1000, 1500);
                req.setAttribute("brands", brands);
                req.setAttribute("products", products);
                req.getRequestDispatcher(MAIN_URL).forward(req, resp);
            }
            if (priceId == 4) {
                Vector<Product> products = (new ProductDAO()).getProductsByPrice(1500, Double.MAX_VALUE);
                req.setAttribute("brands", brands);
                req.setAttribute("products", products);
                req.getRequestDispatcher(MAIN_URL).forward(req, resp);
            }
        }
        if (service.equals("sort")) {
            int priceId = Integer.parseInt(req.getParameter("sortID"));
            //Vector<Product> products = (new ProductDAO()).getProductsByPrice(priceId);
            if (priceId == 0) {
                Vector<Product> products = (new ProductDAO()).getProductsSortPriceDESC();
                req.setAttribute("brands", brands);
                req.setAttribute("products", products);
                req.getRequestDispatcher(MAIN_URL).forward(req, resp);
            }
            if (priceId == 1) {
                Vector<Product> products = (new ProductDAO()).getProductsSortPriceASC();
                req.setAttribute("brands", brands);
                req.setAttribute("products", products);
                req.getRequestDispatcher(MAIN_URL).forward(req, resp);
            }  
        }
        
    }
}
