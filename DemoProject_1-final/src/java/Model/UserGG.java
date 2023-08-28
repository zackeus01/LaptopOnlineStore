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

/**
 *
 * @author ADMIN
 */
public class UserGG {

    String id;
    String per;
    String email;
    boolean verified_name;
    String name;
    String given_name;
    String family_name;
    String picture;

    public UserGG() {
        connect();
    }

    public UserGG(String id, String per, String email, boolean verified_name, String name, String given_name, String family_name, String picture) {
        this.id = id;
        this.email = email;
        this.verified_name = verified_name;
        this.name = name;
        this.given_name = given_name;
        this.family_name = family_name;
        this.picture = picture;
        this.per = per;

        connect();
    }

    public String getPer() {
        return per;
    }

    public void setPer(String per) {
        this.per = per;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isVerified_name() {
        return verified_name;
    }

    public void setVerified_name(boolean verified_name) {
        this.verified_name = verified_name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGiven_name() {
        return given_name;
    }

    public void setGiven_name(String given_name) {
        this.given_name = given_name;
    }

    public String getFamily_name() {
        return family_name;
    }

    public void setFamily_name(String family_name) {
        this.family_name = family_name;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    @Override
    public String toString() {
        return "UserGG{" + "id=" + id + ", per=" + per + ", email=" + email + ", verified_name=" + verified_name + ", name=" + name + ", given_name=" + given_name + ", family_name=" + family_name + ", picture=" + picture + ", cnn=" + cnn + ", stm=" + stm + ", pstm=" + pstm + ", rs=" + rs + '}';
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

    public void addgg(String emailString, int per, String fname, String lname, String email, String picture) {
        try {
            String strAdd = "insert into Account (AccountName,Permission,Firtname,Lastname,email,AccountImg) values (?,?,?,?,?,?)";
            pstm = cnn.prepareStatement(strAdd);
            pstm.setString(1, emailString);
            pstm.setInt(2, per);
            pstm.setString(3, fname);
            pstm.setString(4, lname);
            pstm.setString(5, email);
            pstm.setString(6, picture);
            pstm.execute();
        } catch (Exception e) {
            System.out.println("addgg:" + e.getMessage());

        }
    }

    public UserGG checkAccountGG(String accountname) {
        try {
            String strSelect = "select * from Account "
                    + "where [AccountName] = ? ";

            pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, accountname);
            rs = pstm.executeQuery();
            while (rs.next()) {
                String id = rs.getString(2);
                String per = rs.getString(4);
                String given_name = rs.getString(5);
                String family_name = rs.getString(6);
                String email = rs.getString(7);
                String picture = rs.getString(10);
                return new UserGG(id, per, email, verified_name, name, given_name, family_name, picture);
            }
        } catch (Exception e) {
            System.out.println("listAccount:" + e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        UserGG u = new UserGG();
//        u.addgg("ngoc123", 1, "tran", "ngoc", "tranngoc123@","daddada@awdadwadawd.dawdadw");
//        System.out.println(u);

    }
}
