/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Model.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;

/**
 *
 * @author win
 */
@WebServlet(name = "MyAccountController", urlPatterns = {"/myaccount"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class MyAccountController extends HttpServlet {

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
            out.println("<title>Servlet MyAccountController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MyAccountController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        PrintWriter out = response.getWriter();
        if (acc == null) {
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        } else {
            request.getRequestDispatcher("MyAccount.jsp").forward(request, response);
            return;
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
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        Account3 acc = new Account3();
        PrintWriter out = response.getWriter();
//       String img = request.getParameter("accimg").trim();
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String img;
        if (request.getPart("accimg") == null) {
            img = acc.getAccountByAcId(a.getAcId()).getAccimg();
        } else {
            Part imagePart = request.getPart("accimg");
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
        Account3 ac = new Account3(fname, lname, email, phone, address, img);
        int row = acc.UpdateProfile(a.getAcId(), ac);
        String msg1 = null, msg2 = null;
        if (row > 0) {
            msg1 = "Update Successful";
        } else {
            msg2 = "Update not Successful";
        }
//        Account3 account = acc.getAccountByAcId(a.getAcId());
        request.setAttribute("msg1", msg1);
        request.setAttribute("msg2", msg2);
        request.getRequestDispatcher("MyAccount.jsp").forward(request, response);
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
