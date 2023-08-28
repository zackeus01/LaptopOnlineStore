/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Context.*;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Dinh Nguyen
 */
public class OrderDetailDAO extends DBContext {

    ResultSet rs;
    public void InsertOrder(Order order, List<OrderDetail> orderDetail) {
        String sqlOrder = "INSERT INTO [Orderr] ([OrderID], [AccountID], [Total], [OrderDate], [Status]) VALUES (?, ?, ?, ?, ?)";
        String sqlOrderDetail = "INSERT INTO [OrderDetails] ([OrderID], [FullName], [address], [email], [productID], [productName], [Seri], [quantity], [price], [Phone]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection con = null; // Thêm khai báo biến con ở đây

        try {
            con = connection;
            con.setAutoCommit(false);

            try ( PreparedStatement psOrder = con.prepareStatement(sqlOrder);  PreparedStatement psOrderDetail = con.prepareStatement(sqlOrderDetail)) {
                psOrder.setInt(1, order.getOrderId());
                psOrder.setInt(2, order.getCustomerId());
                psOrder.setDouble(3, order.getTotal());
                psOrder.setDate(4, order.getOrderDate());
                psOrder.setInt(5, order.getStatus());

                psOrder.executeUpdate();

                for (OrderDetail o : orderDetail) {
                    psOrderDetail.setInt(1, o.getOrderID());
                    psOrderDetail.setString(2, o.getFullname());
                    psOrderDetail.setString(3, o.getAddres());
                    psOrderDetail.setString(4, o.getEmail());
                    psOrderDetail.setInt(5, o.getProductID());
                    psOrderDetail.setString(6, o.getProductName());
                    psOrderDetail.setString(7, o.getSeri());
                    psOrderDetail.setInt(8, o.getQuantity());
                    psOrderDetail.setDouble(9, o.getPrice());
                    psOrderDetail.setString(10, o.getPhone());

                    psOrderDetail.executeUpdate();
                }
            }

            con.commit();
        } catch (SQLException e) {
            e.printStackTrace();

            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public OrderDetail getOrderBySeri(String seri) {
        OrderDetail orders = new OrderDetail();
        String sql = "SELECT OrderDetailID, OrderID, FullName, Address, Email, ProductID, ProductName, Seri, Quantity, Price, Phone FROM OrderDetails WHERE Seri = ?";
        Connection con = null;
        try {
            con = connection;
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, seri);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int orderDetailID = rs.getInt("OrderDetailID");
                int orderID = rs.getInt("OrderID");
                String fullName = rs.getString("FullName");
                String address = rs.getString("Address");
                String email = rs.getString("Email");
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String serialNumber = rs.getString("Seri");
                int quantity = rs.getInt("Quantity");
                double price = rs.getFloat("Price");
                String phone = rs.getString("Phone");

                OrderDetail o = new OrderDetail(orderDetailID, orderID, productID, quantity, fullName, address, email, productName, seri, phone, price);
                orders = o;
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    public int countRecordsByProductID(int productID) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS RecordCount FROM OrderDetails WHERE productID = ?";
        Connection con = null;

        try {
            con = connection;
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, productID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("RecordCount");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<MyOrder> getOrderDetail(int accountId) {
        List<MyOrder> t = new ArrayList<>();
        String xSql = "select P.images, OD.productName,O.Status, OD.address, OD.quantity, OD.price, P.Seri from OrderDetails OD join Product P\n"
                + "on P.Seri = OD.Seri join Orderr O on O.OrderID=OD.OrderID\n"
                + "where O.AccountID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(xSql);
            ps.setInt(1, accountId);
            rs = ps.executeQuery();
            String img, pName, address;
            int quantity, status;
            float price;
            String seri;
            MyOrder myorder;
            while (rs.next()) {
                img = rs.getString(1);
                pName = rs.getString(2);
                status = rs.getInt(3);
                address = rs.getString(4);
                quantity = rs.getInt(5);
                price = rs.getFloat(6);
                seri = rs.getString(7);
                myorder = new MyOrder(img, pName, address, quantity, status, price, seri);
                t.add(myorder);
            }

        } catch (Exception e) {
            System.out.println("getOrderDetail " + e.getMessage());
        }
        return t;
    }

    public void deleteOrderDetails(String seri) {
        String sql = "delete from OrderDetails where Seri = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, seri);
            ps.execute();
        } catch (Exception e) {
            System.out.println("deleteOrderDetails " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        OrderDetailDAO odd = new OrderDetailDAO();
        LocalDate currentDate = LocalDate.now();

// Chuyển đổi sang java.sql.Date
        Date sqlDate = Date.valueOf(currentDate);
        Order o = new Order(122, 22, sqlDate, 33, 0);
        List<OrderDetail> list = new ArrayList<>();
        OrderDetail od = new OrderDetail(122, 3, 1, "111", "1111", "aaa", "aaa", "gfdh", "kgjg", 33.3);
        System.out.println(odd.countRecordsByProductID(1));
    }
}
