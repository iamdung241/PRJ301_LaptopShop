/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bill;
import model.BillDetail;
import model.BillDetailForAdmin;
import model.Order;
import model.Product;
import model.User;

/**
 *
 * @author Admin
 */
public class BillDAO extends DBContext {

    public int insert(Order order, User user, String status) {
        PreparedStatement stm = null;
        ResultSet generatedKeys = null;
        int insertedId = -1; // Giá trị mặc định nếu không có ID được chèn

        String sql = "INSERT INTO [dbo].[bill]\n"
                + "           ([created_date]\n"
                + "           ,[status]\n"
                + "           ,[order_id]\n"
                + "           ,[user_id])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?)";
        try {
            stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setDate(1, order.getCreated_date());
            stm.setString(2, status);
            stm.setInt(3, order.getId());
            stm.setInt(4, user.getId());
            int affectedRows = stm.executeUpdate();

            if (affectedRows > 0) {
                generatedKeys = stm.getGeneratedKeys();
                if (generatedKeys.next()) {
                    insertedId = generatedKeys.getInt(1); // Lấy giá trị ID của bản ghi vừa chèn
                }
            }

            //System.out.println("Insert OK");
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return insertedId;
    }

    public void updateStatus(String status, int billId) {
        PreparedStatement stm = null;

        String sql = "UPDATE [dbo].[bill]\n"
                + "   SET [status] = ?\n"
                + " WHERE id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, billId);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Vector<BillDetail> showBillDetail(int billId) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<BillDetail> billDetails = new Vector<>();

        String sql = "select b.id, u.fullname as [CustomerName], b.created_date as [CreatedDate], p.[name] as [ProductName],\n"
                + "image_url, product_quantity as [Quantity], p.price, (p.price * product_quantity) as SubTotal from [bill] b\n"
                + "join [user] u on u.id = b.[user_id]\n"
                + "join [order_detail] od on od.order_id = b.order_id\n"
                + "join [product] p on p.id = od.product_id\n"
                + "where b.id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, billId);

            rs = stm.executeQuery();

            while (rs.next()) {
                BillDetail billDetail = new BillDetail();
                billDetail.setId(rs.getInt("id"));
                billDetail.setCustomerName(rs.getString("CustomerName"));
                billDetail.setCreated_date(rs.getDate("CreatedDate"));
                billDetail.setProductName(rs.getString("ProductName"));
                billDetail.setImage_url(rs.getString("image_url"));
                billDetail.setProductQuantity(rs.getInt("Quantity"));
                billDetail.setPrice(rs.getDouble("price"));
                billDetail.setSubTotal(rs.getDouble("SubTotal"));

                billDetails.add(billDetail);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return billDetails;
    }

    public Vector<BillDetailForAdmin> showBillDetailForAdmin() {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<BillDetailForAdmin> billDetailForAdmins = new Vector<>();

        String sql = "select b.id, u.fullname as [Customer Name], b.created_date,\n"
                + "u.address, u.email, u.phone,\n"
                + "SUM(price * product_quantity) as [Total], b.[status] from [bill] b\n"
                + "join [order_detail] od on od.order_id = b.order_id\n"
                + "join [user] u on u.id = b.[user_id]\n"
                + "group by b.id, u.fullname , b.created_date, b.[status], u.address, u.email, u.phone";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            while (rs.next()) {
                BillDetailForAdmin bdfa = new BillDetailForAdmin();
                bdfa.setId(rs.getInt("id"));
                bdfa.setCustomerName(rs.getString("Customer Name"));
                bdfa.setCreated_date(rs.getDate("created_date"));
                bdfa.setAddress(rs.getString("address"));
                bdfa.setEmail(rs.getString("email"));
                bdfa.setPhone(rs.getString("phone"));
                bdfa.setTotal(rs.getDouble("Total"));
                bdfa.setStatus(rs.getString("status"));

                billDetailForAdmins.add(bdfa);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return billDetailForAdmins;
    }

    public Vector<BillDetailForAdmin> showBillDetailForUser(int userID) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<BillDetailForAdmin> billDetailForAdmins = new Vector<>();

        String sql = "SELECT  b.id,b.created_date,u.address,u.email,u.phone,\n"
                + "SUM(price * product_quantity) AS \"Total\"\n"
                + "FROM bill b\n"
                + "JOIN  order_detail od ON od.order_id = b.order_id\n"
                + "JOIN [user] u ON u.id = b.user_id\n"
                + "where u.id=?\n"
                + "GROUP BY  b.id, u.fullname, b.created_date, b.status, \n"
                + "    u.address, u.email, u.phone;";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            stm.setInt(1, userID);

            while (rs.next()) {
                BillDetailForAdmin bdfa = new BillDetailForAdmin();
                bdfa.setId(rs.getInt("id"));
                bdfa.setCustomerName(rs.getString("Customer Name"));
                bdfa.setCreated_date(rs.getDate("created_date"));
                bdfa.setAddress(rs.getString("address"));
                bdfa.setEmail(rs.getString("email"));
                bdfa.setPhone(rs.getString("phone"));
                bdfa.setTotal(rs.getDouble("Total"));
                bdfa.setStatus(rs.getString("status"));

                billDetailForAdmins.add(bdfa);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return billDetailForAdmins;
    }

    public Vector<BillDetailForAdmin> getBillByAddress(String s) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<BillDetailForAdmin> billDetailForAdmins = new Vector<>();
        String sql = "SELECT b.id, u.fullname AS \"Customer Name\", b.created_date,\n"
                + "    u.address, u.email, u.phone,SUM(price * product_quantity) AS \"Total\",  b.status \n"
                + "FROM bill b\n"
                + "JOIN order_detail od ON od.order_id = b.order_id\n"
                + "JOIN [user] u ON u.id = b.user_id\n"
                + "WHERE u.address LIKE ?\n"
                + "GROUP BY b.id, u.fullname,  b.created_date, b.status, u.address, u.email, u.phone";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + s + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                BillDetailForAdmin bdfa = new BillDetailForAdmin();
                bdfa.setId(rs.getInt("id"));
                bdfa.setCustomerName(rs.getString("Customer Name"));
                bdfa.setCreated_date(rs.getDate("created_date"));
                bdfa.setAddress(rs.getString("address"));
                bdfa.setEmail(rs.getString("email"));
                bdfa.setPhone(rs.getString("phone"));
                bdfa.setTotal(rs.getDouble("Total"));
                bdfa.setStatus(rs.getString("status"));

                billDetailForAdmins.add(bdfa);

            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Vector<BillDetailForAdmin> showBillDetailForAdminFilterByStatus(String status) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<BillDetailForAdmin> billDetailForAdmins = new Vector<>();

        String sql = "select b.id, u.fullname as [Customer Name], b.created_date,\n"
                + "u.address, u.email, u.phone,\n"
                + "SUM(price * product_quantity) as [Total], b.[status] from [bill] b\n"
                + "join [order_detail] od on od.order_id = b.order_id\n"
                + "join [user] u on u.id = b.[user_id]\n"
                + "where b.status = ?\n"
                + "group by b.id, u.fullname , b.created_date, b.[status], u.address, u.email, u.phone";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            rs = stm.executeQuery();

            while (rs.next()) {
                BillDetailForAdmin bdfa = new BillDetailForAdmin();
                bdfa.setId(rs.getInt("id"));
                bdfa.setCustomerName(rs.getString("Customer Name"));
                bdfa.setCreated_date(rs.getDate("created_date"));
                bdfa.setAddress(rs.getString("address"));
                bdfa.setEmail(rs.getString("email"));
                bdfa.setPhone(rs.getString("phone"));
                bdfa.setTotal(rs.getDouble("Total"));
                bdfa.setStatus(rs.getString("status"));

                billDetailForAdmins.add(bdfa);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return billDetailForAdmins;
    }

//    public Bill getBillById(int billId) {
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//        Bill bill = null;
//        String sql = "select * from [order] where id = ?";
//        try {
//            stm = connection.prepareStatement(sql);
//            stm.setInt(1, billId);
//            rs = stm.executeQuery();
//            while (rs.next()) {
//                int id = rs.getInt("id");
//                String status = rs.getString("status");
//
//                bill = new Bill(id, status);
//            }
//            return bill;
//
//        } catch (SQLException ex) {
//            Logger.getLogger(OrderDAO.class
//                    .getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
    public int deleteBill(int id) {
        int n = 0;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            stm = connection.prepareStatement("SELECT * FROM bill WHERE id = ? AND status = 'wait'");
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                stm = connection.prepareStatement("DELETE FROM bill WHERE id = ?");
                stm.setInt(1, id);
                n = stm.executeUpdate();
            } else {
                n = -1;
            }
        } catch (SQLException ex) {
            n = -1;
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

}
