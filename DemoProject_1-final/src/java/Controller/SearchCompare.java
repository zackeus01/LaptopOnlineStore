/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author khang
 */
@WebServlet(name = "SearchCompare", urlPatterns = {"/searchcompare"})

public class SearchCompare extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String text = req.getParameter("keyword");
        HttpSession session = req.getSession();
        ProductCompare data = (ProductCompare) session.getAttribute("detail");
        ProductCompare p = new ProductCompare();

        ArrayList<ProductCompare> search = p.getListProductSearch(text);
        req.setAttribute("detail", data);
        req.setAttribute("data", search);
        req.getRequestDispatcher("Compare.jsp").forward(req, resp);

    }

}
