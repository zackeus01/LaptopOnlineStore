<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="com.vnpay.common.Config"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import ="Context.*" %>
<%@page import ="Model.*" %>
<%@page import="java.text.ParseException" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.sql.Date" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>VNPAY RESPONSE</title>
        <!-- Bootstrap core CSS -->
        <link href="/vnpay_jsp/assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->
        <link href="/vnpay_jsp/assets/jumbotron-narrow.css" rel="stylesheet"> 
        <script src="/vnpay_jsp/assets/jquery-1.11.3.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            body {
                padding-top: 20px;
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                color: #333;
            }

            .container1 {
                max-width: 800px;
                margin: 0 auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .header {
                margin-bottom: 20px;
            }

            .table-responsive {
                margin-bottom: 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                font-weight: bold;
            }

            a {
                color: #337ab7;
                text-decoration: none;
            }

            .lable{
                margin: 0% 10%;
                max-width: 100%;
            }
            table {
                width: 100%;
                margin-top: 3%;
            }

            th,
            td {
                width: 33.33%; /* Chia đều độ rộng cho 3 cột */
            }
            td{
                padding-top: 2%;
            }
            .button-container {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }
            .button{
                margin-top: 1%;
            }
            .button {
                display: inline-block;
                padding: 10px 20px;
                background-color: #337ab7;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                text-decoration: none;
                transition: background-color 0.3s ease;
            }

            .button:hover {
                background-color: #23527c;
            }

            .button a {
                color: #fff;
                text-decoration: none;
            }

            .button span {
                display: inline-block;
                padding: 0 10px;
            }

            .button:first-child {
                margin-right: 10px;
            }
        </style>
    </head>
    <body>
        <%
            //Begin process return from VNPAY
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
            List<Cart> cartsvnpay = new ArrayList<>();
            if (session.getAttribute("Cart") != null) {
            cartsvnpay = (List<Cart>) session.getAttribute("Cart");
        }
        String[] listseri = (String[]) session.getAttribute("listseri");
        %>
        <%@include file="HeaderHome.jsp" %>
        <!--Begin display -->
        <div class="container1">
            <div class="header clearfix">
                <h3 class="text-muted">Transaction information</h3>
            </div>
            <div class="table-responsive">
                <!--                <div class="form-group">
                                    <label >Merchant Transaction Code:</label>
                                    <label><%=request.getParameter("vnp_TxnRef")%></label>
                                </div>-->
                <div class="form-group" style="text-align: center;">
                    <%
                      if (signValue.equals(vnp_SecureHash)) {
                        if ("00".equals(request.getParameter("vnp_TransactionStatus"))) { 
                    %>
                    <h4 style="color:green">Payment success</h4>
                    <i class="fas fa-check-circle" style="color: green; font-size: 300%;"></i>
                    <%
                    }
                        else{
                    %>
                    <h4 style="color: red">Payment faild</h4>
                    <i class="fas fa-times-circle" style="color: red; font-size: 300%;"></i>
                    <%
                    } 
                    }
                    else{%>
                    <h4 style="color: red">Payment invalid signature</h4>
                    <i class="fas fa-times-circle" style="color: red; font-size: 300%;"></i>
                    <%
                        }
                    %>
                </div>
                <div class="form-group">
                    <table>
                        <th></th>
                        <th></th>
                        <th></th>
                    </table>
                    <table>
                        <%
                          ProductDAO pd1 = new ProductDAO();
                          ProductTypeDAO ptd1 = new ProductTypeDAO();
                          for(String seri : listseri){
                                        Product p = pd1.getProductBySeri(seri);
                                        ProductType pt = ptd1.getProductType(p.getPid());
                        %>

                        <tr>
                            <td><img src="<%= p.getImg()%>" alt="product" class="lable" style="max-height: 50%; max-width: 50%;"/></td>
                            <td><label class="lable"><%= pt.getPname()%></label></td>
                            <td> <label class="lable"><%= String.format("%,d", (int)p.getPrice())%> VND</label></td>
                        </tr>
                        <%}%>
                    </table>
                </div>
                <div class="form-group">
                    <table>
                        <th></th>
                        <th></th>
                        <th></th>
                    </table>
                    <table>
                        <tr>
                            <td><label>Tên Người Nhận</label></td>
                            <td><label class="lable"></label></td>
                            <td> <label class="lable"><%= (String) session.getAttribute("fullname")%></label></td>
                        </tr>
                        <tr>
                            <td><label>Địa chỉ</label></td>
                            <td><label class="lable"></label></td>
                            <td> <label class="lable"><%= (String) session.getAttribute("addres")%></label></td>
                        </tr>
                        <tr>
                            <td><label>Số điện thoại</label></td>
                            <td><label class="lable"></label></td>
                            <td> <label class="lable"><%= (String) session.getAttribute("phone")%></label></td>
                        </tr>
                    </table>
                </div>
                <div class="form-group">
                    <table>
                        <th></th>
                        <th></th>
                        <th></th>
                    </table>
                    <table>
                        <tr>
                            <td><label>Số tiền </label></td>
                            <td><label class="lable"></label></td>
                            <td> <label class="lable"><%= String.format("%,d", Integer.parseInt(request.getParameter("vnp_Amount"))) %> VND</label></td>
                        </tr>
                        <tr>
                            <td><label>Hình thức thanh toán</label></td>
                            <td><label class="lable"></label></td>
                            <td> <label class="lable"><%= request.getParameter("vnp_BankCode")%></label></td>
                        </tr>
                        <tr>
                            <td><label>Mã giao dịch</label></td>
                            <td><label class="lable"></label></td>
                            <td> <label class="lable"><%= request.getParameter("vnp_TransactionNo")%></label></td>
                        </tr>
                    </table>
                </div>

                <%
                    if (signValue.equals(vnp_SecureHash)) {
                        if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                        int OrderID = Integer.parseInt(request.getParameter("vnp_TxnRef"));
//                                    int OrderID = 99;
                        Account a = (Account) session.getAttribute("acc");
                        int CustomerID = a.getAcId();
                        double totalsum = (Double.parseDouble(request.getParameter("vnp_Amount")))/100;
                        int Status =0; 
                       String vnp_PayDate = request.getParameter("vnp_PayDate");
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                        java.util.Date utilDate = sdf.parse(vnp_PayDate);
                        java.sql.Date orderDate = new java.sql.Date(utilDate.getTime());
                        Order order = new Order(OrderID, CustomerID,orderDate, totalsum, Status);
                        String fullname = (String) session.getAttribute("fullname");
                        String addres = (String) session.getAttribute("addres");
                        String phone = (String) session.getAttribute("phone");
                        String email = a.getEmail();
                        ProductDAO pd = new ProductDAO();
                        ProductTypeDAO ptd = new ProductTypeDAO();
                        List<OrderDetail> odlist = new ArrayList<>();
                        for(String seri : listseri){
                        Product p = pd.getProductBySeri(seri);
                        int productID = p.getPid();
                        ProductType pt = ptd.getProductType(p.getPid());
                        String productName = pt.getPname();
                        String priceString = String.valueOf(p.getPrice());
                        double price = Double.parseDouble(priceString);
                        int quantity;
                        for(Cart c : cartsvnpay){
                        if(c.getSeri().equals(seri)) {
                        quantity = c.getQuantity();
                        OrderDetail orderdetail= new OrderDetail(OrderID, productID, quantity, fullname, addres,email, productName,seri, phone, price);
                        odlist.add(orderdetail);
                        break;
                            }
                        }
                        }
                        OrderDetailDAO odd = new OrderDetailDAO();
                        odd.InsertOrder(order, odlist);
                                
                         List<Cart> cartsToRemove = new ArrayList<>(); // Danh sách các phần tử cần xóa

                                    
                                for (String seri : listseri) {
                                    for (Cart c : cartsvnpay) {
                                        if (c.getSeri().equals(seri)) {
                                            cartsToRemove.add(c); // Thêm phần tử vào danh sách cần xóa
                                            break;
                                        }
                                    }
                                }
                                    

                            cartsvnpay.removeAll(cartsToRemove); // Xóa các phần tử đã lưu trong danh sách cần xóa khỏi danh sách carts
                         
                        // Cập nhật danh sách updatedCarts vào session
                        session.setAttribute("Cart", carts);

//                                    out.print("Success");
                        } else {
//                                    out.print("Failed");
                        }

                    } else {
//                                out.print("invalid signature");
                    }
                %>
                <div class="form-group button-container" style="align-items: center;">
                    <button class="button"><a href="home">
                            <span>Home</span>
                        </a></button>
                    <button class="button"> <a href="Cart.jsp">
                            <span>Shopping</span>
                        </a></button>
                </div>
            </div>
            <p>
                &nbsp;
            </p>
        </div>  
        <%@include file="Footer.jsp" %>
    </body>
</html>
