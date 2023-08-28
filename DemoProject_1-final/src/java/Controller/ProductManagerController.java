/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.ProductTypeDAO;
import Model.ProductType;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import Context.*;
import java.util.List;

/**
 *
 * @author khang
 */
public class ProductManagerController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//                        req.getRequestDispatcher("ProductManager.jsp").forward(req, resp);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
//        ProductTypeDAO producttypedao = new ProductTypeDAO();
//        List<ProductType> listtype = producttypedao.getProductType();
//        request.setAttribute("list", listtype);
        request.getRequestDispatcher("ProductManager.jsp").forward(request, response);
    }
}
