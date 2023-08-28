/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Dinh Nguyen
 */
public class ProductDisplay {
    String seri;
    String pname, sname, img;
    float price;
    float sell;
    public ProductDisplay() {
    }

    public ProductDisplay(String seri, String pname, String supName, String img, float price) {
        this.seri = seri;
        this.pname = pname;
        this.sname = supName;
        this.img = img;
        this.price = price;
    }

    public ProductDisplay(String seri, String pname, String sname, String img, float price, float sell) {
        this.seri = seri;
        this.pname = pname;
        this.sname = sname;
        this.img = img;
        this.price = price;
        this.sell = sell;
    }
     
    public String getSeri() {
        return seri;
    }

    public void setSeri(String seri) {
        this.seri = seri;
    }
    
    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public float getSell() {
        return sell;
    }

    public void setSell(float sell) {
        this.sell = sell;
    }
    
    
}
