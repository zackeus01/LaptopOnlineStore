package Model;
//import java.servlet.http.HttpSession;

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
public class Account {
//    HttpSession session = createSession();

    int acId;
    String acname, pass, per, fname, lname, email;
    String addres, phone;

    public String getAddres() {
        return addres;
    }

    public void setAddres(String addres) {
        this.addres = addres;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Account() {
        connect();
    }

    public Account(String acname, String pass, String per, String fname, String lname, String email) {
        this.acname = acname;
        this.pass = pass;
        this.per = per;
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        connect();

    }

    public Account(int acId, String acname, String pass, String per, String fname, String lname, String addres, String phone, String email) {
        this.acId = acId;
        this.acname = acname;
        this.pass = pass;
        this.per = per;
        this.fname = fname;
        this.lname = lname;
        this.addres = addres;
        this.phone = phone;
        this.email = email;
        connect();
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

    public int getAcId() {
        return acId;
    }

    public void setAcId(int acId) {
        this.acId = acId;
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

    public Account checkAccount(String username, String password) {
        try {
            String strSelect = " DECLARE @inputPassword NVARCHAR(100) = ?;\n"
                    + "SELECT *\n"
                    + "FROM Account\n"
                    + "WHERE AccountName = ? AND Pass = HASHBYTES('SHA2_256', @inputPassword);";
            pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, password);
            pstm.setString(2, username);
            rs = pstm.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5), rs.getString(6), rs.getString(9), rs.getString(8), rs.getString(7));
            }
        } catch (Exception e) {

        }
        return null;
    }

    public void add(String fnamee, String lnamee, String emaill, String per, String acnamee, String passs) {
        try {
            String strAdd = "insert into Account (AccountName,Pass,Permission,Firtname,Lastname,email) values (?,HASHBYTES('SHA2_256',?),?,?,?,?)";

            pstm = cnn.prepareStatement(strAdd);
            pstm.setString(1, acnamee);
            pstm.setString(2, passs);
            pstm.setString(3, per);
            pstm.setString(4, fnamee);
            pstm.setString(5, lnamee);
            pstm.setString(6, emaill);
            pstm.execute();
        } catch (Exception e) {
            System.out.println("add:" + e.getMessage());
        }
    }

    public void changePass(String passs, String acnamee) {
        try {
            String strDelete = "update Account set pass= HASHBYTES('SHA2_256',?) where [AccountName] = ?";

            pstm = cnn.prepareStatement(strDelete);
            pstm.setString(1, passs);
            pstm.setString(2, acnamee);
            pstm.execute();
        } catch (Exception e) {
            System.out.println("changePass:" + e.getMessage());
        }
    }

    public Account checkPermisson(String username, String password, String per) {
        try {
            String strSelect = "select * from Account where [AccountName] = ? and Pass= HASHBYTES('SHA2_256',?) and Permission= ?";
            pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, username);
            pstm.setString(2, password);
            pstm.setString(3, per);
            rs = pstm.executeQuery();
            while (rs.next()) {
                return new Account(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6));
            }
        } catch (Exception e) {

        }
        return null;
    }

    public Account checkEmail(String emaill) {
        try {
            String strSelect = "select * from Account where  email = ? ";
            pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, emaill);
            rs = pstm.executeQuery();
            while (rs.next()) {
                return new Account(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6));
            }
        } catch (Exception e) {

        }
        return null;
    }

    public Account listAccount(String username) {
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
                return new Account(acname, pass, per, fname, lname, email);

            }
        } catch (Exception e) {
            System.out.println("listAccount:" + e.getMessage());
        }
        return null;
    }
//    public static void main(String[] args) {
//        Account a = new Account();
//        System.out.println(a.checkAccount("Quang", "Iloveanime1@"));
//    }

}
