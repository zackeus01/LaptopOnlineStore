/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author khang
 */
public class Fogot extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
//        String newPassword = req.getParameter("newPassword");

        // Kiểm tra mã xác nhận và mật khẩu mới

        // Lấy mã xác nhận từ ServletContext
        String confirmationCode = (String) getServletContext().getAttribute("confirmationCode");

        if (confirmationCode != null && confirmationCode.equals(code)) {
            // Xác nhận mã xác nhận thành công
            // Thực hiện thay đổi mật khẩu (ví dụ: lưu vào cơ sở dữ liệu)

            // Reset mã xác nhận trong ServletContext
            getServletContext().removeAttribute("confirmationCode");

            // Chuyển hướng người dùng đến trang thành công
            resp.sendRedirect("Forgot1.jsp");
        } else {
            // Mã xác nhận không hợp lệ
            // Chuyển hướng người dùng đến trang lỗi
            resp.sendRedirect("Email.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
    
    
    
}
