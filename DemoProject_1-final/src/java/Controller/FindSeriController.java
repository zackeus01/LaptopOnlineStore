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
import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 *
 * @author win
 */
@WebServlet(name = "FindSeriController", urlPatterns = {"/findSeri"})
public class FindSeriController extends HttpServlet {

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
            out.println("<title>Servlet FindSeriController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FindSeriController at " + request.getContextPath() + "</h1>");
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
        String seri = request.getParameter("seri");
        OrderDetailDAO odd = new OrderDetailDAO();
        OrderDAO od = new OrderDAO();
        ProductTypeDAO ptd = new ProductTypeDAO();
        ProductDAO pd = new ProductDAO();
        OrderDetail orderDetail = odd.getOrderBySeri(seri);
        Order order = od.getOrderByOrderID(orderDetail.getOrderID());
        String json;
        if (orderDetail.getFullname() == null) {
            orderDetail.setFullname("9999");
        }
            ProductType producttype = ptd.getProductTypeByID(orderDetail.getProductID());
            Product product = pd.getProductBySeri(orderDetail.getSeri());
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("orderDetail", new Gson().toJson(orderDetail));
            jsonObject.addProperty("order", new Gson().toJson(order));
            jsonObject.addProperty("producttype", new Gson().toJson(producttype));
            jsonObject.addProperty("product", new Gson().toJson(product));
            json = jsonObject.toString();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        // Gửi chuỗi JSON như phản hồi           
        out.print(json);
        out.flush();
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
