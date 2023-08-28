<%-- 
    Document   : Warranty
    Created on : Jun 19, 2023, 8:41:38 PM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            .warranty{
                height: 25rem;
                align-items: center;
            }
            .form-group{
                width: 60%;
                height: 4rem;
            }
            .modal {
                display: none; /* Ẩn ban đầu */
                position: fixed; /* Thay đổi vị trí tùy chọn */
                z-index: 1; /* Đặt lớp hiển thị trên cùng */
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto; /* Bật cuộn khi nội dung quá dài */
                background-color: rgba(0, 0, 0, 0.4); /* Màu nền và độ mờ */
            }

            /* Nội dung của modal */
            .modal-content {
                background-color: #fefefe;
                margin: 15% auto; /* Căn giữa trên màn hình, thay đổi tùy ý */
                padding: 20px;
                border: 1px solid #888;
                width: 50%; /* Thay đổi kích thước tùy ý */
            }

            /* Đóng modal */
            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
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
                width: 50%; /* Chia đều độ rộng cho 3 cột */
            }
        </style>      
    </head>
    <body>
        <%@include file="HeaderHome.jsp" %>
        <div class="warranty container" >
            <h1 style="margin: 2% 0%;"> Trung tâm bảo hành Laptop</h1>
            <form class="" onsubmit="searchGuarantee(); return false;">
                <input type="text" class="form-group" id="serialNumber" name="seri" placeholder="Input Seri laptop">
                <input type="submit" style="height: 4rem; width: 8rem;"  value="Search">
            </form>
        </div>
        <div id="myModal" class="modal">
            <!-- Nội dung modal -->
            <div class="modal-content">
                <span id="closeButton" class="close">&times;</span>
                <h3>Thông tin bảo hành</h3>
                <p style="display: none;" id="mess">Not found information guarantee of product</p>
                <table id="table">
                    <th></th>
                    <th></th>                       
                </table>
                <table id="table">
                    <tr>
                        <td><label>Tên khách hàng:</label></td>
                        <td><label class="lable" id="lable-name"></label></td>                          
                    </tr>
                    <tr>
                        <td><label>Địa chỉ:</label></td>
                        <td><label class="lable" id="lable-address"></label></td>                           
                    </tr>
                    <tr>
                        <td><label>Số điện thoại:</label></td>
                        <td><label class="lable" id="lable-phone"></label></td>                            
                    </tr>
                    <tr>
                        <td><label>Tên sản phẩm:</label></td>
                        <td><label class="lable" id="lable-productname"></label></td>                            
                    </tr>
                    <tr>
                        <td><label>Ngày mua:</label></td>
                        <td><label class="lable" id="lable-datebuy"></label></td>                            
                    </tr>
                    <tr>
                        <td><label>Hạn bảo hành:</label></td>
                        <td><label class="lable" id="lable-dateguarantee"></label></td>                            
                    </tr>
                </table>
                <button id="sendButton" style="display: none;">Gửi bảo hành</button>
            </div>
        </div>
        <%@include file="Footer.jsp" %>
        <script>
            // Lấy modal và nút đóng
            var modal = document.getElementById("myModal");
            var closeButton = document.getElementById("closeButton");
            var table = document.getElementById("table");
            var mess = document.getElementById("mess");
            var sendButton = document.getElementById("sendButton");
            function formatDate(date) {
                var day = date.getDate();
                var month = date.getMonth() + 1;
                var year = date.getFullYear();
                return day + "/" + month + "/" + year;
            }
            // Khi người dùng nhấp vào nút "Search"
            function searchGuarantee() {
                var serialNumber = document.getElementById("serialNumber").value;

                // Gửi yêu cầu AJAX đến servlet để lấy thông tin bảo hành
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            if (xhr.responseText === null) {
                                table.style.display = "none";
                                mess.style.display = "block";
                                modal.style.display = "block";
                            } else {
                                var response = JSON.parse(xhr.responseText);
                                var orderDetail = JSON.parse(response.orderDetail);
                                var order = JSON.parse(response.order);
                                var productType = JSON.parse(response.producttype);
                                var product = JSON.parse(response.product);
                                var nameLabel = document.getElementById("lable-name");
                                var addressLabel = document.getElementById("lable-address");
                                var phoneNumberLabel = document.getElementById("lable-phone");
                                var productname = document.getElementById("lable-productname");
                                var datebuy = document.getElementById("lable-datebuy");
                                var dateguarantee = document.getElementById("lable-dateguarantee");

                                nameLabel.innerText = orderDetail.fullname;
                                addressLabel.innerText = orderDetail.addres;
                                phoneNumberLabel.innerText = orderDetail.phone;
                                var orderDate = new Date(order.OrderDate);
                                var guaranteeMonths = parseInt(product.guarantee);
                                var currentDate = new Date();
                                var guaranteeDate = new Date(orderDate.getFullYear(), orderDate.getMonth() + guaranteeMonths, orderDate.getDate());
                                datebuy.innerHTML = formatDate(orderDate);
                                dateguarantee.innerHTML = formatDate(guaranteeDate);
                                productname.innerHTML = productType.pname;
                                if (currentDate <= guaranteeDate) {
                                    // Còn bảo hành - hiển thị nút gửi bảo hành      
                                    sendButton.style.display = "block";
                                } else {
                                    // Hết bảo hành - ẩn nút gửi bảo hành
                                    sendButton.style.display = "none";
                                }
                                mess.style.display = "none";
                                table.style.display = "block";
                                modal.style.display = "block"; // Hiển thị modal
                            }
                        } else {

                        }
                    }
                };
                xhr.open("GET", "guarantee?seri=" + serialNumber, true);
                xhr.send();
            }

            // Khi người dùng nhấp vào nút đóng
            closeButton.onclick = function () {
                modal.style.display = "none"; // Ẩn modal
            };

            // Khi người dùng nhấp vào ngoại ô modal, ẩn modal
            window.onclick = function (event) {
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };
            sendButton.onclick = function() {
                window.location.href = "sendguarantee";
            };
        </script>


    </body>
</html>
