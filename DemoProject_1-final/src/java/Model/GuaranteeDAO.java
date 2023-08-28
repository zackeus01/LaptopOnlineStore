/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Context.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author win
 */
public class GuaranteeDAO extends MyDAO {

    public int insertGuarantee(Guarantee guarantee) {
        int row = 0;
        String sql = "INSERT INTO Guarantee (AccountID, ProductID, Progress, ReceivedDate,  Seri, Describe, FullName, Address, phone, email,DeliveryDate, PersonGuarantee, expense, productImages) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, guarantee.getAccounID());
            ps.setInt(2, guarantee.getProductID());
            ps.setInt(3, guarantee.getProgress());
            ps.setDate(4, guarantee.getReceivedDate());
            ps.setString(5, guarantee.getSeri());
            ps.setString(6, guarantee.getDescribe());
            ps.setString(7, guarantee.getFullname());
            ps.setString(8, guarantee.getAddress());
            ps.setString(9, guarantee.getPhone());
            ps.setString(10, guarantee.getEmail());
            ps.setDate(11, guarantee.getDeliveryDate());
            ps.setString(12, guarantee.getPersonguarantee());
            ps.setFloat(13, guarantee.getExpense());
            ps.setString(14, guarantee.getPimg());

            row = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return row;
    }

    public int countRecordsByProductID(int productID) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS RecordCount FROM Guarantee WHERE ProductID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("RecordCount");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Guarantee> getGuarantee() {
        List<Guarantee> t = new ArrayList<>();
        String sql = "SELECT GuaranteeID,Seri, FullName, ReceivedDate, DeliveryDate, Progress FROM Guarantee";
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Guarantee g = new Guarantee();
                g.setGuaranteeID(rs.getInt("GuaranteeID"));
                g.setFullname(rs.getString("FullName"));
                g.setReceivedDate(rs.getDate("ReceivedDate"));
                g.setDeliveryDate(rs.getDate("DeliveryDate"));
                g.setProgress(rs.getInt("Progress"));
                g.setSeri(rs.getString("Seri"));
                t.add(g);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    public Guarantee getGuaranteeByID(int guaranteeID) {
        String sql = "SELECT [AccountID], [ReceivedDate], [DeliveryDate], [Progress], [ProductID], [Seri], [Evaluate], [Comment], [Describe], [PersonGuarantee], [FullName], [Address], [phone], [email], [expense], [productImages] FROM [ProjectGroup5].[dbo].[Guarantee] WHERE [GuaranteeID] = ?";
        Guarantee guarantee = null;

        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, guaranteeID);
            rs = ps.executeQuery();

            if (rs.next()) {
                guarantee = new Guarantee();
                guarantee.setAccounID(rs.getInt("AccountID"));
                guarantee.setReceivedDate(rs.getDate("ReceivedDate"));
                guarantee.setDeliveryDate(rs.getDate("DeliveryDate"));
                guarantee.setProgress(rs.getInt("Progress"));
                guarantee.setProductID(rs.getInt("ProductID"));
                guarantee.setSeri(rs.getString("Seri"));
                guarantee.setEvaluate(rs.getInt("Evaluate"));
                guarantee.setComment(rs.getString("Comment"));
                guarantee.setDescribe(rs.getString("Describe"));
                guarantee.setGuaranteeID(guaranteeID);
                guarantee.setPersonguarantee(rs.getString("PersonGuarantee"));
                guarantee.setFullname(rs.getString("FullName"));
                guarantee.setAddress(rs.getString("Address"));
                guarantee.setPhone(rs.getString("phone"));
                guarantee.setEmail(rs.getString("email"));
                guarantee.setExpense(rs.getFloat("expense"));
                guarantee.setPimg(rs.getString("productImages"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return guarantee;
    }

    public void updateProgressByGuaranteeID(int guaranteeID, int progress) {
        String sql = "UPDATE Guarantee SET Progress = ? WHERE GuaranteeID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, progress);
            ps.setInt(2, guaranteeID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<Guarantee> getGuaranteeByName( String name) {
        List<Guarantee> t = new ArrayList<>();
        String sql = "SELECT GuaranteeID,Seri, FullName, ReceivedDate, DeliveryDate, Progress FROM Guarantee WHERE FullName LIKE '%" + name +"%'";
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Guarantee g = new Guarantee();
                g.setGuaranteeID(rs.getInt("GuaranteeID"));
                g.setFullname(rs.getString("FullName"));
                g.setReceivedDate(rs.getDate("ReceivedDate"));
                g.setDeliveryDate(rs.getDate("DeliveryDate"));
                g.setProgress(rs.getInt("Progress"));
                g.setSeri(rs.getString("Seri"));
                t.add(g);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }
    public List<Guarantee> getGuaranteeByDate() {
        List<Guarantee> t = new ArrayList<>();
        String sql = "SELECT GuaranteeID,Seri, FullName, ReceivedDate, DeliveryDate, Progress FROM Guarantee WHERE DeliveryDate < GETDATE() AND Progress <3";
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Guarantee g = new Guarantee();
                g.setGuaranteeID(rs.getInt("GuaranteeID"));
                g.setFullname(rs.getString("FullName"));
                g.setReceivedDate(rs.getDate("ReceivedDate"));
                g.setDeliveryDate(rs.getDate("DeliveryDate"));
                g.setProgress(rs.getInt("Progress"));
                g.setSeri(rs.getString("Seri"));
                t.add(g);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }
     public List<Guarantee> getGuaranteeByProgress( int progress) {
        List<Guarantee> t = new ArrayList<>();
        String sql = "SELECT GuaranteeID,Seri, FullName, ReceivedDate, DeliveryDate, Progress FROM Guarantee WHERE  Progress =?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, progress);
            rs = ps.executeQuery();
            while (rs.next()) {
                Guarantee g = new Guarantee();
                g.setGuaranteeID(rs.getInt("GuaranteeID"));
                g.setFullname(rs.getString("FullName"));
                g.setReceivedDate(rs.getDate("ReceivedDate"));
                g.setDeliveryDate(rs.getDate("DeliveryDate"));
                g.setProgress(rs.getInt("Progress"));
                g.setSeri(rs.getString("Seri"));
                t.add(g);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }
     public List<Guarantee> getGuaranteeByAccID( int acid) {
        List<Guarantee> t = new ArrayList<>();
        String sql = "SELECT GuaranteeID,Seri, FullName, ReceivedDate, DeliveryDate, Progress FROM Guarantee WHERE  AccountID =?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, acid);
            rs = ps.executeQuery();
            while (rs.next()) {
                Guarantee g = new Guarantee();
                g.setGuaranteeID(rs.getInt("GuaranteeID"));
                g.setFullname(rs.getString("FullName"));
                g.setReceivedDate(rs.getDate("ReceivedDate"));
                g.setDeliveryDate(rs.getDate("DeliveryDate"));
                g.setProgress(rs.getInt("Progress"));
                g.setSeri(rs.getString("Seri"));
                t.add(g);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }
     public void updateEvaluateByGuaranteeID(int guaranteeID, int evaluate, String comment) {
        String sql = "UPDATE Guarantee SET Evaluate = ?, Comment=?  WHERE GuaranteeID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, evaluate);
            ps.setString(2, comment);
            ps.setInt(3, guaranteeID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
     public List<Guarantee> getGuaranteeByPid(int pid) {
        List<Guarantee> t = new ArrayList<>();
        String sql = "SELECT GuaranteeID,Seri, FullName, ReceivedDate, DeliveryDate, Progress FROM Guarantee WHERE ProductID=?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, pid);
            rs = ps.executeQuery();
            while (rs.next()) {
                Guarantee g = new Guarantee();
                g.setGuaranteeID(rs.getInt("GuaranteeID"));
                g.setFullname(rs.getString("FullName"));
                g.setReceivedDate(rs.getDate("ReceivedDate"));
                g.setDeliveryDate(rs.getDate("DeliveryDate"));
                g.setProgress(rs.getInt("Progress"));
                g.setSeri(rs.getString("Seri"));
                t.add(g);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return t;
    }

    public Map<Integer, Integer> countRecords() {
        Map<Integer, Integer> counts = new HashMap<>();
        String sql = "SELECT ProductID, COUNT(*) AS RecordCount FROM Guarantee GROUP BY ProductID";
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                int recordCount = rs.getInt("RecordCount");
                counts.put(productID, recordCount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return counts;
    }
    public static void main(String[] args) {
        GuaranteeDAO gd = new GuaranteeDAO();
        
        System.out.println(gd.getGuaranteeByID(1));
    }
}
