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
 * @author ADMIN
 */
public class Account3 {

    String acname, pass, per, fname, lname, email, phone, address, accimg;
    int accid;

    public Account3() {
        connect();
    }

    public Account3(String acname, String pass, String per, String fname, String lname, String email, String phone, String address) {
        this.acname = acname;
        this.pass = pass;
        this.per = per;
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.phone = phone;
        this.address = address;
        connect();

    }

    public Account3(String acname, String pass, String fname, String lname, String email, String phone, String address, String accimg, int accid) {
        this.acname = acname;
        this.pass = pass;
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.accimg = accimg;
        this.accid = accid;
    }

    public Account3(String fname, String lname, String email, String phone, String address, String accimg) {
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.accimg = accimg;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAcname() {
        return acname;
    }

    public void setAcname(String acname) {
        this.acname = acname;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getPer() {
        return per;
    }

    public void setPer(String per) {
        this.per = per;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAccimg() {
        return accimg;
    }

    public void setAccimg(String accimg) {
        this.accimg = accimg;
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

    public void add(String acnamee, String passs, String per, String fnamee, String lnamee, String emaill, String phonee, String addresss) {
        try {
            String strAdd = "insert into Account (AccountName,Pass,Permission,Firtname,Lastname,email,NumberPhone,addres) values (?,HASHBYTES('SHA2_256',?),?,?,?,?,?,?)";

            pstm = cnn.prepareStatement(strAdd);
            pstm.setString(1, acnamee);
            pstm.setString(2, passs);
            pstm.setString(3, per);
            pstm.setString(4, fnamee);
            pstm.setString(5, lnamee);
            pstm.setString(6, emaill);
            pstm.setString(7, phonee);
            pstm.setString(8, addresss);
            pstm.execute();
        } catch (Exception e) {
            System.out.println("add:" + e.getMessage());

        }
    }

    public Account3 getAccountByAcId(int accid) {
         Account3 acc = new Account3();
        try {
            String stm = "select AccountID, AccountName, Pass, FirtName, LastName, email, NumberPhone, addres, AccountImg from Account where AccountID=?";

            pstm = cnn.prepareStatement(stm);
            pstm.setInt(1, accid);
            rs = pstm.executeQuery();
            String acname, pass, fname, lname, email, phone, address, accimg;
            int acid;
            while (rs.next()) {
                acid = rs.getInt("AccountID");
                acname = rs.getString("AccountName");
                pass = rs.getString("Pass");
                fname = rs.getString("Firtname");
                lname = rs.getString("Lastname");
                email = rs.getString("email");
                phone = rs.getString("NumberPhone");
                address = rs.getString("addres");
                accimg = rs.getString("AccountImg");
                acc = new Account3(acname, pass, fname, lname, email, phone, address, accimg, accid);
            }
        } catch (Exception e) {
            System.out.println("add:" + e.getMessage());

        }       
        return acc;
    }
     public String getAccountChangePass(int accid) {
         String acname = null;
        try {
            String stm = "select  AccountName from Account where AccountID=?";
            pstm = cnn.prepareStatement(stm);
            pstm.setInt(1, accid);
            rs = pstm.executeQuery();      
            while (rs.next()) {             
                acname = rs.getString("AccountName");                           
            }
        } catch (Exception e) {
            System.out.println("add:" + e.getMessage());

        }       
        return acname;
    }
     public int UpdateProfile(int accid, Account3 a) {
         int row = 0;
        try {
            String strDelete = "update Account set FirtName=?, LastName=?, email=?, NumberPhone=?, AccountImg=?, addres=? where AccountID = ?";

            pstm = cnn.prepareStatement(strDelete);
            pstm.setString(1, a.getFname());
            pstm.setString(2, a.getLname());
            pstm.setString(3, a.getEmail());
            pstm.setString(4, a.getPhone());
            pstm.setString(5, a.getAccimg());
            pstm.setString(6, a.getAddress());
            pstm.setInt(7, accid);
           row=  pstm.executeUpdate();
        } catch (Exception e) {
            System.out.println("changeProfile:" + e.getMessage());
        }
        return row;
    }
 public int UpdatePassWord(int accid, String pass) {
         int row = 0;
        try {
            String strDelete = "update Account set Pass = HASHBYTES('SHA2_256',?) where AccountID = ?";

            pstm = cnn.prepareStatement(strDelete);
            pstm.setString(1, pass);
            pstm.setInt(2, accid);         
           row=  pstm.executeUpdate();
        } catch (Exception e) {
            System.out.println("changePass:" + e.getMessage());
        }
        return row;
    }
//    public static void main(String[] args) {
//        Account3 a = new Account3();
//      a.UpdatePassWord(2, "Ngoc123456$");
//    }

    public Account3 listAccount(String username) {
        try {
            String strSelect = "select * from Account "
                    + "where [AccountName] = ? ";

            pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, username);
            rs = pstm.executeQuery();
            while (rs.next()) {
                String acname = rs.getString(1);
                String pass = rs.getString(2);
                String per = rs.getString(3);
                String fname = rs.getString(4);
                String lname = rs.getString(5);
                String email = rs.getString(6);
                String phone = rs.getString(7);
                String address = rs.getString(8);
                return new Account3(acname, pass, per, fname, lname, email, phone, address);

            }
        } catch (Exception e) {
            System.out.println("listAccount:" + e.getMessage());
        }
        return null;
    }
//    public static final String PASSWORD_PATTERN = "((?=.*d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!.#$@_+,?-]).{8,50})"; 
//    public static final String PASSWORD_PATTERN ="^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#&()–[{}]:;',?/*~$^+=<>]).{8,20}$";
//    public static void main(String[] args) {
//       Account3 a = new Account3();
//       a.UpdatePassWord(1, "123");
//    }
}