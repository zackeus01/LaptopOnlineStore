/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 *
 * @author ADMIN
 */
public class OrderDetail2 {

    String accname;
    Date OrderDate;
    int Status, OrderID;
    int productID, quantity,totalquantity;
    String img, fullname, addres, email, productName, Seri, phone;
    double price,totalprice ;

    
    public OrderDetail2() {
    }

    public OrderDetail2(int Status) {
        this.Status = Status;
    }

    public OrderDetail2(int totalquantity, double totalprice) {
        this.totalquantity = totalquantity;
        this.totalprice = totalprice;
    }

    public OrderDetail2(String img, String productName, String accname, Date OrderDate, String fullname, String addres, String email, String phone, int quantity, double price, int Status, int OrderID) {
        this.accname = accname;
        this.OrderDate = OrderDate;
        this.Status = Status;
        this.quantity = quantity;
        this.img = img;
        this.fullname = fullname;
        this.addres = addres;
        this.email = email;
        this.productName = productName;
        this.phone = phone;
        this.price = price;
        this.OrderID = OrderID;
    }

    public OrderDetail2(String accname, Date OrderDate, int Status, int productID, int quantity, String img, String fullname, String addres, String email, String productName, String Seri, String phone, double price) {
        this.accname = accname;
        this.OrderDate = OrderDate;
        this.Status = Status;
        this.productID = productID;
        this.quantity = quantity;
        this.img = img;
        this.fullname = fullname;
        this.addres = addres;
        this.email = email;
        this.productName = productName;
        this.Seri = Seri;
        this.phone = phone;
        this.price = price;
        this.OrderID = OrderID;
    }
    public int getTotalquantity() {
        return totalquantity;
    }

    public void setTotalquantity(int totalquantity) {
        this.totalquantity = totalquantity;
    }

    public double getTotalprice() {
        return totalprice;
    }

    public void setTotalprice(double totalprice) {
        this.totalprice = totalprice;
    }
    
    public String getAccname() {
        return accname;
    }

    public void setAccname(String accname) {
        this.accname = accname;
    }

    public Date getOrderDate() {
        return OrderDate;
    }

    public void setOrderDate(Date OrderDate) {
        this.OrderDate = OrderDate;
    }

    public int getStatus() {
        return Status;
    }

    public void setStatus(int Status) {
        this.Status = Status;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAddres() {
        return addres;
    }

    public void setAddres(String addres) {
        this.addres = addres;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getSeri() {
        return Seri;
    }

    public void setSeri(String Seri) {
        this.Seri = Seri;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    @Override
    public String toString() {
        return "OrderDetail2{" + "accname=" + accname + ", OrderDate=" + OrderDate + ", Status=" + Status + ", OrderID=" + OrderID + ", productID=" + productID + ", quantity=" + quantity + ", img=" + img + ", fullname=" + fullname + ", addres=" + addres + ", email=" + email + ", productName=" + productName + ", Seri=" + Seri + ", phone=" + phone + ", price=" + price + '}';
    }

}
