/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.Date;
import java.time.LocalDate;

/**
 *
 * @author win
 */
@WebServlet(name = "AddNewController", urlPatterns = {"/addnew"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class AddNewController extends HttpServlet {

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
            out.println("<title>Servlet AddNewController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewController at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
       String title = request.getParameter("title");
       String content = request.getParameter("content");
       String newurl = request.getParameter("newurl");
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
            String img = "images/" + fileName;
            String creby = a.getFname() +" "+ a.getLname();
            LocalDate currentDate = LocalDate.now();
        Date credate = Date.valueOf(currentDate);
        News n = new News(title, content, img, creby, newurl, credate);
       NewDAO nd = new NewDAO();
       int row = nd.AddNew(n);
       String msg ;
       if(row > 0){
           msg="Add New Successful";}
       else{
           msg="Add New Faild";
       }
       request.setAttribute("msg", msg);
       request.getRequestDispatcher("AddNews.jsp").forward(request, response);
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
