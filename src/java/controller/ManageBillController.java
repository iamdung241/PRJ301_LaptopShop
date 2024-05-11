/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.BillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Vector;
import model.Bill;
import model.BillDetail;
import model.BillDetailForAdmin;

/**
 *
 * @author Admin
 */
public class ManageBillController extends HttpServlet {

    private final String ADMIN_URL = "indexAdmin.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String service = req.getParameter("service");
        req.setAttribute("manageBill", "Yes");
        if (service == null) {
            service = "listAll";
        }

        if (service.equals("listAll")) {
            Vector<BillDetailForAdmin> billDetailForAdmins = (new BillDAO()).showBillDetailForAdmin();

            req.setAttribute("billDetailForAdmins", billDetailForAdmins);
            req.getRequestDispatcher(ADMIN_URL).forward(req, resp);
        }
        
        if (service.equals("showDetailBill")) {
            int billId = Integer.parseInt(req.getParameter("billId"));
            String status = req.getParameter("status");

            Vector<BillDetail> billDetails = (new BillDAO()).showBillDetail(billId);

            req.setAttribute("status", status);
            req.setAttribute("billDetails", billDetails);

            req.getRequestDispatcher(ADMIN_URL).forward(req, resp);
        }

        if (service.startsWith("changeStatusTo")) {
            int billId = Integer.parseInt(req.getParameter("billId"));
            String statusInShowDetail = req.getParameter("statusInShowDetail");
            //check if status is done

            if (statusInShowDetail.equals("done")) {
                req.setAttribute("changeStatus", "Status of this bill is done, you can not change it!");
            } else {
                if (service.endsWith("Wait")) {
                    (new BillDAO()).updateStatus("wait", billId);
                    req.setAttribute("changeStatus", "Admin change status of Bill (ID = " + billId + ") to Wait");
                }

                if (service.endsWith("Process")) {
                    (new BillDAO()).updateStatus("process", billId);
                    req.setAttribute("changeStatus", "Admin change status of Bill (ID = " + billId + ") to Process");

                }

                if (service.endsWith("Done")) {
                    (new BillDAO()).updateStatus("done", billId);
                    req.setAttribute("changeStatus", "Admin change status of Bill (ID = " + billId + ") to Done");

                }

            }
            req.getRequestDispatcher(ADMIN_URL).forward(req, resp);
        }

        if (service.equals("searchByAddress")) {
            String keywords = req.getParameter("keywords");

            req.setAttribute("keywords", keywords);
            req.setAttribute("manageBill", "Yes");

            Vector<BillDetailForAdmin> bill = (new BillDAO()).getBillByAddress(keywords);

            if (bill == null || bill.isEmpty()) {
                req.setAttribute("notFoundBill", "Your keywords do not match with any Address");
                bill = (new BillDAO()).showBillDetailForAdmin();
            }

            req.setAttribute("allBill", bill);
            req.getRequestDispatcher(ADMIN_URL).forward(req, resp);
        }
        if (service.equals("filterStatus")) {
            String filter = req.getParameter("filter");
            Vector<BillDetailForAdmin> bdfas = new Vector<>();
            if (filter.equals("all")) {
                bdfas = (new BillDAO()).showBillDetailForAdmin();
            } else {
                bdfas = (new BillDAO()).showBillDetailForAdminFilterByStatus(filter);
            }
            req.setAttribute("billDetailForAdmins", bdfas);
            req.getRequestDispatcher(ADMIN_URL).forward(req, resp);
        }

    }

}
