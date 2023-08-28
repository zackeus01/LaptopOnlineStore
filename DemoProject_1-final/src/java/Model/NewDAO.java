/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Context.MyDAO;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author win
 */
public class NewDAO extends MyDAO{
    public List<News> getTop3New() {
        List<News> t = new ArrayList<>();
        xSql = "select TOP 3 NewImages, NewUrl, Title from News";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            String newimg,newurl, title;            
            News x;
            while (rs.next()) {
                newimg = rs.getString("NewImages");
                newurl = rs.getString("NewUrl");
                title = rs.getString("Title");
                x = new News(title, newimg, newurl);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    public List<News> getListNew() {
        List<News> t = new ArrayList<>();
        xSql = "select NewImages, Title, CreateBy, CreateDate, NewID from News";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            String newimg,creby, title; 
            int newid;
            Date credate;
            News x;
            while (rs.next()) {
                newimg = rs.getString("NewImages");
                creby = rs.getString("CreateBy");
                title = rs.getString("Title");
                newid = rs.getInt("NewID");
                credate = rs.getDate("CreateDate");
                x = new News(newid, title, newimg, creby, credate);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    public int AddNew(News n){
        int row = 0;
            xSql = "Insert into News (CreateBy, CreateDate, Title, Content, NewImages, NewUrl) values(?,?,?,?,?,?)";
           try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, n.getCreby());
            ps.setDate(2, n.getCredate());
            ps.setString(3, n.getTitle());
            ps.setString(4, n.getContent());
            ps.setString(5, n.getNewimg());
            ps.setString(6, n.getNewurl());
            row = ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return row;
    }
//    public static void main(String[] args) {
//        NewDAO nd = new NewDAO();
//        Date d = Date.valueOf(LocalDate.now());
//        News n = new News("abc", "ksjkd", "jshfjs", "ngoc", "jshjds", d);
//        nd.AddNew(n);
//    }
}
