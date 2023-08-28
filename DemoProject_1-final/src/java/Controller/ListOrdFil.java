/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.OrderDetail2;
import Model.OrderDetailDAO2;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ListOrdFil", urlPatterns = {"/listordfil"})
public class ListOrdFil extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
       
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
        try ( PrintWriter out = response.getWriter()) {
            int day = Integer.parseInt(request.getParameter("day").trim());
            int month = Integer.parseInt(request.getParameter("month").trim());
            int year = Integer.parseInt(request.getParameter("year").trim());
//            
//            System.out.println(day);
//            System.out.println(month);
//            System.out.println(year);
            OrderDetailDAO2 oddao = new OrderDetailDAO2();
            OrderDetailDAO2 ordpd = new OrderDetailDAO2();
            List<Integer> listordid = oddao.getOrderIDbyDay(day, month, year);
            List<OrderDetail2> list = new ArrayList<>();
            for (Integer pt : listordid) {
                List<OrderDetail2> t = ordpd.getOrderDetail2ByOrderID(pt);
                for (OrderDetail2 p : t) {
                    list.add(p);
                }
            }
            OrderDetailDAO2 dao = new OrderDetailDAO2();
// Gọi hàm getTotalbyDate với các tham số day, month và year
            List<OrderDetail2> listt = dao.getTotalbyDate(day, month, year);
            HttpSession session = request.getSession();
// Gán danh sách vào session với tên là "totalList"
            session.setAttribute("totalList", listt);
            request.setAttribute("list", list);
            request.getRequestDispatcher("OrderDetail.jsp").forward(request, response);
            }
//        }
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
