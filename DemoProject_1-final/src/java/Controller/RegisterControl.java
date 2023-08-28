/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Account;
import Model.Account3;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.regex.Pattern;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "RegisterControl", urlPatterns = {"/registerr"})
public class RegisterControl extends HttpServlet {

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
        String user = request.getParameter("username");
        String pass = request.getParameter("pass");
        String repass = request.getParameter("repass");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String per = "1";
        Account3 acc = new Account3(user, pass, per, fname, lname, email, phone, address);

//        String[] checkbox = request.getParameterValues("checkbox");
        Pattern checkpass = Pattern.compile("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#&()–[{}]:;',?/*~$^+=<>]).{8,20}$");
//        Pattern checkphone = Pattern.compile("/(84|0[3|5|7|8|9])+([0-9]{8})\\b/g");
        Pattern checkemail = Pattern.compile("^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$");
        if (acc != null) {
            request.setAttribute("username", user);
            request.setAttribute("pass", pass);
            request.setAttribute("repass", repass);
            request.setAttribute("fname", fname);
            request.setAttribute("lname", lname);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            if (!pass.equals(repass)) {
//                request.setAttribute("acc", acc);
                request.setAttribute("mess3", "Re-entered password is incorrect!");
                request.getRequestDispatcher("Register.jsp").include(request, response);

            } else if (!checkemail.matcher(email).find()) {
//                request.setAttribute("acc", acc);
                request.setAttribute("mess4", "The email entered is not in the correct format!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);

            } else if (!checkpass.matcher(pass).find()) {
//                request.setAttribute("acc", acc);
                request.setAttribute("mess", "Password must be 8 - 20 characters long!");
                request.setAttribute("mess1", "Password must contain at least 1 lowercase character, 1 uppercase character and 1 number!");
                request.setAttribute("mess2", "Password must contain at least one special character like ! @ # & ( )...!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);

            } else {
                Account3 dao = new Account3();
                Account3 a = dao.listAccount(user);
                if (a != null) {
//                    request.setAttribute("acc", acc);
                    request.setAttribute("mess5", "Username already exists!");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);

                } else {
                    String error = "Register successfully!";
                    String errorr = "Back Login";
                    request.setAttribute("error", error);
                    request.setAttribute("errorr", errorr);
                    dao.add(user, pass, per, fname, lname, email, phone, address);
                    request.getRequestDispatcher("Register.jsp").forward(request, response);

                }
            }
        } else {
            request.setAttribute("username", null);
            request.setAttribute("pass", null);
            request.setAttribute("repass", null);
            request.setAttribute("fname", null);
            request.setAttribute("lname", null);
            request.setAttribute("email", null);
            request.setAttribute("phone", null);
            request.setAttribute("address", null);
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
        processRequest(request, response);
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
