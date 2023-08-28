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
import java.util.List;

/**
 *
 * @author CuK
 */
@WebServlet(name = "MyOrderController", urlPatterns = {"/myorder"})
public class MyOrderController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (req.getParameter("delAll") != null) {
            List<MyOrder> myOrder = (List<MyOrder>) session.getAttribute("myorder");
            session.setAttribute("myorder", null);
            session.setAttribute("myOrderSize", myOrder.size());
            resp.sendRedirect("MyOrder.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        ProductDAO pDao = new ProductDAO();
        ProductTypeDAO ptDao = new ProductTypeDAO();
        OrderDetailDAO od = new OrderDetailDAO();
        List<Cart> carts = (List<Cart>) session.getAttribute("Cart");
        if (req.getParameter("viewOrder") != null) {
            int accountId = Integer.parseInt(req.getParameter("accId"));
            System.out.println(accountId);
            List<MyOrder> myorder = new ArrayList<>();
            myorder = od.getOrderDetail(accountId);
            session.setAttribute("myOrderSize", myorder.size());
            session.setAttribute("myorder", myorder);
            resp.sendRedirect("MyOrder.jsp");
        }

        if (req.getParameter("delMyOrder") != null) {
            List<MyOrder> myOrder = (List<MyOrder>) session.getAttribute("myorder");
            String seri = req.getParameter("seri");
            List<MyOrder> itemsToRemove = new ArrayList<>();
            for (MyOrder c : myOrder) {
                if (c.getSeri().equals(seri)) {
                    itemsToRemove.add(c);
                }
            }
            myOrder.removeAll(itemsToRemove);
            od.deleteOrderDetails(seri);
            session.setAttribute("myOrderSize", myOrder.size());
            session.setAttribute("myorder", myOrder);
            resp.sendRedirect("MyOrder.jsp");
        }
        if (req.getParameter("reBuy") != null) {
            boolean isUpdateCart = false;
            if (session.getAttribute("acc") != null) {
                String seri = req.getParameter("seri");
                Product p = pDao.getProductBySeri(seri);
                String pName = ptDao.getProductNameByPid(p.getPid());
                if (carts==null) {
                    carts = new ArrayList<>();
                    carts.add(new Cart(seri, pName, p.getImg(), 1, p.getPrice()));
                }
                else {
                    //check if product exist in Cart
                    for (Cart c : carts) {
                        if (c.getSeri().equals(seri) && !isUpdateCart) {
                            isUpdateCart = true;
                            int newQty = c.getQuantity()+1;
                            c.setQuantity(newQty);
                        }
                    }
                    //if not add a new cart item
                    if(!isUpdateCart){
                        carts.add(new Cart(seri, pName, p.getImg(), 1, p.getPrice()));
                    }
                }
                session.setAttribute("Cart", carts);
                
                resp.sendRedirect("Cart.jsp");
            } else {
                resp.sendRedirect("Login.jsp");             
            }
        }

        
    }

}
