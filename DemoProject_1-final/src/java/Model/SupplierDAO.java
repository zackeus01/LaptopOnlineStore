/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Context.MyDAO;
import Model.Supplier;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author win
 */
public class SupplierDAO extends MyDAO {

    public List<Supplier> getSupplier() {
        List<Supplier> t = new ArrayList<>();
        Supplier s = null;
        xSql = "select supplierID, supplierName from Supplier";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            int sid;
            String sname;
            while (rs.next()) {
                sid = rs.getInt("supplierID");
                sname = rs.getString("supplierName");
                s = new Supplier(sid, sname);
                t.add(s);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public List<String> getSupplierName() {
        List<String> t = new ArrayList<>();
        Supplier s = null;
        xSql = "select supplierName from Supplier";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            String sname;
            while (rs.next()) {
                sname = rs.getString("supplierName");
                t.add(sname);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public void insert(Supplier s) {
        xSql = "insert into Supplier (supplierName, note) values (?,?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, s.getSname());
            ps.setString(2, s.getNote());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Supplier> getAllSupplier() {
        List<Supplier> t = new ArrayList<>();
        xSql = "select * from Supplier";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            int sid;
            String sname, note;
            Supplier x;
            while (rs.next()) {
                sid = rs.getInt("supplierID");
                sname = rs.getString("supplierName");
                note = rs.getString("note");
                x = new Supplier(sid, sname, note);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public Supplier getSupplierById(int sid) {
        Supplier t = new Supplier();
        xSql = "select * from Supplier where supplierID = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, sid);
            rs = ps.executeQuery();
            String sname, note;
            while (rs.next()) {
                sid = rs.getInt("supplierID");
                sname = rs.getString("supplierName");
                note = rs.getString("note");
                t = new Supplier(sid, sname, note);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public List<Integer> getSupplierID(String key, String colum) {
        List<Integer> t = new ArrayList<>();
        xSql = "select supplierID from Supplier WHERE " + colum + " LIKE '%" + key + "%'";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            int sid;
            while (rs.next()) {
                sid = rs.getInt("supplierID");
                t.add(sid);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    
}
