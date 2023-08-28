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
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author khang
 */
@WebServlet(name = "HomeController ", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        SupplierDAO supDao = new SupplierDAO();
        ProductDAO pDao = new ProductDAO();
        ProductTypeDAO ptDao = new ProductTypeDAO();
        List<Cart> carts = (List<Cart>) session.getAttribute("Cart");

//        List<Supplier> supList = supDao.getAllSupplier();
//        session.setAttribute("supList", supList);
        //btn add to cart click
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

                response.sendRedirect("home");
            } else {
                response.sendRedirect("Login.jsp");
            }
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        SupplierDAO supDao = new SupplierDAO();
        ProductDisplayDAO pdDao = new ProductDisplayDAO();
        NewsGroup a = new NewsGroup();
        ArrayList<NewsGroup> aaa = a.listNew1();
        ArrayList<NewsGroup> aa = a.listNew();
        request.setAttribute("aa", aa);
        request.setAttribute("aaa", aaa);

        //Get Lists
        List<Supplier> supList = supDao.getAllSupplier();
        int idSupSelect = 1;
        List<ProductDisplay> product;
        List<ProductDisplay> topSell = pdDao.getTopSelling();
        List<Cart> carts = (List<Cart>) session.getAttribute("Cart");

        //setting cart
//        if (session.getAttribute("acc") != null) {
//            Account acc = (Account) session.getAttribute("acc");
//            if (cartDao.getCartByAccount(acc.getAcId()) != null) {
//                List<Cart> carts = cartDao.getCartByAccount(acc.getAcId());
//                session.setAttribute("Cart", carts);
//            }
//        }
        //Select Supplier
        if (request.getParameter("supSelect") != null) {
            idSupSelect = Integer.parseInt(request.getParameter("supSelect"));
        }
        product = pdDao.getNewestProductByCate(idSupSelect);
        request.setAttribute("ss", idSupSelect);

        //Set attribute
        session.setAttribute("supList", supList);
        request.setAttribute("ss", idSupSelect);
        session.setAttribute("product", product);
        session.setAttribute("topSell", topSell);

        //Home Cart
        if (request.getParameter("del") != null) {
            String seri = request.getParameter("seri");
            List<Cart> itemsToRemove = new ArrayList<>();
            int count = 0;
            for (Cart c : carts) {
                if (c.getSeri().equals(seri)) {
                    itemsToRemove.add(c);
                }
                count++;
            }
            carts.removeAll(itemsToRemove);
            session.setAttribute("Cart", carts);
        }

        //redirect
//        if ((Account) session.getAttribute("acct") != null) {
//            Account acct = (Account) session.getAttribute("acct");
//            if (acct.getPer() != "customer") {
//                request.getRequestDispatcher("ProductManager.jsp").forward(request, response);
//            } else {
        request.getRequestDispatcher("Home.jsp").forward(request, response);
//            }
//        } else {
//            request.getRequestDispatcher("Home.jsp").forward(request, response);
//        }
    }

}
