/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;



/**
 *
 * @author win
 */
public class Product {
    String seri, creby, modby,img;
    int pid, guarantee, sell;
    float price; 
    Date credate, moddate;

    public Product() {
    }

    public Product(String seri, String img, int guarantee, int sell, float price) {
        this.seri = seri;
        this.img = img;
        this.guarantee = guarantee;
        this.sell = sell;
        this.price = price;
    }

    public Product(String seri, String img, int pid, int guarantee, int sell, float price) {
        this.seri = seri;
        this.img = img;
        this.pid = pid;
        this.guarantee = guarantee;
        this.sell = sell;
        this.price = price;
    }

    public Product(String seri, String creby, String modby, String img, int pid, int guarantee, int sell,float price, Date credate, Date moddate) {
        this.seri = seri;
        this.creby = creby;
        this.modby = modby;
        this.img = img;
        this.pid = pid;
        this.guarantee = guarantee;
        this.sell = sell;
        this.price = price;
        this.credate = credate;
        this.moddate = moddate;
    }

    public Product(String seri, String modby, String img, int pid, int guarantee, int sell,float price, Date moddate) {
        this.seri = seri;
        this.modby = modby;
        this.img = img;
        this.pid = pid;
        this.guarantee = guarantee;
        this.sell = sell;
        this.price = price;
        this.moddate = moddate;
    }

    public String getSeri() {
        return seri;
    }

    public void setSeri(String seri) {
        this.seri = seri;
    }

    public String getCreby() {
        return creby;
    }

    public void setCreby(String creby) {
        this.creby = creby;
    }

    public String getModby() {
        return modby;
    }

    public void setModby(String modby) {
        this.modby = modby;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getGuarantee() {
        return guarantee;
    }

    public void setGuarantee(int guarantee) {
        this.guarantee = guarantee;
    }

    public int getSell() {
        return sell;
    }

    public void setSell(int sell) {
        this.sell = sell;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public Date getCredate() {
        return credate;
    }

    public void setCredate(Date credate) {
        this.credate = credate;
    }

    public Date getModdate() {
        return moddate;
    }

    public void setModdate(Date moddate) {
        this.moddate = moddate;
    }
    
    
}
