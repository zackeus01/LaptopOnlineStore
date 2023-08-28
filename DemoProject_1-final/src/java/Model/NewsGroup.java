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
public class NewsGroup {

    String nwgId, nwId, title, nw;

    public NewsGroup() {
        connect();
    }

    public NewsGroup(String nwgId, String nwId, String title, String nw) {
        this.nwgId = nwgId;
        this.nwId = nwId;
        this.title = title;
        this.nw = nw;
        connect();
    }
    
    public NewsGroup(String nwgId,String nw) {
        this.nwgId = nwgId;
        this.nw = nw;
        connect();
    }

    public String getNwgId() {
        return nwgId;
    }

    public void setNwgId(String nwgId) {
        this.nwgId = nwgId;
    }

    public String getNwId() {
        return nwId;
    }

    public void setNwId(String nwId) {
        this.nwId = nwId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getNw() {
        return nw;
    }

    public void setNw(String nw) {
        this.nw = nw;
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

    public ArrayList<NewsGroup> listNew() {
        ArrayList<NewsGroup> data = new ArrayList<NewsGroup>();
        try {
            String strSelect = "SELECT NewsGroup.NewsGroupId, NewsGroup.New, News.NewId, News.Title\n"
                    + "FROM NewsGroup\n"
                    + "JOIN News ON NewsGroup.NewsGroupId = News.NewsGroupId";

            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = stm.executeQuery(strSelect);
            while (rs.next()) {
                String nwgId = rs.getString(1);
                String nw = rs.getString(2);
                String nwId = rs.getString(3);
                String title = rs.getString(4);
                data.add(new NewsGroup(nwgId, nwId, title, nw));
            }
        } catch (Exception e) {
            System.out.println("listNew:" + e.getMessage());
        }
        return data;
    }

    public ArrayList<NewsGroup> listNew1() {
        ArrayList<NewsGroup> data = new ArrayList<NewsGroup>();
        try {
            String strSelect = "SELECT * from NewsGroup";

            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = stm.executeQuery(strSelect);
            while (rs.next()) {
                String nwgId = rs.getString(1);
                String nw = rs.getString(2);
                data.add(new NewsGroup(nwgId,nw));
            }
        } catch (Exception e) {
            System.out.println("listNew1:" + e.getMessage());
        }
        return data;
    }

}
