/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.*;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Dinh Nguyen
 */
@WebServlet(name = "CartController ", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet cart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet cart at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        OrderDAO orderDao = new OrderDAO();
        OrderDetailDAO odDao = new OrderDetailDAO();
        List<Cart> carts = (List<Cart>) session.getAttribute("Cart");

        if (request.getParameter("del") != null) {
            String seri = request.getParameter("seri");
            List<Cart> itemsToRemove = new ArrayList<>();
            for (Cart c : carts) {
                if (c.getSeri().equals(seri)) {
                    itemsToRemove.add(c);
                }
            }
            carts.removeAll(itemsToRemove);
            session.setAttribute("Cart", carts);
            response.sendRedirect("home");
        }

        if (request.getParameter("delCart") != null) {
            String seri = request.getParameter("seri");
            List<Cart> itemsToRemove = new ArrayList<>();
            for (Cart c : carts) {
                if (c.getSeri().equals(seri)) {
                    itemsToRemove.add(c);
                }
            }
            carts.removeAll(itemsToRemove);
            session.setAttribute("Cart", carts);
            request.getRequestDispatcher("Cart.jsp").forward(request, response);
        }

        if (request.getParameter("btnViewCart") != null) {
            if (session.getAttribute("acc") != null) {
                response.sendRedirect("Cart.jsp");
            } else {
                response.sendRedirect("Login.jsp");
            }
        }
//        
        if (request.getParameter("update") != null) {
            String seri = request.getParameter("seri");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            float price = Float.parseFloat(request.getParameter("price"));
            for (Cart c : carts) {
                if (c.getSeri().equals(seri)) {
                    c.setQuantity(quantity);
                }
            }
            float totalPrice = price * quantity;
            session.setAttribute("Cart", carts);
            session.setAttribute("totalPrice", totalPrice);
            request.getRequestDispatcher("Cart.jsp").forward(request, response);
//            response.sendRedirect("Cart.jsp");
        }

        if (request.getParameter("btnDelAll") != null) {
            session.setAttribute("Cart", null);
            request.getRequestDispatcher("Cart.jsp").forward(request, response);
        }

        if (request.getParameter("delSmall") != null) {
            String seri = request.getParameter("seri");
            String referer = request.getHeader("referer");
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
            //redirect
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                // If no referer is available, redirect to a default page
                response.sendRedirect("home");
            }
        }

//        if (request.getParameter("btnCheckOut") != null) {
//            int aid = Integer.parseInt(request.getParameter("aid"));
//            List<Cart> carts = (List<Cart>) session.getAttribute("Cart");
//            orderDao.addOrder(aid, carts);
//            odDao.addOrderDetail(carts);
//            cartDao.DelCartByAccountId(aid);
//            session.setAttribute("Cart", null);
//            response.sendRedirect("home");
//        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ProductDAO pDao = new ProductDAO();
        ProductTypeDAO ptDao = new ProductTypeDAO();
        List<Cart> carts = (List<Cart>) session.getAttribute("Cart");
        String referer = request.getHeader("referer");

        // btn add to cart click
        if (request.getParameter("addToCart") != null) {
            boolean isUpdateCart = false;
            if (session.getAttribute("acc") != null) {
                String seri = request.getParameter("seri");
                Product p = pDao.getProductBySeri(seri);
                String pName = ptDao.getProductNameByPid(p.getPid());
                String quantityParam = request.getParameter("quantity");
                int quantity;

                // get Quantity
                if (quantityParam != null && !quantityParam.isEmpty()) {
                    quantity = Integer.parseInt(quantityParam);
                } else {
                    // Handle the case when quantity is not provided
                    quantity = 1; // Set a default value or handle the error appropriately
                }

                // If cart has nothing yet
                if (carts == null) {
                    carts = new ArrayList<>();
                    carts.add(new Cart(seri, pName, p.getImg(), quantity, p.getPrice()));
                } else {
                    // Check if product exists in Cart
                    for (Cart c : carts) {
                        if (c.getSeri().equals(seri) && !isUpdateCart) {
                            isUpdateCart = true;
                            int newQty = c.getQuantity() + quantity;
                            c.setQuantity(newQty);
                        }
                    }
                    // If not, add a new cart item
                    if (!isUpdateCart) {
                        carts.add(new Cart(seri, pName, p.getImg(), quantity, p.getPrice()));
                    }
                }

                // Set session's Cart
                session.setAttribute("Cart", carts);

                // Get the updated cart HTML
                String cartHTML = getUpdatedCartHTML(carts); // Implement this method to generate the cart HTML

                // Return the updated cart HTML as the response
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(cartHTML);
//                response.sendRedirect("cartDropdown.jsp");
            }
        } // btn add to cart
    }

    private String getUpdatedCartHTML(List<Cart> carts) {
        MyFormatter fm = new MyFormatter();
        StringBuilder cartHTML = new StringBuilder();
        float total = 0;

        // Check if carts is not null and not empty
        if (carts != null && !carts.isEmpty()) {
            cartHTML.append("<div class=\"cart-list\">");
            for (Cart c : carts) {
                total += c.getQuantity() * c.getPrice();
                // Append HTML for each cart item
                cartHTML.append("<div class=\"product-widget\">");
                cartHTML.append("<div class=\"product-img\">");
                cartHTML.append("<img src=\"").append(c.getImg()).append("\" alt=\"\">");
                cartHTML.append("</div>");
                cartHTML.append("<div class=\"product-body\">");
                cartHTML.append("<h3 class=\"product-name\"><a href=\"#\">").append(c.getpName()).append("</a></h3>");
                cartHTML.append("<h4 class=\"product-price\"><span class=\"qty\">").append(c.getQuantity()).append("x</span>").append(fm.formatPrice(c.getPrice())).append("</h4>");
                cartHTML.append("</div>");
                cartHTML.append("<a href=\"cart?seri=").append(c.getSeri()).append("&delSmall=1\"><button name=\"delSmall\" class=\"delete\"><i class=\"fa fa-close\"></i></button></a>");
                cartHTML.append("</div>");
            }
        } else {
            // Append HTML for empty cart
            cartHTML.append("<div class=\"empty-cart-notification\">");
            cartHTML.append("Your cart is empty!");
            cartHTML.append("</div>");
        }
        cartHTML.append("</div>");
        cartHTML.append("<div class=\"cart-summary\">");
        cartHTML.append("<small>").append(carts.size()).append(" Item(s) selected</small>");
        cartHTML.append("<h5>SUBTOTAL: ").append(fm.formatPrice(total)).append("</h5>");
        cartHTML.append("</div>");
        cartHTML.append("<div class=\"cart-btns\">");
        cartHTML.append("<a href=\"cart?btnViewCart=1\">View Cart</a>");
        cartHTML.append("<a href=\"#\">Checkout <i class=\"fa fa-arrow-circle-right\"></i></a>");
        cartHTML.append("</div>");

        // Return the generated HTML as a string
        return cartHTML.toString();
    }

}
