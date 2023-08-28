/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author khang
 */
public class ProductCompare {

    String seri, Pname, sname, color, ram, cpu, hd, Sc, image;
    int pid;
    float price;

    public ProductCompare() {
        connect();
    }

    public ProductCompare(String seri, String Pname, int pid, String sname, String color, String ram, String cpu, String hd, String Sc, float price, String image) {
        this.seri = seri;
        this.Pname = Pname;
        this.pid = pid;
        this.sname = sname;
        this.color = color;
        this.ram = ram;
        this.cpu = cpu;
        this.hd = hd;
        this.Sc = Sc;
        this.price = price;
        this.image = image;
        connect();
    }

    public String getSeri() {
        return seri;
    }

    public void setSeri(String seri) {
        this.seri = seri;
    }
    

    public String getPname() {
        return Pname;
    }

    public void setPname(String Pname) {
        this.Pname = Pname;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public String getHd() {
        return hd;
    }

    public void setHd(String hd) {
        this.hd = hd;
    }

    public String getSc() {
        return Sc;
    }

    public void setSc(String Sc) {
        this.Sc = Sc;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    Connection cnn;//kết nối DB
    Statement stm;//Thực thi câu lệnh
    PreparedStatement pstm;//Thuc thi SQL
    ResultSet rs;//Lưu trữ và sử lý dữ liệu

    private void connect() {
        try {
            cnn = (new DBContext().connection);
            if (cnn != null) {
                System.out.println("Connect successfully");
            } else {
                System.out.println("Connect Fail");
            }
        } catch (Exception e) {

        }
    }

    public ProductCompare getListProductid(String pidd) {
        try {
            String strSelect = "Select p.Seri,p.ProductID, pt.productName, s.supplierName, p.images, p.price,pt.color,pt.CPU,pt.RAM,pt.HardDriver,pt.Screen from Product p JOIN ProductType pt ON p.ProductID = pt.productID JOIN Supplier s ON s.supplierID = pt.supplierID where p.Seri = ?";

            pstm = cnn.prepareStatement(strSelect);
            pstm.setInt(1, Integer.parseInt(pidd));
            rs = pstm.executeQuery();
            while (rs.next()) {
                String seri = rs.getString(1);
                String Pname = rs.getString(3);
                int pid = rs.getInt(2);
                String sname = rs.getString(4);
                String color = rs.getString(7);
                String ram = rs.getString(9);
                String cpu = rs.getString(8);
                String hd = rs.getString(10);
                String Sc = rs.getString(11);
                float price = rs.getFloat(6);
                String image = rs.getString(5);
                return new ProductCompare(seri, Pname, pid, sname, color, ram, cpu, hd, Sc, price, image);

            }
        } catch (Exception e) {
            System.out.println("getListProductid:" + e.getMessage());
        }
        return null;
    }

    public ArrayList<ProductCompare> getListProductSearch(String text) {
        ArrayList<ProductCompare> data = new ArrayList<ProductCompare>();
        try {
            String strSelect = "Select p.Seri,p.ProductID, pt.productName, s.supplierName, p.images, p.price,pt.color,pt.CPU,pt.RAM,pt.HardDriver,pt.Screen from Product p JOIN ProductType pt ON p.ProductID = pt.productID JOIN Supplier s ON s.supplierID = pt.supplierID where pt.productName like ?";

            pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, "%"+text+"%");
            rs = pstm.executeQuery();
            while (rs.next()) {
                String seri = rs.getString(1);
                String Pname = rs.getString(3);
                int pid = rs.getInt(2);
                String sname = rs.getString(4);
                String color = rs.getString(7);
                String ram = rs.getString(9);
                String cpu = rs.getString(8);
                String hd = rs.getString(10);
                String Sc = rs.getString(11);
                float price = rs.getFloat(6);
                String image = rs.getString(5);
                data.add(new ProductCompare(seri, Pname, pid, sname, color, ram, cpu, hd, Sc, price, image));

            }
        } catch (Exception e) {
            System.out.println("getListProductSearch:" + e.getMessage());
        }
        return data;
    }

    public ProductCompare getListProductid1(String text) {
         try {
            String strSelect = "Select p.ProductID, pt.productName, s.supplierName, p.images, p.price,pt.color,pt.CPU,pt.RAM,pt.HardDriver,pt.Screen from Product p JOIN ProductType pt ON p.ProductID = pt.productID JOIN Supplier s ON s.supplierID = pt.supplierID where p.ProductID = ?";

            pstm = cnn.prepareStatement(strSelect);
            pstm.setInt(1, Integer.parseInt(text));
            rs = pstm.executeQuery();
            while (rs.next()) {
                 String seri = rs.getString(1);
                String Pname = rs.getString(3);
                int pid = rs.getInt(2);
                String sname = rs.getString(4);
                String color = rs.getString(7);
                String ram = rs.getString(9);
                String cpu = rs.getString(8);
                String hd = rs.getString(10);
                String Sc = rs.getString(11);
                float price = rs.getFloat(6);
                String image = rs.getString(5);
                return new ProductCompare(seri, Pname, pid, sname, color, ram, cpu, hd, Sc, price, image);

            }
        } catch (Exception e) {
            System.out.println("getListProductid:" + e.getMessage());
        }
        return null;
    }

}
