<%-- 
    Document   : CheckOut
    Created on : Jun 8, 2023, 8:31:37 PM
    Author     : win
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "Context.*" %>
<%@page import = "Model.*" %>
<%@page import= "java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/stylecheckout.css" rel="stylesheet">
        <link href="assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->
        <link href="assets/jumbotron-narrow.css" rel="stylesheet">      
        <script src="assets/jquery-1.11.3.min.js"></script>
    </head>
    <%
        List<Cart> carts = new ArrayList<>();
        if (session.getAttribute("Cart") != null) {
            carts = (List<Cart>) session.getAttribute("Cart");
        }
        String[] listseri = (String[]) session.getAttribute("listseri");
    %>
    <body>
        <div style="align-items: center; display: flex;justify-content: center;">
            <div class='window' >
                <div class='order-info'>
                    <div class='order-info-content'>
                        <h2>Order Summary</h2>
                        <%
 ProductTypeDAO ptd = new ProductTypeDAO();
 ProductType pt = new ProductType();
 int totalPrice = 0;

 // Lặp qua danh sách sản phẩm đã chọn
 for (String seri : listseri) {
     for (Cart c : carts) {
         if (c.getSeri().equals(seri)) {
             pt = ptd.getProductTypeInfo(c.getSeri());
             int price = (int) (c.getPrice() * c.getQuantity());
             totalPrice += price;
             String result = String.format("%,d", price);
                        %>

                        <!-- Hiển thị thông tin sản phẩm -->
                        <div class='line'></div>
                        <table class='order-table'>
                            <tbody>
                                <tr>
                                    <td>
                                        <img src='<%= c.getImg()%>' class='full-width'></img>
                                    </td>
                                    <td>
                                        <br>
                                        <span class='thin'><%= c.getpName()%></span>
                                        <br><%= c.getSeri()%>
                                        <br>
                                        <span class='thin small'>Color: <%= pt.getColor()%>, Quantity: <%= c.getQuantity()%></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class='price'><%= result%> VND</div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <%
                                }
                            }
                        }
                        %>

                        <div class='line'></div>
                        <div class='total'>
                            <span style='float:left;'>
                                <div class='thin dense'>VAT 10%</div>
                                <div class='thin dense'>Delivery</div>
                                TOTAL
                            </span>
                            <span style='float:right; text-align:right;'>
                                <div class='thin dense'><%= String.format("%,.0f", totalPrice * 0.1)%> VND</div>
                                <div class='thin dense'>0 VND</div>
                                <%=String.format("%,.0f", totalPrice * 1.1)%> VND
                            </span>
                        </div>
                    </div>
                </div>
                <div class='credit-info'>

                    <form action="vnpayajax" id="frmCreateOrder" method="post">   
                        <img src='https://cdn.haitrieu.com/wp-content/uploads/2022/10/Logo-VNPAY-QR.png' height='80' width='220' class='credit-card-image' id='credit-card-image'>
                        <div class="form-group">
                            <label for="amount">Số tiền</label>
                            <input class="form-control" data-val="true" data-val-number="The field Amount must be a number." data-val-required="The Amount field is required." id="amount" 
                                   name="amount" type="text" value="<%= (int) Math.round(totalPrice * 1.1)%>" />
                        </div>
                        <div class="form-group">
                            <label for="amount">Người nhận hàng</label>
                            <input class="form-control" id="name" name="name" type="text" value="${acc.fname} ${acc.lname}" />
                        </div> 
                        <div class="form-group">
                            <label for="amount">Địa chỉ nhận hàng</label>
                            <input class="form-control" id="addres" name="addres" type="text" value="${acc.addres} " />
                        </div> 
                        <div class="form-group">
                            <label for="amount">Số điện thoại</label>
                            <input class="form-control" id="phone" name="phone" type="text" value="${acc.phone}" />
                        </div> 
                        <h4>Chọn phương thức thanh toán</h4>
                        <div class="form-group">                            
                            <!--                            <input type="radio" Checked="True" id="bankCode" name="bankCode" value="">
                                                        <label for="bankCode">Cổng thanh toán VNPAYQR</label><br>-->                            
                            <input type="radio" id="bankCode" name="bankCode" value="VNPAYQR">
                            <label for="bankCode">Thanh toán bằng ứng dụng hỗ trợ VNPAYQR</label><br>

                            <input type="radio" id="bankCode" name="bankCode" value="VNBANK">
                            <label for="bankCode">Thanh toán qua thẻ ATM/Tài khoản nội địa</label><br>

                            <input type="radio" id="bankCode" name="bankCode" value="INTCARD">
                            <label for="bankCode">Thanh toán qua thẻ quốc tế</label><br>

                        </div>
                        <div class="form-group">
                            <h5>Chọn ngôn ngữ giao diện thanh toán:</h5>
                            <input type="radio" id="language" Checked="True" name="language" value="vn">
                            <label for="language">Tiếng việt</label><br>
                            <input type="radio" id="language" name="language" value="en">
                            <label for="language">Tiếng anh</label><br>

                        </div>
                        <button type="submit" class="btn btn-default" href>Thanh toán</button>
                    </form>

                </div>
            </div>
        </div>

        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <script type="text/javascript">
            $("#frmCreateOrder").submit(function () {
                var postData = $("#frmCreateOrder").serialize();
                var submitUrl = $("#frmCreateOrder").attr("action");
                $.ajax({
                    type: "POST",
                    url: submitUrl,
                    data: postData,
                    dataType: 'JSON',
                    success: function (x) {
                        if (x.code === '00') {
                            if (window.vnpay) {
                                vnpay.open({width: 768, height: 600, url: x.data});
                            } else {
                                location.href = x.data;
                            }
                            return false;
                        } else {
                            alert(x.Message);
                        }
                    }
                });
                return false;
            });
        </script>     
    </body>
</html>
