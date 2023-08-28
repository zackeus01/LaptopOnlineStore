/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author win
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class InsertNewTypeProController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InsertNewTypeProController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InsertNewTypeProController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            ProductTypeDAO ptd = new ProductTypeDAO();
            ProductDAO pd = new ProductDAO();
            HttpSession session = request.getSession();
            Account acc = (Account) session.getAttribute("acc");
            String pname = request.getParameter("pname").trim();
            String ssid = request.getParameter("sid").trim();
            int sid = Integer.parseInt(ssid);
            String color = request.getParameter("color").trim();
            String ram = request.getParameter("ram").trim();
            String typecpu = request.getParameter("typecpu").trim();
            String cpu = typecpu + " " + request.getParameter("cpu").trim();
            String harddriver = request.getParameter("harddriver").trim();
            String screen = request.getParameter("screen").trim();
            String describe = request.getParameter("describe").trim();
            ProductType producttype = new ProductType(sid, pname, color, ram, cpu, harddriver, screen, describe);
            String seri = request.getParameter("seri").trim();
            int pid = ptd.getMaxProductID() + 1;
            String sprice = request.getParameter("price").trim().replace(",", "");
            float price = Float.parseFloat(sprice);
            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            Date credate = date;
            Date moddate = date;
            String creby = acc.getAcname();
            String modby = acc.getAcname();
            String ssell = request.getParameter("sell").trim();
            int sell = Integer.parseInt(ssell);
            String sguarantee = request.getParameter("guarantee").trim();
            int guarantee = Integer.parseInt(sguarantee);
            // Lấy đối tượng Part theo tên của input kiểu file
            String img;
            if (request.getPart("image") == null) {
                img = "NULL";
            } else {
                Part imagePart = request.getPart("image");
                // Lấy tên của file ảnh
                String fileName = imagePart.getSubmittedFileName();
                // Tạo một đường dẫn tuyệt đối của file ảnh trên server
                String savePath = "C:\\Users\\win\\Downloads\\DemoProject_1-final\\DemoProject_1-final\\web\\images"; // Giả sử có một thư mục images trên server
                String filePath = savePath + File.separator + fileName;
                // Kiểm tra xem thư mục images có tồn tại hay không và tạo nếu cần
                File saveDir = new File(savePath);
                if (!saveDir.exists()) {
                    saveDir.mkdir();
                }
                // Lưu file ảnh vào thư mục images trên server
                imagePart.write(filePath);
                img = "images/" + fileName;
            }
            Product p = new Product(seri, creby, modby, img, pid, guarantee, sell, price, credate, moddate);
            String msg;
        Connection conn = null;
        String user = "sa";
        String pass = "sa";
        String url = "jdbc:sqlserver://localhost:1433;databaseName=ProjectGroup5";
        try {
            // Kết nối đến cơ sở dữ liệu
            conn = DriverManager.getConnection(url, user, pass);

            // Vô hiệu hóa chế độ tự động commit
            conn.setAutoCommit(false);

            // Thực hiện các thao tác trong giao dịch
            ptd.insert(producttype, conn);
            pd.insert(p, conn);
            // Commit giao dịch
            conn.commit();

            msg = "Insert Successfull";
        } catch (SQLException e) {
            // Rollback giao dịch nếu có lỗi
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            msg = "Insert not Successfull";
        } finally {
            // Đóng kết nối
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
            request.setAttribute("msg", msg);
            request.getRequestDispatcher("addnewprod.jsp").forward(request, response);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
