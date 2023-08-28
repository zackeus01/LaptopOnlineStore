/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Context.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Dinh Nguyen
 */
public class OrderDAO extends MyDAO {

    public Order getOrderByOrderID(int OrderID) {
        Order order = null;
        String sql = "SELECT OrderID, AccountID, Total, OrderDate, Status FROM Orderr WHERE OrderID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, OrderID);
            rs = ps.executeQuery();
            if (rs.next()) {
                int accountID = rs.getInt("AccountID");
                double total = rs.getDouble("Total");
                Date orderDate = rs.getDate("OrderDate");
                int status = rs.getInt("Status");
                order = new Order(OrderID, accountID, (java.sql.Date) orderDate, total, status);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    public int getAccountIDBySeri(String seri) {
        int accountID = 0;
        String sql = "SELECT AccountID FROM Orderr O, OrderDetails OD WHERE O.OrderID = OD.OrderID AND OD.Seri = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, seri);
            rs = ps.executeQuery();
            if (rs.next()) {
                accountID = rs.getInt("AccountID");
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accountID;
    }
    public static void main(String[] args) {
        OrderDAO od = new OrderDAO();
        System.out.println(od.getAccountIDBySeri("NGOC 1111"));
    }
}
