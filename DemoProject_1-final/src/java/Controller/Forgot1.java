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
import java.io.IOException;

/**
 *
 * @author khang
 */
public class Forgot1 extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account a = new Account();

        String repass = req.getParameter("repass");
        String acnamee = req.getParameter("acname");
        String passs = req.getParameter("pass");

        if (passs.equals(repass)) {
            String error = "Change password successfully!";
            String errorr = "Back Login";
            req.setAttribute("error", error);
            req.setAttribute("errorr", errorr);
            a.changePass(passs, acnamee);
            req.getRequestDispatcher("Forgot1.jsp").forward(req, resp);
        } else {

            String mess = "Mat khau khong trung nhau";
            req.setAttribute("mess", mess);

            req.getRequestDispatcher("forgot.jsp").forward(req, resp);

        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
