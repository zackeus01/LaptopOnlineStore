/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Properties;
import java.util.UUID;
import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author khang
 */
public class Email extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

        // Kiểm tra tính hợp lệ của email ở đây (ví dụ: sử dụng regex)
        Account ac = new Account();

        Account a = ac.checkEmail(email);
        // Tạo mã xác nhận ngẫu nhiên
        if(a != null){
            String confirmationCode = generateConfirmationCode();

            // Lưu mã xác nhận vào cơ sở dữ liệu hoặc cấu trúc dữ liệu tạm thời (ví dụ: lưu vào ServletContext)
            getServletContext().setAttribute("confirmationCode", confirmationCode);

            // Gửi email chứa mã xác nhận
            sendConfirmationEmail(email, confirmationCode);

            // Chuyển hướng người dùng đến trang thay đổi mật khẩu
            resp.sendRedirect("Fogot.jsp");
        }else{
            String errol = "Mail khong co trong he thong.";
            req.setAttribute("errol", errol);
            req.getRequestDispatcher("Email.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    //Email:nguyenkhangdemo@gmail.com
    //Pass:gxbxfadxjnjvxrfp
    private String generateConfirmationCode() {
        // Triển khai mã xác nhận ngẫu nhiên ở đây (ví dụ: sử dụng UUID)
        return UUID.randomUUID().toString();
    }

    private void sendConfirmationEmail(String email, String confirmationCode) {
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
            message.setSubject("Confirm password reset.");
            message.setText("Code: " + confirmationCode);

            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
