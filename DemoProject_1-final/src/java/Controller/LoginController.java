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
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String username = req.getParameter("acname");
        String password = req.getParameter("pass");
        String per = "2";
        Account ac = new Account();

        Account a = ac.checkAccount(username, password);
        int accountId = (a != null) ? a.getAcId() : -1; // Set accountId to -1 if account is not found

        if (a != null) {
            Account at = ac.checkPermisson(username, password, per);
            if (at != null) {
                Account data = ac.listAccount(username);
                session.setMaxInactiveInterval(1000);
                session.setAttribute("accId", accountId);
                session.setAttribute("acc", a);
                session.setAttribute("acct", at);
                session.setAttribute("data", data);
                resp.sendRedirect("home");
            } else {
                session.setMaxInactiveInterval(1000);
                session.setAttribute("accId", accountId);
                session.setAttribute("acc", a);
                resp.sendRedirect("home");
            }
        } else {
            String error = "Invalid username or password";
            req.setAttribute("error", error);
            req.getRequestDispatcher("Login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

}
