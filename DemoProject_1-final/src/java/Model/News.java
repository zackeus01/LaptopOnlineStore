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
public class News {
    int newid;
    String title, content, newimg, creby, modby,newurl;
    Date credate, moddate;

    public News() {
    }

    public News(String title, String newimg, String newurl) {
        this.title = title;
        this.newimg = newimg;
        this.newurl = newurl;
    }

    public News(int newid, String title, String newimg, String creby, Date credate) {
        this.newid = newid;
        this.title = title;
        this.newimg = newimg;
        this.creby = creby;
        this.credate = credate;
    }

    public News(String title, String content, String newimg, String creby, String newurl, Date credate) {
        this.title = title;
        this.content = content;
        this.newimg = newimg;
        this.creby = creby;
        this.newurl = newurl;
        this.credate = credate;
    }

    public int getNewid() {
        return newid;
    }

    public void setNewid(int newid) {
        this.newid = newid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getNewimg() {
        return newimg;
    }

    public void setNewimg(String newimg) {
        this.newimg = newimg;
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

    public String getNewurl() {
        return newurl;
    }

    public void setNewurl(String newurl) {
        this.newurl = newurl;
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
