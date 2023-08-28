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
import Model.*;
import java.util.List;

/**
 *
 * @author win
 */
@WebServlet(name = "SearchGuaranteeController", urlPatterns = {"/searchGuarantee"})
public class SearchGuaranteeController extends HttpServlet {

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
            out.println("<title>Servlet SearchGuaranteeController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchGuaranteeController at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();
        GuaranteeDAO gd = new GuaranteeDAO();
        int progress = Integer.parseInt(request.getParameter("progress"));
        if (progress == -1) {
            request.getRequestDispatcher("guaranteeAdmin").forward(request, response);
        } else if (progress == 4) {
            List<Guarantee> listguarantee = gd.getGuaranteeByDate();
            request.setAttribute("listguarantee", listguarantee);
            request.getRequestDispatcher("GuaranteeAdmin.jsp").forward(request, response);
        } else {
            List<Guarantee> listguarantee = gd.getGuaranteeByProgress(progress);
            request.setAttribute("listguarantee", listguarantee);
            request.getRequestDispatcher("GuaranteeAdmin.jsp").forward(request, response);
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
        GuaranteeDAO gd = new GuaranteeDAO();
        String name = request.getParameter("name");
        List<Guarantee> listguarantee = gd.getGuaranteeByName(name);
        request.setAttribute("listguarantee", listguarantee);
        request.getRequestDispatcher("GuaranteeAdmin.jsp").forward(request, response);
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
