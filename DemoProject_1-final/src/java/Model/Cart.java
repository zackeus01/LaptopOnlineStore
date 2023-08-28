/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author CuK
 */
public class Cart {
    private String Seri;
    private String pName;
    private String img;
    private int quantity;
    private float price;

    public Cart() {
    }

    public Cart(String Seri, String pName, String img, int quantity, float price) {
        this.Seri = Seri;
        this.pName = pName;
        this.img = img;
        this.quantity = quantity;
        this.price = price;
    }
    
    public String getSeri() {
        return Seri;
    }

    public void setSeri(String Seri) {
        this.Seri = Seri;
    }
    
    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }
    
}
