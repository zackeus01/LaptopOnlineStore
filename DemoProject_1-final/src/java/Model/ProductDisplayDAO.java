/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Context.*;
import Model.ProductDisplay;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Dinh Nguyen
 */
public class ProductDisplayDAO extends MyDAO {

    public List<ProductDisplay> getProductByCate(int sid) {
        xSql = "Select p.Seri, pt.productName, s.supplierName, p.images, p.price from Product p JOIN ProductType pt ON p.ProductID = pt.productID JOIN Supplier s ON s.supplierID = pt.supplierID where s.supplierID =?";
        List<ProductDisplay> t = new ArrayList<>();
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, sid);
            rs = ps.executeQuery();
            String seri, pname, sname, img;
            float price;
            ProductDisplay x;
            while (rs.next()) {
                seri = rs.getString(1);
                pname = rs.getString(2);
                sname = rs.getString(3);
                img = rs.getString(4);
                price = rs.getFloat(5);
                x = new ProductDisplay(seri, pname, sname, img, price);
                t.add(x);
            }
        } catch (Exception e) {
            System.err.println("readCartDetail"+e.getMessage());
        }
        return (t);
    }

    public List<ProductDisplay> getNewestProductByCate(int sid) {
        xSql = "Select top 10 p.Seri, pt.productName, s.supplierName, p.images, p.price, p.sell from Product p JOIN ProductType pt ON p.ProductID = pt.productID JOIN Supplier s ON s.supplierID = pt.supplierID where s.supplierID =?";
        List<ProductDisplay> t = new ArrayList<>();
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, sid);
            rs = ps.executeQuery();
            String seri, pname, sname, img;
            float price, sell;
            ProductDisplay x;
            while (rs.next()) {
                seri = rs.getString(1);
                pname = rs.getString(2);
                sname = rs.getString(3);
                img = rs.getString(4);
                price = rs.getFloat(5);
                sell = rs.getFloat(6);
                x = new ProductDisplay(seri, pname, sname, img, price,sell);
                t.add(x);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    public List<ProductDisplay> getTopSelling() {
        xSql = "Select top 10 p.Seri, pt.productName, s.supplierName, p.images, p.price, p.sell from Product p JOIN ProductType pt ON p.ProductID = pt.productID JOIN Supplier s ON s.supplierID = pt.supplierID ORDER BY sell desc";
        List<ProductDisplay> t = new ArrayList<>();
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            String seri, pname, sname, img;
            float price, sell;
            ProductDisplay x;
            while (rs.next()) {
                seri = rs.getString(1);
                pname = rs.getString(2);
                sname = rs.getString(3);
                img = rs.getString(4);
                price = rs.getFloat(5);
                sell = rs.getFloat(6);
                x = new ProductDisplay(seri, pname, sname, img, price,sell);
                t.add(x);
            }
        } catch (Exception e) {
            System.err.println("readCartDetail" + e.getMessage());
        }
        return (t);
    }

    
    public List<ProductDisplay> getAllProductDisplay() {
        xSql = "Select p.Seri, pt.productName, s.supplierName, p.images, p.price, p.sell from Product p JOIN ProductType pt ON p.ProductID = pt.productID JOIN Supplier s ON s.supplierID = pt.supplierID";
        List<ProductDisplay> t = new ArrayList<>();
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            String seri, pname, sname, img;
            float price, sell;
            ProductDisplay x;
            while (rs.next()) {
                seri = rs.getString(1);
                pname = rs.getString(2);
                sname = rs.getString(3);
                img = rs.getString(4);
                price = rs.getFloat(5);
                sell = rs.getFloat(6);
                x = new ProductDisplay(seri, pname, sname, img, price, sell);
                t.add(x);
            }
        } catch (Exception e) {
            System.err.println("getAllProductDisplay"+e.getMessage());
        }
        return (t);
    }
    public List<ProductDisplay> getProduct(String value, String colum) {
        xSql = "Select top 10 p.Seri, pt.productName, s.supplierName, p.images, p.price from Product p JOIN ProductType pt ON p.ProductID = pt.productID JOIN Supplier s ON s.supplierID = pt.supplierID WHERE " + colum + " LIKE '%"+value+"%'";
        List<ProductDisplay> t = new ArrayList<>();
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            String seri, pname, sname, img;
            float price;
            ProductDisplay x;
            while (rs.next()) {
                seri = rs.getString(1);
                pname = rs.getString(2);
                sname = rs.getString(3);
                img = rs.getString(4);
                price = rs.getFloat(5);
                x = new ProductDisplay(seri, pname, sname, img, price);
                t.add(x);
            }
        } catch (Exception e) {
            System.err.println("readCartDetail"+e.getMessage());
        }
        return (t);
    }
    
    public List<ProductDisplay> getProductByPrice(int brand, double minPrice, double maxPrice){
        xSql = "Select p.Seri, pt.productName, s.supplierName, p.images, p.price from Product P join ProductType PT\n" +
                "on P.ProductID = PT.productID join Supplier S\n" +
                "on S.supplierID = PT.supplierID \n" +
                "where  PT.supplierID = ?\n" +
                "AND P.price between ? and ?\n" +
                "ORDER BY p.price asc";
        List<ProductDisplay> t = new ArrayList<>();
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, brand);
            ps.setDouble(2, minPrice);
            ps.setDouble(3, maxPrice);
            rs = ps.executeQuery();
            String seri, pname, sname, img;
            float price;
            ProductDisplay x;
            while (rs.next()) {
                seri = rs.getString(1);
                pname = rs.getString(2);
                sname = rs.getString(3);
                img = rs.getString(4);
                price = rs.getFloat(5);
                x = new ProductDisplay(seri, pname, sname, img, price);
                t.add(x);
            }
        }
        catch (Exception e) {
                System.out.println("getProductByPrice" + e.getMessage());
        }
        return t;
    }
    
}
