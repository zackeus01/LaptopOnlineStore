/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Context.MyDAO;
import Model.ProductType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author win
 */
public class ProductTypeDAO extends MyDAO {

    public List<ProductType> getProductType() {
        List<ProductType> t = new ArrayList<>();
        xSql = "select pt.ProductID,pt.productName, color from ProductType pt,  Product p where pt.productID = p.ProductID order by p.ModifiedDate desc";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            int pid;
            String pname, color;
            ProductType x;
            while (rs.next()) {
                pid = rs.getInt("productID");
                pname = rs.getString("productName");
                color = rs.getString("color");
                x = new ProductType(pid, pname, color);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public ProductType getProductType(int pid) {
        ProductType t = new ProductType();
        xSql = "select ProductID,productName, color from ProductType  where productID = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, pid);
            rs = ps.executeQuery();
            String pname, color;
            while (rs.next()) {
                pid = rs.getInt("productID");
                pname = rs.getString("productName");
                color = rs.getString("color");
                t = new ProductType(pid, pname, color);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public ProductType getProductTypeByID(int pid) {
        ProductType t = new ProductType();
        xSql = "select productName, color, supplierID, CPU, RAM,HardDriver, Screen, Quantity, Describe from ProductType WHERE productID = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, pid);
            rs = ps.executeQuery();
            int sid, quantity;
            String pname, color, ram, cpu, harddriver, screen, describe;
            ProductType x;
            while (rs.next()) {
                pname = rs.getString("productName");
                color = rs.getString("color");
                sid = rs.getInt("supplierID");
                cpu = rs.getString("CPU");
                ram = rs.getString("RAM");
                harddriver = rs.getString("HardDriver");
                screen = rs.getString("Screen");
                quantity = rs.getInt("Quantity");
                describe = rs.getString("Describe");
                t = new ProductType(pid, sid, quantity, pname, color, ram, cpu, harddriver, screen, describe);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public int insert(ProductType p, Connection con) throws SQLException {
        int row = 0;
        xSql = "insert into ProductType ( productName, supplierID, color, RAM, CPU, HardDriver, Screen, Quantity, Describe) values (?,?,?,?,?,?,?,?,?)";
        try ( PreparedStatement ps = con.prepareStatement(xSql)) {
//            ps = con.prepareStatement(xSql);
            ps.setString(1, p.getPname());
            ps.setInt(2, p.getSid());
            ps.setString(3, p.getColor());
            ps.setString(4, p.getRam());
            ps.setString(5, p.getCpu());
            ps.setString(6, p.getHarddriver());
            ps.setString(7, p.getScreen());
            ps.setInt(8, 0);
            ps.setString(9, p.getDescribe());
            row = ps.executeUpdate();
            ps.close();
        }
        return row;
    }

    public List<ProductType> getProductType(String sname) {
        List<ProductType> t = new ArrayList<>();
        xSql = "select * from ProductType P, Supplier S WHERE P.supplierID = S.supplierID AND S.supplierName = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, sname);
            rs = ps.executeQuery();
            int pid, sid, quantity;
            String pname, color, ram, cpu, harddriver, screen, describe;
            while (rs.next()) {
                pid = rs.getInt("productID");
                pname = rs.getString("productName");
                color = rs.getString("Color");
                sid = rs.getInt("supplierID");
                cpu = rs.getString("CPU");
                ram = rs.getString("RAM");
                harddriver = rs.getString("HardDriver");
                screen = rs.getString("Screen");
                quantity = rs.getInt("Quantity");
                describe = rs.getString("Describe");
                ProductType p = new ProductType(pid, sid, quantity, pname, color, ram, cpu, harddriver, screen, describe);
                t.add(p);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public List<ProductType> getProductTypeBySid(int sid) {
        List<ProductType> t = new ArrayList<>();
        xSql = "select productID, productName, color, CPU, RAM,HardDriver, Screen from ProductType WHERE SupplierID=? ";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, sid);
            rs = ps.executeQuery();
            int pid;
            String pname, color, ram, cpu, harddriver, screen;
            while (rs.next()) {
                pid = rs.getInt("productID");
                pname = rs.getString("productName");
                color = rs.getString("Color");
                cpu = rs.getString("CPU");
                ram = rs.getString("RAM");
                harddriver = rs.getString("HardDriver");
                screen = rs.getString("Screen");
                ProductType p = new ProductType(pid, pname, color, ram, cpu, harddriver, screen);
                t.add(p);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public List<ProductType> getProductTypeByKey(String key) {
        List<ProductType> t = new ArrayList<>();
        xSql = "select productID, productName from ProductType WHERE productName LIKE '%" + key + "%'";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            int pid;
            String pname;
            while (rs.next()) {
                pid = rs.getInt("productID");
                pname = rs.getString("productName");
                ProductType p = new ProductType(pid, pname);
                t.add(p);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public List<ProductType> getProductTypeSid(int sid) {
        List<ProductType> t = new ArrayList<>();
        xSql = "select productID, productName from ProductType WHERE supplierID = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, sid);
            rs = ps.executeQuery();
            int pid;
            String pname;
            while (rs.next()) {
                pid = rs.getInt("productID");
                pname = rs.getString("productName");
                ProductType pt = new ProductType(pid, pname);
                t.add(pt);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public int getMaxProductID() {
        int pid = 0;
        xSql = "select MAX(productID) as maxID from ProductType";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                pid = rs.getInt("maxID");
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (pid);
    }

    public int UpdateProductType(int xpid, ProductType x, Connection con) {
        int row = 0;
        xSql = "update ProductType set productName=?, supplierID=?, color=?, RAM=?, "
                + "CPU=?, HardDriver=?, Screen=?, Describe=? where productID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getPname());
            ps.setInt(2, x.getSid());
            ps.setString(3, x.getColor());
            ps.setString(4, x.getRam());
            ps.setString(5, x.getCpu());
            ps.setString(6, x.getHarddriver());
            ps.setString(7, x.getScreen());
            ps.setString(8, x.getDescribe());
            ps.setInt(9, xpid);
            row = ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return row;
    }

    public List<Integer> getProductID() {
        List<Integer> t = new ArrayList<>();
        xSql = "select productID from ProductType";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            int pid;
            while (rs.next()) {
                pid = rs.getInt("productID");
                t.add(pid);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public List<Integer> getProductID(int sid) {
        List<Integer> t = new ArrayList<>();
        xSql = "select productID from ProductType where supplierID= ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, sid);
            rs = ps.executeQuery();
            int pid;
            while (rs.next()) {
                pid = rs.getInt("productID");
                t.add(pid);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public String getProductNameByPid(int pid) {
        String pname = "";
        xSql = "select productName from ProductType where productID= ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, pid);
            rs = ps.executeQuery();
            while (rs.next()) {
                pname = rs.getString(1);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (pname);
    }

    public ProductType getProductTypeInfo(String seri) {
        ProductType t = new ProductType();
        xSql = "  Select P.color, P.CPU, p.HardDriver, P.RAM from ProductType P, Product pr Where pr.Seri= ? AND pr.ProductID= P.productID";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, seri);
            rs = ps.executeQuery();
            String color, cpu, harddriver, ram;
            while (rs.next()) {
                t.setColor(rs.getString("color"));
                t.setCpu(rs.getString("CPU"));
                t.setHarddriver(rs.getString("HardDriver"));
                t.setRam(rs.getString("RAM"));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public List<String> getColumName(String tablename) {
        List<String> t = new ArrayList<>();
        xSql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, tablename);
            rs = ps.executeQuery();
            while (rs.next()) {
                String columnName = rs.getString("COLUMN_NAME");
                t.add(columnName);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public List<ProductType> getProductByKey(String key, String colum) {
        List<ProductType> t = new ArrayList<>();
        xSql = "select productID, productName,supplierID, color, RAM, CPU, HardDriver, Screen, Describe from ProductType WHERE " + colum + " LIKE '%" + key + "%'";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            int pid, sid;
            String pname, color, ram, hard, screen, describe, cpu;
            while (rs.next()) {
                pid = rs.getInt("productID");
                pname = rs.getString("productName");
                sid = rs.getInt("supplierID");
                color = rs.getString("color");
                ram = rs.getString("RAM");
                hard = rs.getString("HardDriver");
                screen = rs.getString("Screen");
                cpu = rs.getString("CPU");
                describe = rs.getString("Describe");
                ProductType p = new ProductType(pid, sid, pname, color, ram, cpu, hard, screen, describe);
                t.add(p);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    public List<Result> getReslut(String key, String colum, String table) {
        List<Result> t = new ArrayList<>();
        xSql = "select DISTINCT "+ colum+" from "+table+" WHERE "+ colum + " LIKE '%" + key + "%'";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();          
            while (rs.next()) {
                Result r = new Result(colum, table, rs.getString(colum));
                t.add(r);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
//    public static void main(String[] args) {
//        ProductTypeDAO ptd = new ProductTypeDAO();      
//        System.out.println(ptd.getReslut("a", "productName", "ProductType"));
//    }
}
