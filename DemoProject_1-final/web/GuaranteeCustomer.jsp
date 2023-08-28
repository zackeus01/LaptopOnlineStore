<%-- 
    Document   : MyAccount
    Created on : Jun 2, 2023, 5:22:56 PM
    Author     : win
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import = "Context.*" %>
<%@page import = "Model.*" %>
<%@page import= "java.util.*" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>
        <link type="text/css" rel="stylesheet" href="css/starGuarantee.css"/>
        <link href="cssadmin/bootstrap.min.css" rel="stylesheet">
        <link href="cssadmin/font-awesome.min.css" rel="stylesheet">
        <link href="cssadmin/datepicker3.css" rel="stylesheet">
        <link href="cssadmin/styles.css" rel="stylesheet">
        <link href="cssadmin/myaccount.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous"/>

        <!--Font Awesome Icon--> 
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <link href="css/style1.css" rel="stylesheet">
        <style>
            html,
            body {
                height: 100%;
            }

            body {
                margin: 0;
                background: linear-gradient(45deg, #49a09d, #5f2c82);
                font-family: sans-serif;
                font-weight: 100;
            }

            .container {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            table {
                width: 80%;
                border-collapse: collapse;
                overflow: hidden;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                margin: 5% 10% auto 10%;
            }

            th
            {
                padding: 2%;
                background-color: rgba(255,255,255,0.2);
                color: #fff;
            }
            .table1 td{
                padding: 2%;
                background-color: rgba(255,255,255,0.2);
                color: #fff;
            }

            th {
                text-align: left;
            }

            thead {
                th {
                    background-color: #55608f;
                }
            }
            p{
                color: #fff;
            }
            .detail-btn{
                color: #fff;
                background: black;
                border-radius: 0.5rem;
                height: 7%;
                width: auto;
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
                background-color: rgba(0, 0, 0, 0.4);
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
            .close, .close-evaluate {
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
            .close-evaluate:hover,
            .close-evaluate:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
            .stars {
                position: relative;
                white-space: nowrap;
            }
            .stars svg {
                width: 10%;
            }

            .overlay {
                background: #fff;
                height: 100%;
                overflow: hidden;
                mix-blend-mode: color;
                position: absolute;
                top: 0;
                right: 0;
            }

            svg {
                fill: gold;
            }
            .btn-evaluate{
                position: absolute;
                margin-left :40%;
                background-color:#0a0a23;
                color: #fff;
                border:none;
                border-radius:1rem;
                box-shadow: 0px 0px 2px 2px rgb(0,0,0);
                height: 10%;
                width: 15%;
            }
            td label{
                padding: 0.5rem 1rem 0rem 2rem;
                }
        </style>
    </head>
    <%
        SupplierDAO supDao = new SupplierDAO();
        GuaranteeDAO gd = new GuaranteeDAO();
        List<Supplier> supList = supDao.getAllSupplier();
        List<Cart> carts = new ArrayList<>();
        if (session.getAttribute("Cart") != null) {
            carts = (List<Cart>) session.getAttribute("Cart");
        }
        Account acc = (Account) session.getAttribute("acc");
        Account acct = (Account) session.getAttribute("acct");
        List<Guarantee> listguarantee = gd.getGuaranteeByAccID(acc.getAcId());
        String mess = (String) request.getAttribute("mess");
    %>
    <body>
        <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">

                    <div id="">

                        <div class="container">
                            <ul class="header-links pull-left">
                                <li><a href="#"><i class="fa fa-phone"></i> +021-95-51-84</a></li>
                                <li><a href="#"><i class="fa fa-envelope-o"></i> email@email.com</a></li>
                                <li><a href="#"><i class="fa fa-map-marker"></i> 1734 Stonecoal Road</a></li>
                            </ul>
                            <ul class="header-links pull-right">
                                <c:if test="${sessionScope.acc != null}">
                                    <li><a href="logout"><i class="fa fa-user-o"></i> Logout</a></li>
                                    </c:if>
                                    <c:if test="${sessionScope.acct != null}">
                                    <li><a href="manager"><i class="fa fa-user-o"></i> Manager</a></li>
                                    </c:if> 
                                    <c:choose>
                                        <c:when test="${sessionScope.acc != null}">
                                        <li><a href="myaccount"><i class="fa fa-user-o"></i>${acc.fname} ${acc.lname}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                        <li><a href="myaccount"><i class="fa fa-user-o"></i> My Account</a></li>
                                        </c:otherwise>
                                    </c:choose>
                            </ul>                           
                        </div>        
                    </div>

                </div>
            </div><!-- /.container-fluid -->
        </nav>

        <header>
        </header>

        <!--END HEADER-->
        <%
            Account3 a = new Account3();
            Account3 ac = a.getAccountByAcId(acc.getAcId());
        %>
        <div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
            <div class="profile-sidebar">
                <div class="profile-userpic">
                    <img src="<%= ac.getAccimg()%>" class="img-responsive" alt="">
                </div>
                <div class="profile-usertitle">
                    <div class="profile-usertitle-name"><%= ac.getFname() +" "+ ac.getLname()%></div>
                    <div class="profile-usertitle-status"><span class="indicator label-success"></span>Online</div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="divider"></div>
            <!--            <form role="search">
                            <div class="form-group ">
                                <input type="text" class="form-control col-lg-10" placeholder="Search">
                            </div>
                            <div>
                                <input type="submit"  value="Search">
                            </div>
                        </form>-->
            <ul class="nav menu">
                <li class="active"><a href="myaccount"><em class="fa fa-calendar">&nbsp;</em> My Profile</a></li>
                <li><a href="home"><em class="fa fa-home"></em> Home</a></li>                              
                <li><a href="charts.html"><em class="fa fa-bar-chart">&nbsp;</em> Charts</a></li>
                <li><a href="elements.html"><em class="fa fa-toggle-off">&nbsp;</em> UI Elements</a></li>
                <li><a href="panels.html"><em class="fa fa-clone">&nbsp;</em> Alerts &amp; Panels</a></li>
                <li><a href="GuaranteeCustomer.jsp"><span class="icon"><i class="fas fa-shield-alt"></i></span> Guarantee</a></li>
                <li><a href="logout"><em class="fa fa-power-off">&nbsp;</em> Logout</a></li>
            </ul>
        </div>

        <div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
            <% if(mess != null){%>
            <h4 style="color:#fff; text-align: center; margin-top: 5%;"><%= mess%></h4>
            <%}%>
            <table class="table1">
                <thead>
                    <tr>
                        <th>Seri Product</th>
                        <th> Received Date</th>
                        <th> Delivery Date</th>
                        <th>Customer Name</th>
                        <th>Progress</th>
                        <th></th>                     
                    </tr>
                </thead>
                <tbody>
                    <% for(Guarantee g : listguarantee){%>
                    <tr>
                        <td><%= g.getSeri()%></td>
                        <td><%= g.getReceivedDate()%></td>
                        <td><%= g.getDeliveryDate()%></td>
                        <td><%= g.getFullname()%></td>
                        <td><% switch(g.getProgress()){
                            case 0:
                            %>
                            <p>Đã xác nhận</p>
                            <% break;

                          case 1:
                            %>
                            <p>Đang bảo hành</p>
                            <% break;

                          case 2:
                            %>
                            <p>Đã bảo hành</p>
                            <% break;

                           case 3:
                            %>
                            <p>Đã nhận</p>
                            <% break;
                                         } %>
                        </td>
                        <td>
                            <button class="detail-btn" onclick="showDetails('<%= g.getGuaranteeID() %>')">Detail</button>
                            <button class="detail-btn" onclick="showModel('<%= g.getGuaranteeID() %>')">Evaluate</button>
                        </td>
                    </tr>  
                    <%}%>
                </tbody>
            </table>
            <div id="myModal" class="modal">
                <!-- Nội dung modal -->
                <div class="modal-content">
                    <span id="closeButton" class="close">&times;</span>
                    <h3>Thông tin bảo hành</h3>
                    <p style="display: none;" id="mess">Not found information guarantee of product</p>
                    <table id="table">
                                               
                    </table>
                    <table id="table">
                        <tr>
                            <td><label>Customer Name:</label></td>
                            <td><label class="lable" id="lable-name"></label></td>                          
                        </tr>
                        <tr>
                            <td><label>Address:</label></td>
                            <td><label class="lable" id="lable-address"></label></td>                           
                        </tr>
                        <tr>
                            <td><label>Phone Number:</label></td>
                            <td><label class="lable" id="lable-phone"></label></td>                            
                        </tr>
                        <tr>
                            <td><label>Email:</label></td>
                            <td><label class="lable" id="lable-email"></label></td>                            
                        </tr>
                        <tr>
                            <td><label>Seri Product:</label></td>
                            <td><label class="lable" id="lable-productseri"></label></td>                            
                        </tr>
                        <tr>
                            <td><label>Received Date:</label></td>
                            <td><label class="lable" id="lable-received"></label></td>                            
                        </tr>
                        <tr>
                            <td><label>Delivery Date:</label></td>
                            <td><label class="lable" id="lable-delivery"></label></td>                            
                        </tr>
                        <tr>
                            <td><label>Expense:</label></td>
                            <td><label class="lable" id="lable-expense"></label></td>                            
                        </tr>
                        <tr>
                            <td><label>Evaluate:</label></td>
                            <td><label class="lable" id="lable-evaluate">
                                    <div class="stars">
                                        <svg width="100" height="100" viewBox="0 0 940.688 940.688">
                                        <path d="M885.344,319.071l-258-3.8l-102.7-264.399c-19.8-48.801-88.899-48.801-108.6,0l-102.7,264.399l-258,3.8 c-53.4,3.101-75.1,70.2-33.7,103.9l209.2,181.4l-71.3,247.7c-14,50.899,41.1,92.899,86.5,65.899l224.3-122.7l224.3,122.601 c45.4,27,100.5-15,86.5-65.9l-71.3-247.7l209.2-181.399C960.443,389.172,938.744,322.071,885.344,319.071z" />
                                        </svg>
                                        <svg width="100" height="100" viewBox="0 0 940.688 940.688">
                                        <path d="M885.344,319.071l-258-3.8l-102.7-264.399c-19.8-48.801-88.899-48.801-108.6,0l-102.7,264.399l-258,3.8 c-53.4,3.101-75.1,70.2-33.7,103.9l209.2,181.4l-71.3,247.7c-14,50.899,41.1,92.899,86.5,65.899l224.3-122.7l224.3,122.601 c45.4,27,100.5-15,86.5-65.9l-71.3-247.7l209.2-181.399C960.443,389.172,938.744,322.071,885.344,319.071z" />
                                        </svg>
                                        <svg width="100" height="100" viewBox="0 0 940.688 940.688">
                                        <path d="M885.344,319.071l-258-3.8l-102.7-264.399c-19.8-48.801-88.899-48.801-108.6,0l-102.7,264.399l-258,3.8 c-53.4,3.101-75.1,70.2-33.7,103.9l209.2,181.4l-71.3,247.7c-14,50.899,41.1,92.899,86.5,65.899l224.3-122.7l224.3,122.601 c45.4,27,100.5-15,86.5-65.9l-71.3-247.7l209.2-181.399C960.443,389.172,938.744,322.071,885.344,319.071z" />
                                        </svg>
                                        <svg width="100" height="100" viewBox="0 0 940.688 940.688">
                                        <path d="M885.344,319.071l-258-3.8l-102.7-264.399c-19.8-48.801-88.899-48.801-108.6,0l-102.7,264.399l-258,3.8 c-53.4,3.101-75.1,70.2-33.7,103.9l209.2,181.4l-71.3,247.7c-14,50.899,41.1,92.899,86.5,65.899l224.3-122.7l224.3,122.601 c45.4,27,100.5-15,86.5-65.9l-71.3-247.7l209.2-181.399C960.443,389.172,938.744,322.071,885.344,319.071z" />
                                        </svg>
                                        <svg width="100" height="100" viewBox="0 0 940.688 940.688">
                                        <path d="M885.344,319.071l-258-3.8l-102.7-264.399c-19.8-48.801-88.899-48.801-108.6,0l-102.7,264.399l-258,3.8 c-53.4,3.101-75.1,70.2-33.7,103.9l209.2,181.4l-71.3,247.7c-14,50.899,41.1,92.899,86.5,65.899l224.3-122.7l224.3,122.601 c45.4,27,100.5-15,86.5-65.9l-71.3-247.7l209.2-181.399C960.443,389.172,938.744,322.071,885.344,319.071z" />
                                        </svg>
                                        <div class="overlay" style="width: 37%"></div>
                                    </div>
                                </label></td>                            
                        </tr>
                        <tr>
                            <td><label>Comment:</label></td>
                            <td><label class="lable" id="lable-comment"></label></td>                            
                        </tr>
                        <tr>
                            <td><label>Describe:</label></td>
                            <td><label class="lable" id="lable-describe"></label></td>                            
                        </tr>
                    </table>
                </div>
            </div>
            <div id="myModal-evaluate" class="modal">
                <!-- Nội dung modal -->
                <div class="modal-content">
                    <span id="closeButton" class="close-evaluate">&times;</span>
                    <h3>Evaluation of warranty quality</h3>
                    <form class="form-group" action="ChangeProgress" method="POST">
                        <h5> Comment </h5>
                        <textarea type="text" class="comment" name="comment" row ="3" style="width: 100%;"></textarea>
                        <input type="text" name="GuaranteeID" id="guarantee" style="display: none;">
                        <div style="display: flex;" >
                            <h5 style="margin-top: 2.5%; padding-right: 3%;"> Evaluate: </h5>
                            <span id="rating" style="margin-bottom: 5%;" >
                                <input type="radio" id="star5" name="rating" value="5" />
                                <label class = "full" for="star5" title="Awesome - 5 stars"></label>

                                <input type="radio" id="star4" name="rating" value="4" />
                                <label class = "full" for="star4" title="Pretty good - 4 stars"></label>

                                <input type="radio" id="star3" name="rating" value="3" />
                                <label class = "full" for="star3" title="Meh - 3 stars"></label>

                                <input type="radio" id="star2" name="rating" value="2" />
                                <label class = "full" for="star2" title="Kinda bad - 2 stars"></label>

                                <input type="radio" id="star1" name="rating" value="1" />
                                <label class = "full" for="star1" title="Sucks big time - 1 star"></label>
                            </span>
                        </div>
                        <div>
                            <input type="submit"  class="btn-evaluate" value="Save"> 
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            var modal = document.getElementById("myModal");
            // Lấy nút đóng modal
            var closeBtn = document.getElementsByClassName("close")[0];
            var modalEvaluate = document.getElementById("myModal-evaluate");
            // Lấy nút đóng modal
            var closeBtnevaluate = document.getElementsByClassName("close-evaluate")[0];
            function formatDate(date) {
                var day = date.getDate();
                var month = date.getMonth() + 1;
                var year = date.getFullYear();
                return day + "/" + month + "/" + year;
            }
            // Khi người dùng nhấp vào nút "Detail"
            function showDetails(guaranteeID) {
                // Gửi yêu cầu Ajax đến servlet để lấy thông tin chi tiết
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (this.readyState === 4 && this.status === 200) {
                        // Hiển thị thông tin chi tiết trong modal
                        var guarantee = JSON.parse(xhr.responseText);
                        var fullname = document.getElementById("lable-name");
                        var address = document.getElementById("lable-address");
                        var phone = document.getElementById("lable-phone");
                        var email = document.getElementById("lable-email");
                        var seri = document.getElementById("lable-productseri");
                        var received = document.getElementById("lable-received");
                        var delivery = document.getElementById("lable-delivery");
                        var comment = document.getElementById("lable-comment");
                        var describe = document.getElementById("lable-describe");
                        var expense = document.getElementById("lable-expense");
                        fullname.innerHTML = guarantee.fullname;
                        address.innerHTML = guarantee.address;
                        phone.innerHTML = guarantee.phone;
                        email.innerHTML = guarantee.email;
                        seri.innerHTML = guarantee.seri;
                        received.innerHTML = formatDate(new Date(guarantee.ReceivedDate));
                        delivery.innerHTML = formatDate(new Date(guarantee.DeliveryDate));
                        var star = guarantee.evaluate;
                        var percentage = 100 - (11.1 * star);
                        document.querySelector('.overlay').style.width = percentage + "%";
                        comment.innerHTML = guarantee.comment;
                        describe.innerHTML = guarantee.describe;
                        var expenseValue = guarantee.expense;
                        var formattedExpense = expenseValue.toLocaleString();
                        expense.innerHTML = formattedExpense + " VND";
                        // Mở modal
                        modal.style.display = "block";
                    }
                };
                xhr.open("GET", "DetailGuarantee?guaranteeID=" + guaranteeID, true);
                xhr.send();
            }

            // Khi người dùng nhấp vào nút đóng modal
            closeBtn.onclick = function () {
                // Đóng modal
                modal.style.display = "none";
            };
            // Khi người dùng nhấp vào bất kỳ đâu bên ngoài modal, đóng modal
            window.onclick = function (event) {
                if (event.target === modal) {
                    modal.style.display = "none";
                }
                if (event.target === modalEvaluate) {
                    modalEvaluate.style.display = "none";
                }
            };
            function showModel(guaranteeID) {
                modalEvaluate.style.display = "block";
                var guaranteeInput = document.getElementById("guarantee");
                guaranteeInput.value = guaranteeID;
            }
            closeBtnevaluate.onclick = function () {
                // Đóng modal
                modalEvaluate.style.display = "none";
            };
        </script>


        <script src="jsadmin/jquery-1.11.1.min.js"></script>
        <script src="jsadmin/bootstrap.min.js"></script>
        <script src="jsadmin/chart.min.js"></script>
        <script src="jsadmin/chart-data.js"></script>
        <script src="jsadmin/easypiechart.js"></script>
        <script src="jsadmin/easypiechart-data.js"></script>
        <script src="jsadmin/bootstrap-datepicker.js"></script>
        <script src="jsadmin/custom.js"></script>
    </body>
</html>
