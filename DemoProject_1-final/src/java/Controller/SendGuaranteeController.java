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
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author win
 */
@WebServlet(name = "SendGuaranteeController", urlPatterns = {"/sendguarantee"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class SendGuaranteeController extends HttpServlet {

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
        Account a = (Account) session.getAttribute("acc");
        if (a == null) {
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("SendGuarantee.jsp").forward(request, response);
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
        ProductDAO pd = new ProductDAO();
        GuaranteeDAO gd = new GuaranteeDAO();
        OrderDetailDAO odd = new OrderDetailDAO();
        ProductTypeDAO ptd = new ProductTypeDAO();
        OrderDAO od = new OrderDAO();
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        String msg;
        String seri = request.getParameter("seri");
        String fullname = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String describe = request.getParameter("describe");
        String datebuy = request.getParameter("buy");
        String warrantyperiod = request.getParameter("period");
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        java.util.Date period = null;
        try {
            period = dateFormat.parse(warrantyperiod);
        } catch (ParseException ex) {
            Logger.getLogger(SendGuaranteeController.class.getName()).log(Level.SEVERE, null, ex);
        }
        Date sqlDate = new java.sql.Date(period.getTime());
        float expense = Float.parseFloat(request.getParameter("expense").replace(",", ""));
        String periodperson = a.getFname() + a.getLname();
        LocalDate currentDate = LocalDate.now();
        Date ReceivedDate = Date.valueOf(currentDate);
        LocalDate deliveryLocalDate = currentDate.plusDays(7);
        Date deliveryDate = Date.valueOf(deliveryLocalDate);
        Product p = pd.getProductBySeri(seri);
        int productID = p.getPid();
        int progress = 0;
        String pimg;
        // Lấy đối tượng Part theo tên của input kiểu file        
        // Lấy tên của file ảnh
        if (request.getPart("image") != null) {
            Part imagePart = request.getPart("image");
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
            pimg = "images/" + fileName;
        } else {
            pimg = "NULL";
        }
        int acoountID = od.getAccountIDBySeri(seri);
        int row = 0;
        Guarantee g = new Guarantee(acoountID, productID, progress, ReceivedDate, deliveryDate, seri, describe, periodperson, fullname, address, phone, email, pimg, expense);
        if (ReceivedDate.before(sqlDate)) {
            row = gd.insertGuarantee(g);
        } else {
            Random rnd = new Random();
            String chars = "0123456789";
            StringBuilder sb = new StringBuilder(8);
            for (int i = 0; i < 8; i++) {
                sb.append(chars.charAt(rnd.nextInt(chars.length())));
            }
            int OrderID = Integer.parseInt(sb.toString());
            Order o = new Order(OrderID, acoountID, ReceivedDate, expense, 99);
            double price = Double.parseDouble(request.getParameter("expense").replace(",", ""));
            String pname = ptd.getProductNameByPid(productID);
            OrderDetail orderdetail = new OrderDetail(OrderID, productID, 1, fullname, address, email, pname, seri, phone, price);
            List<OrderDetail> l = new ArrayList<>();
            l.add(orderdetail);
            odd.InsertOrder(o, l);
            row = 2;
        }
        if (row > 0) {
            msg = "Đã gửi bảo hành";
        } else {
            msg = "Gửi bảo hành lỗi";
        }
        int productGuarantee = gd.countRecordsByProductID(productID);
        int productSold = odd.countRecordsByProductID(productID);
        if (productGuarantee >= 1 && productSold >= 1) {
            String str = "Out of 100 products sold in the category " + ptd.getProductNameByPid(productID) + " there are more than 5 products warranty";
            String emailadmin = "tranngoc31012002@gmail.com";
            sendConfirmationEmail(emailadmin, str);
        }

        List<String> list = new ArrayList<>();
        list.add(datebuy);
        list.add(warrantyperiod);
        request.setAttribute("msg", msg);
        request.setAttribute("g", g);
        request.setAttribute("list", list);
        request.getRequestDispatcher("PrintGuarantee.jsp").forward(request, response);
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

    private void sendConfirmationEmail(String email, String str) {
        final String username = "nguyenkhangdemo@gmail.com";
        final String password = "gxbxfadxjnjvxrfp";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Announcement of products on sale");
            message.setText(str);

            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public void PrintInvoice() {

    }
}
