<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

        <script>
        </script>
        <style>
            #success_message{
                display: none;
            }
        </style>
    </head>
    <%       
        Account acc = (Account) session.getAttribute("acc");
    %>
    <body>
        <%@include file="HeaderHome.jsp" %>
        <div class="container">

            <form class="well form-horizontal" action="sendguarantee" method="post"  id="contact_form" enctype="multipart/form-data">
                <fieldset>
                    <div id="capture">
                        <!-- Form Name -->                        
                        <!-- Text input-->
                        <div class="form-group">
                            <label class="col-md-3 control-label" >Serial Number</label> 
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-tag"></i></span>
                                    <input name="seri" placeholder="Seri" class="form-control"  type="text" oninput="FindSeri()">
                                </div>
                                <p id="notify" style="display: none; margin: 1% 0% 0% 2%;"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">FullName</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                    <input  name="name" value="" class="form-control"  type="text">
                                </div>
                            </div>
                        </div>


                        <!-- Text input-->
                        <div class="form-group">
                            <label class="col-md-3 control-label">Email</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                    <input name="email" value="" class="form-control"  type="text">
                                </div>
                            </div>
                        </div>


                        <!-- Text input-->

                        <div class="form-group">
                            <label class="col-md-3 control-label">Phone Number</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                                    <input name="phone" value="" class="form-control" type="text">
                                </div>
                            </div>
                        </div>

                        <!-- Text input-->

                        <div class="form-group">
                            <label class="col-md-3 control-label">Address</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                    <input name="address" value="" class="form-control" type="text">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Date Buy</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input name="buy" value="" class="form-control" type="text">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Warranty period</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input name="period" value="" class="form-control" type="text">
                                </div>
                                <p id="date" style="display: none; margin: 1% 0% 0% 2%;"></p>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label"> Expense</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
                                    <input name="expense" value="" id="numberInput" oninput="formatNumber()" class="form-control" type="text">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label" >Describe</label> 
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-comment"></i></span>
                                    <textarea name="describe" placeholder="Mô tả tình trạng laptop của bạn" class="form-control"  type="text" row ="2"></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label" >Images Product</label> 
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-picture"></i></span>
                                    <img id="preview" src="" alt=""/><br>
                                    Choose images: <input type="file" name="image" onchange="validateImage(this);" class="form-control"> 
                                    <!--<img id="preview" src="#" alt="Ảnh của bạn">-->
                                    <script>
                                        function validateImage(input) {
                                            // Kiểm tra xem input có chứa file hay không
                                            if (input.files && input.files[0]) {
                                                var fileExtension = input.files[0].name.split('.').pop().toLowerCase();

                                                // Danh sách các phần mở rộng ảnh được chấp nhận
                                                var acceptedExtensions = ['jpg', 'jpeg', 'png', 'gif'];
                                                if (!acceptedExtensions.includes(fileExtension)) {
                                                    // Hiển thị thông báo lỗi
                                                    alert('Upload images!');
                                                    // Xóa giá trị của input để ngăn người dùng chọn ảnh lớn hơn
                                                    input.value = '';
                                                    // Xóa ảnh hiển thị trước đó
                                                    document.getElementById('preview').src = '';
                                                } else {
                                                    // Hợp lệ, hiển thị ảnh
                                                    showImage(input);
                                                }
                                            }
                                        }
                                        // Hàm này sẽ được gọi khi người dùng chọn file ảnh
                                        function showImage(input) {
                                            // Kiểm tra xem input có chứa file hay không
                                            if (input.files && input.files[0]) {
                                                // Tạo một đối tượng FileReader để đọc nội dung của file
                                                var reader = new FileReader();
                                                // Định nghĩa hàm onload cho đối tượng FileReader
                                                reader.onload = function (e) {
                                                    // Lấy đối tượng img theo id
                                                    var img = document.getElementById("preview");
                                                    // Gán nội dung của file cho thuộc tính src của img
                                                    img.src = e.target.result;
                                                    // Thay đổi kích thước của img nếu cần
                                                    img.width = 245;
                                                    img.height = 160;
                                                };
                                                // Đọc nội dung của file dưới dạng URL
                                                reader.readAsDataURL(input.files[0]);
                                            }
                                        }
                                    </script>
                                </div>
                            </div>
                        </div> 
                    </div>

                    <!-- Success message -->
                    <div class="alert alert-success" role="alert" id="success_message">Form đã được gửi thành công!</div>

                    <!-- Button -->
                    <div class="form-group">
                        <label class="col-md-3 control-label"></label>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-warning" >Gửi<span class="glyphicon glyphicon-send"></span></button>
                        </div>

                    </div>

                </fieldset>
            </form>  
        </div>
        <%@include file="Footer.jsp" %>
        <script type="text/javascript">
            function formatDate(date) {
                var day = date.getDate();
                var month = date.getMonth() + 1;
                var year = date.getFullYear();
                return day + "/" + month + "/" + year;
            }
            function FindSeri() {
                var seri = document.getElementsByName("seri")[0].value;
                var notify = document.getElementById("notify");
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (this.readyState === 4 && this.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        var orderDetail = JSON.parse(response.orderDetail);
                        var order = JSON.parse(response.order);
                        var productType = JSON.parse(response.producttype);
                        var product = JSON.parse(response.product);
                        if (orderDetail.fullname === "9999") {
                            notify.innerHTML = "Not found seri!";
                            notify.style.color = "red";
                            notify.style.display = "block";
                        } else {
                            notify.style.display = "none";
                            var fullname = document.getElementsByName("name")[0];
                            var address = document.getElementsByName("address")[0];
                            var phone = document.getElementsByName("phone")[0];
                            var email = document.getElementsByName("email")[0];
                            var buy = document.getElementsByName("buy")[0];
                            var period = document.getElementsByName("period")[0];
                            fullname.value = orderDetail.fullname;
                            address.value = orderDetail.addres;
                            phone.value = orderDetail.phone;
                            email.value = orderDetail.email;
                            var orderDate = new Date(order.OrderDate);
                            var guaranteeMonths = parseInt(product.guarantee);
                            var currentDate = new Date();
                            var guaranteeDate = new Date(orderDate.getFullYear(), orderDate.getMonth() + guaranteeMonths, orderDate.getDate());
                            buy.value = formatDate(orderDate);
                            period.value = formatDate(guaranteeDate);
                            if (currentDate > guaranteeDate) {
                                var notifydate = document.getElementById("date");
                                notifydate.innerHTML = "Quá hạn bảo hành!";
                                notifydate.style.display = "block";
                                notifydate.style.color = "red";
                            }
                        }
                    }
                };
                xhr.open("GET", "findSeri?seri=" + seri, true);
                xhr.send();
            }
            function formatNumber() {
                var input = document.getElementById("numberInput");
                var value = input.value;
                // Loại bỏ tất cả các ký tự không phải số và dấu chấm
                value = value.replace(/[^\d.]/g, "");
                // Chèn dấu phẩy giữa các cụm ba số liên tiếp
                value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                // Gán giá trị đã định dạng vào ô input
                input.value = value;
            }
        </script>
    </body>
</html>
