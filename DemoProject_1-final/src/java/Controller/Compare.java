/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.Product;
import Model.ProductCompare;
import Model.ProductDAO;
import Model.ProductDisplay;
import Model.ProductDisplayDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author khang
 */
public class Compare extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pidd = req.getParameter("seri");


        ProductCompare p = new ProductCompare();
        ProductCompare data = p.getListProductid(pidd);

        HttpSession session = req.getSession();

        session.setAttribute("detail", data);
        req.setAttribute("detail", data);
        req.getRequestDispatcher("Compare.jsp").forward(req, resp);

    }
    
    

}
