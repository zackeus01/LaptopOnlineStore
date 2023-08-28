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

/**
 *
 * @author khang
 */
public class RegisterController2 extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String fnamee = (String) session.getAttribute("firstName");
        String lnamee = (String) session.getAttribute("lastName");
        String emaill = (String) session.getAttribute("emaill");
        String per = "1";
        String acnamee = req.getParameter("acname");
        String passs = req.getParameter("pass");

        Account ac = new Account();
        if (passs.length() < 6) {
            // Xử lý khi mật khẩu không đáp ứng yêu cầu
            // Ví dụ: Hiển thị thông báo lỗi cho người dùng
            String errol = "Pass word hoac ";
            req.setAttribute("errol", errol);
            resp.sendRedirect("register2.jsp");
        } else if (!passs.matches(".*[A-Z].*")) {
            String errol = "Pass word hoac tk ";
            req.setAttribute("errol", errol);
            resp.sendRedirect("register2.jsp");
        } else if (!passs.matches(".*[^A-Za-z0-9].*")) {
            String errol = "Pass word hoac tk sai";
            req.setAttribute("errol", errol);
            resp.sendRedirect("register2.jsp");
        } else {
            ac.add(fnamee, lnamee, emaill, per, acnamee, passs);
            resp.sendRedirect("Home.jsp");
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

}
