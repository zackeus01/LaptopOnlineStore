/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Context.DBContext;
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
 * @author ADMIN
 */
public class OrderDetailDAO2 extends DBContext {

    ResultSet rs;

    public OrderDetailDAO2() {

    }

    public List<OrderDetail2> getOrderDetail2() {
        List<OrderDetail2> list = new ArrayList<>();
        String xSql = "  select P.images, OD.productName, A.AccountName, O.OrderDate, OD.FullName, OD.address, OD.email, OD.phone, OD.quantity,  OD.price, O.Status, O.OrderID\n"
                + "                 from Account A join Orderr O on O.AccountID = A.AccountID\n"
                + "                 join OrderDetails OD on O.OrderID = OD.OrderID join Product P on P.Seri = OD.Seri ";
        try {
            PreparedStatement ps = connection.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail2(rs.getString("images"),
                        rs.getString("productName"),
                        rs.getString("AccountName"),
                        rs.getDate("OrderDate"),
                        rs.getString("FullName"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getInt("quantity"),
                        rs.getInt("price"),
                        rs.getInt("Status"),
                        rs.getInt("OrderID")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public OrderDetail2 getStatusByOrderID(int orderid) {
        OrderDetail2 order = new OrderDetail2();
        String sql = "select orderid, Status from  Orderr where OrderID = ?";
        Connection con = null;
        try {
            con = connection;
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, orderid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) { // Thêm điều kiện này để kiểm tra có kết quả trả về không
                int status = rs.getInt("Status"); // Sửa lại tên biến này cho rõ nghĩa
                order.setStatus(status); // Sửa lại cách gán giá trị trạng thái cho đối tượng OrderDetail
                order.setOrderID(orderid);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return order;
    }

    public void updateStatus(int orderid, int status) {
        String query = "Update Orderr\n"
                + "set Status= ?\n"
                + "where OrderID = ?";
        Connection con = null;
        try {
            con = connection;
            PreparedStatement ps = con.prepareStatement(query);
            ps = con.prepareStatement(query);
            ps.setInt(1, status);
            ps.setInt(2, orderid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Integer> getOrderIDbyDay(int day, int month, int year) {
        List<Integer> t = new ArrayList<>();
        String xSql = "SELECT OrderID FROM Orderr WHERE DAY(OrderDate) = ? AND MONTH(OrderDate) = ? AND YEAR(OrderDate) = ? ;";
        Connection con = null;
        try {
            con = connection;
            PreparedStatement ps = con.prepareStatement(xSql);
            ps.setInt(1, day);
            ps.setInt(2, month);
            ps.setInt(3, year);
            rs = ps.executeQuery();
            int orderid;
            while (rs.next()) {
                orderid = rs.getInt("OrderID");

                t.add(orderid);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public List<OrderDetail2> getOrderDetail2ByOrderID(int orderid) {
        List<OrderDetail2> list = new ArrayList<>();
        String xSql = " select P.images, OD.productName, A.AccountName, O.OrderDate, OD.FullName, OD.address, OD.email, OD.phone, OD.quantity,  OD.price, O.Status, O.OrderID\n"
                + "                               from Account A join Orderr O on O.AccountID = A.AccountID\n"
                + "                              join OrderDetails OD on O.OrderID = OD.OrderID join Product P on P.Seri = OD.Seri \n"
                + "							  where O.OrderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(xSql);
            ps.setInt(1, orderid);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail2(rs.getString("images"),
                        rs.getString("productName"),
                        rs.getString("AccountName"),
                        rs.getDate("OrderDate"),
                        rs.getString("FullName"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getInt("quantity"),
                        rs.getInt("price"),
                        rs.getInt("Status"),
                        rs.getInt("OrderID")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<OrderDetail2> getTotalbyDate(int day, int month, int year) {
        List<OrderDetail2> listt = new ArrayList<>();
        String xSql = "SELECT orderr.OrderDate, SUM(orderdetails.Price) AS total_price, SUM(orderdetails.Quantity) AS total_quantity\n"
                + "FROM orderr\n"
                + "JOIN orderdetails\n"
                + "ON orderr.OrderID = orderdetails.OrderID\n"
                + "\n"
                + "WHERE DAY(OrderDate) = ? AND MONTH(OrderDate) = ? AND YEAR(OrderDate) = ?\n"
                + "\n"
                + "GROUP BY orderr.OrderDate;";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(xSql);
            ps.setInt(1, day);
            ps.setInt(2, month);
            ps.setInt(3, year);
            rs = ps.executeQuery();
            
            OrderDetail2 x;
            while (rs.next()) {
                // Sử dụng phương thức phù hợp với kiểu dữ liệu
                double totalprice = rs.getDouble("total_price");
                int totalquantity = rs.getInt("total_quantity");
                // Tạo đối tượng x bằng hàm tạo của lớp OrderDetail2
                x = new OrderDetail2(totalquantity, totalprice);
                // Thêm đối tượng x vào danh sách listt
                listt.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            // Xử lý ngoại lệ
            e.printStackTrace();
        }
        return listt;
    }

    public static void main(String[] args) {
      OrderDetailDAO2 dao = new OrderDetailDAO2();
        // Gọi hàm getTotalbyDate với các tham số day, month và year
        List<OrderDetail2> list = dao.getTotalbyDate(6, 12, 2023);
        // In ra kết quả
        System.out.println("Total price and quantity on 1/1/2020:");
        for (OrderDetail2 od : list) {
            System.out.println("Quantity: " + od.getTotalquantity());
            System.out.println("Price: " + od.getTotalprice());
        }
}
}
