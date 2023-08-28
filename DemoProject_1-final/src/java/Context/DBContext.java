/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Context;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.eclipse.jdt.internal.compiler.batch.Main;

/**
 *
 * @author khang
 */
public class DBContext {
    
    public Connection connection;

    public DBContext() {
        //@Students: You are allowed to edit user, pass, url variables to fit 
        //your system configuration
        //You can also add more methods for Database Interaction tasks. 
        //But we recommend you to do it in another class
        // For example : StudentDBContext extends DBContext , sakldjlaksjdkla
        //where StudentDBContext is located in dal package, ?kdhajkshdkashjd
        try {
            String user = "sa";
            String pass = "sa";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=ProjectGroup5";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void main(String[] args) {
        DBContext dbContext = new DBContext();
        
        // Kiểm tra kết nối cơ sở dữ liệu
        if (dbContext.connection != null) {
            System.out.println("Kết nối thành công đến cơ sở dữ liệu.");
        } else {
            System.out.println("Kết nối không thành công đến cơ sở dữ liệu.");
        }
        
        // Thực hiện các thao tác với cơ sở dữ liệu tại đây
        
        // Đóng kết nối cơ sở dữ liệu
        try {
            if (dbContext.connection != null) {
                dbContext.connection.close();
                System.out.println("Đã đóng kết nối cơ sở dữ liệu.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
