/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Dinh Nguyen
 */
public class OrderDetail {

    int OrderDetailID, OrderID, productID, quantity;
    String fullname, addres, email, productName, Seri, phone;
    double price;

    public OrderDetail() {
    }

    public OrderDetail(int OrderDetailID, int OrderID, int productID, int quantity, String fullname, String addres, String email, String productName, String Seri, String phone, Double price) {
        this.OrderDetailID = OrderDetailID;
        this.OrderID = OrderID;
        this.productID = productID;
        this.quantity = quantity;
        this.fullname = fullname;
        this.addres = addres;
        this.email = email;
        this.productName = productName;
        this.Seri = Seri;
        this.phone = phone;
        this.price = price;
    }

    public OrderDetail(int OrderID, int productID, int quantity, String fullname, String addres, String email, String productName, String Seri, String phone, Double price) {
        this.OrderID = OrderID;
        this.productID = productID;
        this.quantity = quantity;
        this.fullname = fullname;
        this.addres = addres;
        this.email = email;
        this.productName = productName;
        this.Seri = Seri;
        this.phone = phone;
        this.price = price;
    }

    public int getOrderDetailID() {
        return OrderDetailID;
    }

    public void setOrderDetailID(int OrderDetailID) {
        this.OrderDetailID = OrderDetailID;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

}
