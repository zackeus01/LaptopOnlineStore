/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Context.MyDAO;
import Model.Product;
import java.sql.Connection;
import java.util.ArrayList;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author win
 */
public class ProductDAO extends MyDAO {

    public List<Product> getProduct() {
        List<Product> t = new ArrayList<>();
        xSql = "select * from Product";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            String seri, creby, modby, img;
            int pid, guarantee, sell;
            float price;
            Date credate, moddate;
            Product x;
            while (rs.next()) {
                seri = rs.getString("Seri");
                pid = rs.getInt("ProductID");
                creby = rs.getString("CreateDate");
                modby = rs.getString("ModifiedBy");
                credate = rs.getDate("CreateDate");
                moddate = rs.getDate("ModifiedDate");
                img = rs.getString("images");
                guarantee = rs.getInt("Guarantee");
                sell = rs.getInt("sell");
                price = rs.getFloat("price");
                x = new Product(seri, creby, modby, img, pid, guarantee, sell, price, credate, moddate);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public Product getProductBySeri(String seri) {
        Product p = new Product();
        xSql = "select ProductID,price, sell, Guarantee, images from Product WHERE Seri =?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, seri);
            rs = ps.executeQuery();
            String img;
            int pid, guarantee, sell;
            float price;
            while (rs.next()) {
                pid = rs.getInt("ProductID");
                img = rs.getString("images");
                guarantee = rs.getInt("Guarantee");
                sell = rs.getInt("sell");
                price = rs.getFloat("price");
                p = new Product(seri, img, pid, guarantee, sell, price);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (p);
    }

    public List<Product> getProductByID(int pID) {
        List<Product> t = new ArrayList<>();
        xSql = "select Seri, images, Guarantee, sell, price from Product WHERE ProductID =?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, pID);
            rs = ps.executeQuery();
            String seri, img;
            int guarantee, sell;
            float price;
            Product x;
            while (rs.next()) {
                seri = rs.getString("Seri");
                img = rs.getString("images");
                guarantee = rs.getInt("Guarantee");
                sell = rs.getInt("sell");
                price = rs.getFloat("price");
                x = new Product(seri, img, pID, guarantee, sell, price);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    public List<Product> getProductDesc() {
        List<Product> t = new ArrayList<>();
        xSql = "select productID, Seri, images, Guarantee, sell, price from Product order by ModifiedDate desc, ProductID desc";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            String seri, img;
            int guarantee, sell, pid;
            float price;
            Product x;
            while (rs.next()) {
                pid = rs.getInt("productID");
                seri = rs.getString("Seri");
                img = rs.getString("images");
                guarantee = rs.getInt("Guarantee");
                sell = rs.getInt("sell");
                price = rs.getFloat("price");
                x = new Product(seri, img, pid, guarantee, sell, price);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }

    public int insert(Product p, Connection con) throws SQLException {
        int row = 0;
        xSql = "insert into Product (Seri, ProductID, price, CreateDate, ModifiedDate, "
                + "CreateBy, ModifiedBy, sell, Guarantee, images) values (?,?,?,?,?,?,?,?,?,?)";
        try(PreparedStatement ps = con.prepareStatement(xSql)) {
//            ps = con.prepareStatement(xSql);
            ps.setString(1, p.getSeri());
            ps.setInt(2, p.getPid());
            ps.setFloat(3, p.getPrice());
            ps.setDate(4, p.getCredate());
            ps.setDate(5, p.getModdate());
            ps.setString(6, p.getCreby());
            ps.setString(7, p.getModby());
            ps.setInt(8, p.getSell());
            ps.setInt(9, p.getGuarantee());
            ps.setString(10, p.getImg());
            row = ps.executeUpdate();
            ps.close();
        }
        return row;
    }

    public int DeleteProduct(String seri) {
        int row = 0;
        xSql = "delete from Product where Seri=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, seri);
            row = ps.executeUpdate();
            //con.commit();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return row;
    }

    public int update(String seri, Product x, Connection con) {
        int row = 0;
        xSql = "update Product set Seri= ?, price =?, ModifiedDate=?, ModifiedBy=?, sell=?, Guarantee=?, images=?, ProductID=? where Seri =?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getSeri());
            ps.setFloat(2, x.getPrice());
            ps.setDate(3, x.getModdate());
            ps.setString(4, x.getModby());
            ps.setInt(5, x.getSell());
            ps.setInt(6, x.getGuarantee());
            ps.setString(7, x.getImg());
            ps.setInt(8, x.getPid());
            ps.setString(9, seri);
            row = ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return row;
    }
    
    public List<String> getProductImages(int pid ) {
        List<String> t = new ArrayList<>();
        xSql = "select images from ProductImageList where productID = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, pid);
            rs = ps.executeQuery();
            String img;
            while (rs.next()) {
                img = rs.getString("images");
                t.add(img);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    public int getProductIdBySeri(String seri) {
        int pid = -1;
        xSql = "select ProductID from Product WHERE Seri =?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, seri);
            rs = ps.executeQuery();
            while (rs.next()) {
                pid = rs.getInt("ProductID");
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (pid);
    }
}
