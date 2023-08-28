/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author khang
 */
public class ProductController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        SupplierDAO supDao = new SupplierDAO();
        ProductTypeDAO ptDao = new ProductTypeDAO();
        ProductDAO pDao = new ProductDAO();
        ReviewDAO reDao = new ReviewDAO();

        Product p = new Product();
        ProductType pt = new ProductType();
        Pagination Page = new Pagination();
        List<String> images = new ArrayList<>();
        List<Review> reviews = new ArrayList<>();

        //Get product
        if (request.getParameter("seri") != null) {
            String seri = request.getParameter("seri");
            p = pDao.getProductBySeri(seri);
            pt = ptDao.getProductTypeByID(p.getPid());
            images = pDao.getProductImages(p.getPid());
            reviews = reDao.getReviewByPid(pt.getPid());
        }

        //seting pagination
        if (session.getAttribute("rpage") == null) {
            Page = new Pagination(reviews.size(), 3, 1);
            session.setAttribute("rpage", Page);
        } else if (request.getParameter("rcp") != null) {
            int rcp = Integer.parseInt(request.getParameter("rcp"));
            Page = new Pagination(reviews.size(), 3, rcp);
            session.setAttribute("rpage", Page);
        }

        //Set attributes
        session.setAttribute("p", p);
        session.setAttribute("pt", pt);
        session.setAttribute("images", images);
        session.setAttribute("reviews", reviews);

        //Add Review
        if (request.getParameter("addReview") != null) {
            if (request.getParameter("name") != "" && request.getParameter("email") != "" && request.getParameter("review") != "" && request.getParameter("rating") != "") {
                String seri = request.getParameter("seri");
                int pid = pDao.getProductIdBySeri(seri);
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String review = request.getParameter("review");
                int rating = Integer.parseInt(request.getParameter("rating"));
                LocalDateTime postTime = LocalDateTime.now();
                Review r = new Review(pid, name, email, review, rating, postTime);
                reDao.insert(r);
                String referer = "product?seri=" + seri;
                response.sendRedirect(referer);
            }
        } else {
            request.getRequestDispatcher("Product.jsp").forward(request, response);
        }

    }

}
