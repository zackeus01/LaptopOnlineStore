/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.Cart;
import Model.Pagination;
import Model.Product;
import Model.ProductDAO;
import Model.ProductDisplay;
import Model.ProductDisplayDAO;
import Model.ProductTypeDAO;
import Model.Supplier;
import Model.SupplierDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author khang
 */
public class ShopController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Pagination Page;
        String selectedBrand = request.getParameter("brand");
        String minPrice = request.getParameter("minprice");
        String maxPrice = request.getParameter("maxprice");
        ProductDAO pDao = new ProductDAO();
        ProductTypeDAO ptDao = new ProductTypeDAO();
        List<Cart> carts = (List<Cart>) session.getAttribute("Cart");

        if (selectedBrand != null) {
            ProductDisplayDAO pdDao = new ProductDisplayDAO();
            List<ProductDisplay> product = pdDao.getProductByPrice(Integer.parseInt(selectedBrand), Double.parseDouble(minPrice), Double.parseDouble(maxPrice));

            session.setAttribute("shopProduct", product);
            //seting pagination
            Page = new Pagination(product.size(), 9, 1);
            session.setAttribute("page", Page);
            session.setAttribute("page", Page);

        }
        if (request.getParameter("addToCart") != null) {
            boolean isUpdateCart = false;
            if (session.getAttribute("acc") != null) {
                String seri = request.getParameter("seri");
                Product p = pDao.getProductBySeri(seri);
                String pName = ptDao.getProductNameByPid(p.getPid());
                if (carts == null) {
                    carts = new ArrayList<>();
                    carts.add(new Cart(seri, pName, p.getImg(), 1, p.getPrice()));
                } else {
                    //check if product exist in Cart
                    for (Cart c : carts) {
                        if (c.getSeri().equals(seri) && !isUpdateCart) {
                            isUpdateCart = true;
                            int newQty = c.getQuantity() + 1;
                            c.setQuantity(newQty);
                        }
                    }
                    //if not add a new cart item
                    if (!isUpdateCart) {
                        carts.add(new Cart(seri, pName, p.getImg(), 1, p.getPrice()));
                    }
                }
                session.setAttribute("Cart", carts);

                response.sendRedirect("shop");
            } else {
                response.sendRedirect("Login.jsp");
            }
        } else {
            request.getRequestDispatcher("Shop.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        SupplierDAO supDao = new SupplierDAO();
        ProductDisplayDAO pdDao = new ProductDisplayDAO();
        Pagination Page;

        //Get Lists
        List<ProductDisplay> product;
        List<Supplier> sup = supDao.getSupplier();
        List<ProductDisplay> topSell = pdDao.getTopSelling();
        List<Cart> carts = (List<Cart>) session.getAttribute("Cart");

        //Setting product
        if (request.getParameter("all") == null && session.getAttribute("shopProduct") != null) {
            product = (List<ProductDisplay>) session.getAttribute("shopProduct");
        } else {
            product = pdDao.getAllProductDisplay();
        }

        //seting pagination
        if (request.getParameter("all") != null || session.getAttribute("page") == null) {
            Page = new Pagination(product.size(), 9, 1);
            session.setAttribute("page", Page);
        } else if (request.getParameter("cp") != null) {
            int cp = Integer.parseInt(request.getParameter("cp"));
            Page = new Pagination(product.size(), 9, cp);
            session.setAttribute("page", Page);
        }

        //Set attribute
        session.setAttribute("sup", sup);
        session.setAttribute("Cart", carts);
        session.setAttribute("shopProduct", product);
        session.setAttribute("topSell", topSell);

        request.getRequestDispatcher("Shop.jsp").forward(request, response);
    }

}
