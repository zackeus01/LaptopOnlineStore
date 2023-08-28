///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package Controller;
//
//import Model.UserGG;
//import com.google.gson.Gson;
//import com.google.gson.JsonObject;
//import jakarta.servlet.RequestDispatcher;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import javax.mail.Session;
//import org.apache.http.client.ClientProtocolException;
//import org.apache.http.client.fluent.Form;
//import org.apache.http.client.fluent.Request;
//
///**
// *
// * @author ADMIN
// */
//@WebServlet(name = "LoginGG", urlPatterns = {"/LoginGG"})
//public class LoginGG extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String code = request.getParameter("code");
//        String accessToken = getToken(code);
//        UserGG user = getUserInfo(accessToken);
//        String fname = user.getGiven_name();
//        String lname = user.getFamily_name();
//        String email = user.getEmail();
//        String img = user.getPicture();
//        String id = user.getId();
//        System.out.println(user);
//        System.out.println(code);
//        System.out.println(fname);
//        System.out.println(id);
//        System.out.println(lname);
//        System.out.println(email);
//        int per =1;
//        UserGG usergg = new UserGG();
//        if (code == null || code.isEmpty()) {
//            request.getRequestDispatcher("Register.jsp").include(request, response);
//        } else {
//            
//            UserGG agg = usergg.checkAccountGG(email);
//            if (agg != null) {
//                System.out.println(agg);
////            user.addgg(email, per, fname, lname, email, img);
//                request.getRequestDispatcher("Home.jsp").include(request, response);
////                request.getRequestDispatcher("index.jsp");
//            } else {
//                user.addgg(email, per, fname, lname, email, img);
//                
//                request.getRequestDispatcher("Home.jsp").include(request, response);
//            }
//        }
//    }
//
//    public static String getToken(String code) throws ClientProtocolException, IOException {
//        // call api to get token
//        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
//                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
//                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
//                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
//                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
//                .execute().returnContent().asString();
//
//        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
//        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
//        return accessToken;
//    }
//
//    public static UserGG getUserInfo( String accessToken) throws ClientProtocolException, IOException {
//        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
//        String response = Request.Get(link).execute().returnContent().asString();
//        UserGG user = new Gson().fromJson(response, UserGG.class);
//        return user;
//    }
//
//// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
