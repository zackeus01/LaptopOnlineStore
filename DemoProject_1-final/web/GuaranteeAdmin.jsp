<%-- 
    Document   : News
    Created on : Jun 6, 2023, 8:35:08 PM
    Author     : win
--%>

<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "Model.*" %>
<%@page import= "java.util.*" %>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lumino - Dashboard</title>
        <link href="cssadmin/bootstrap.min.css" rel="stylesheet">
        <link href="cssadmin/font-awesome.min.css" rel="stylesheet">
        <link href="cssadmin/datepicker3.css" rel="stylesheet">
        <link href="cssadmin/styles.css" rel="stylesheet">
        <link href="css/listproducts.css" rel="stylesheet">
        <link href="css/dropdown.css" rel="stylesheet">
        <!--Custom Font-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous"/>
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->
        <style>
            th {
                font-size: 100%;
            }
            td {
                font-size: 80%;
            }
            .detail-btn {
                background-color: black;
                color: white;
                padding: 5% 10%;
                border: none;
                border-radius: 0.5rem;
                cursor: pointer;
            }

            /* CSS cho nút Change Status */
            .status-btn {
                background-color: black;
                color: white;
                padding: 5% 10%;
                border: none;
                border-radius: 0.5rem;
                cursor: pointer;
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
            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: fixed;
                z-index: 1;
            }

            .dropdown-content a {
                display: block;
                padding: 10px;
                text-decoration: none;
                color: #000;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }
            option{
                height: 5%;
            }
            .btn-addguarantee{
                background-color: black;
                color: white;
                padding: 1em 2em;
                border: none;
                border-radius: 1rem;
                cursor: pointer;
                margin-bottom: 1rem;
            }
            .btn-select{
                background-color: black;
                color: white;
                padding: 1em 2em;
                border: none;
                border-radius: 1rem;
                cursor: pointer;
                margin-bottom: 1rem;
            }

        </style>
    </head>
    <%                     
         GuaranteeDAO gd = new GuaranteeDAO();
          List<Guarantee> listguarantee = (List<Guarantee>) request.getAttribute("listguarantee");
          ProductTypeDAO ptd = new ProductTypeDAO();
            OrderDetailDAO odd = new OrderDetailDAO();
            Map<Integer, Integer> countGuarantee = (Map<Integer, Integer>) gd.countRecords();
    %> 
    <body>
        <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#sidebar-collapse"><span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span></button>
                    <a class="navbar-brand" href="#"><span>Lumino</span>Admin</a>
                    <ul class="nav navbar-top-links navbar-right">
                        <li class="dropdown"><a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <em class="fa fa-envelope"></em><span class="label label-danger">15</span>
                            </a>
                            <ul class="dropdown-menu dropdown-messages">
                                <li>
                                    <div class="dropdown-messages-box"><a href="profile.html" class="pull-left">
                                            <img alt="image" class="img-circle" src="http://placehold.it/40/30a5ff/fff">
                                        </a>
                                        <div class="message-body"><small class="pull-right">3 mins ago</small>
                                            <a href="#"><strong>John Doe</strong> commented on <strong>your photo</strong>.</a>
                                            <br /><small class="text-muted">1:24 pm - 25/03/2015</small></div>
                                    </div>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="dropdown-messages-box"><a href="profile.html" class="pull-left">
                                            <img alt="image" class="img-circle" src="http://placehold.it/40/30a5ff/fff">
                                        </a>
                                        <div class="message-body"><small class="pull-right">1 hour ago</small>
                                            <a href="#">New message from <strong>Jane Doe</strong>.</a>
                                            <br /><small class="text-muted">12:27 pm - 25/03/2015</small></div>
                                    </div>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="all-button"><a href="#">
                                            <em class="fa fa-inbox"></em> <strong>All Messages</strong>
                                        </a></div>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown"><a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <em class="fa fa-bell"></em><span class="label label-info"></span>
                            </a>
                            <ul class="dropdown-menu dropdown-alerts">
                                <% for (Map.Entry<Integer, Integer> entry : countGuarantee.entrySet()) {
                                    int record = entry.getValue();
                                    if(record >=1){%>
                                <li><a href="guaranteeProduct?pid=<%= entry.getKey()%>">
                                        <div><em class="fa fa-envelope"></em> "<%= ptd.getProductType(entry.getKey()).getPname()%>" Warranty
                                            <span class="pull-right text-muted small"> now</span></div>
                                    </a></li>
                                <li class="divider"></li>
                                    <%}
                                        }%>

                                <li><a href="#">
                                        <div><em class="fa fa-heart"></em> 12 New Likes
                                            <span class="pull-right text-muted small">4 mins ago</span></div>
                                    </a></li>
                                <li class="divider"></li>
                                <li><a href="#">
                                        <div><em class="fa fa-user"></em> 5 New Followers
                                            <span class="pull-right text-muted small">4 mins ago</span></div>
                                    </a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div><!-- /.container-fluid -->
        </nav>
        <%
            Account account = (Account)session.getAttribute("acc");
            Account3 a = new Account3();
            Account3 ac = a.getAccountByAcId(account.getAcId());             
        %>


        <div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
            <div class="profile-sidebar">
                <div class="profile-userpic">
                    <img src="<%= ac.getAccimg()%>" class="img-responsive" alt="">
                </div>
                <div class="profile-usertitle">
                    <div class="profile-usertitle-name">${acc.fname} ${acc.lname} </div>
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
                <li class="active"><a href="ProductManager.jsp"><em class="fa fa-dashboard">&nbsp;</em> Home</a></li>
                <li><a href="listod"><em class="fa fa-calendar">&nbsp;</em> Order Detail</a></li>
                <li><a href="guaranteeAdmin"><span class="icon"><i class="fas fa-shield-alt"></i></span> Guarantee</a></li>                
                <li><a href="addoldprod1.jsp"> <em class="fa fa-plus"></em> Add Old Product</a></li>
                <li><a href="addnewprod.jsp"> <em class="fa fa-plus"></em> Add New Product</a></li>
                <li><a href="News.jsp"><em class="fa fa-clone">&nbsp;</em> News</a></li>              
                <li><a href="logout"><em class="fa fa-power-off">&nbsp;</em> Logout</a></li>
            </ul>
        </div><!--/.sidebar-->

        <div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
            <div class="row">
                <ol class="breadcrumb">
                    <li><a href="Home.jsp">
                            <em class="fa fa-home"></em>
                        </a></li>
                    <li class="active">Home</li>
                </ol>

            </div><!--/.row-->

            <div class="row">
                <div class="col-lg-12" style="display: inline-block; text-align: center;">
                    <h2>Guarantee </h2>
                    <% 
          String msg;
          msg =(String) request.getAttribute("msg");
          if(msg !=null){
                    %>
                    <h3><%= msg%></h3><%}%>
                </div>
            </div>
            <div class="col-lg-12 row" style="display: inline-block;">
                <form action="searchGuarantee" method="POST" class="col-lg-7 col-md-7" >  
                    <div class="form-group">
                        <input type="text" class="form-control" name="name" placeholder="Search" style="height: 38px; width: 300px;" >                                     
                        <input type="submit"  value="Search" style="height: 38px; width: 100px;">
                    </div>
                </form>
                <div class="item col-lg-5 col-md-5">
                    <div class="filter col-lg-8 col-md-8">
                        <label style="margin-right: 1%;">Progress</label>
                        <select name="progress" class="btn-select" onchange="filterByProgress(this.value)">
                            <option value="-1">Tất cả</option>
                            <option value="0">Đã xác nhận</option>
                            <option value="1">Đang bảo hành</option>
                            <option value="2">Đã bảo hành</option>
                            <option value="3">Đã nhận</option>
                            <option value="4">Quá hạn</option>
                        </select>
                    </div>
                    <div class="btn-add col-lg-4 col-md-4">
                        <button class="btn-addguarantee" onclick="AddGuarantee()">Add Guarantee</button>
                    </div>   
                </div>
            </div>

            <!--/.main-->
            <div class="row">
                <div class="col-lg-12">
                    <div class="table-responsive" style="max-height: 50rem; overflow-y: auto;">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th style="width: 12%;"><b>Guarantee ID</b></th>
                                    <th style="width: 12%;"><b>Seri Product</b></th>
                                    <th style="width: 15%;"><b>Customer Name</b></th>
                                    <th style="width: 12%;"><b>Received Date</b></th>                              
                                    <th style="width: 12%;"><b>Delivery Date</b></th>                             
                                    <th style="width: 12%;"><b>Progress</b></th>                             
                                    <th style="width: 25%;"><b></b></th>                             
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    if(listguarantee.isEmpty()){%>
                            <h4 style="text-align: center;">Không có danh sách bảo hành đã chọn!</h4>

                            <%} else{
                                    for(Guarantee g : listguarantee){%>
                            <tr>
                                <td><%= g.getGuaranteeID()%></td>
                                <td><%= g.getSeri()%></td>
                                <td><%= g.getFullname()%></td>
                                <td><%= g.getReceivedDate()%></td>
                                <td><%= g.getDeliveryDate()%></td>
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
                                    <div class="btn-action col-md-5">
                                        <button class="detail-btn" onclick="showDetails('<%= g.getGuaranteeID() %>')">Detail</button>
                                    </div>
                                    <div class="btn-action col-md-7">
                                        <!-- Button: Change Status -->
                                        <button class="status-btn" onclick="toggleDropdown('<%= g.getGuaranteeID() %>')">Change Status</button>
                                    </div>
                                    <div class="dropdown">
                                        <div class="dropdown-content" id="dropdown-content-<%= g.getGuaranteeID() %>">
                                            <a href="#" onclick="selectOption('0', '<%= g.getGuaranteeID() %>')">Đã xác nhận</a>
                                            <a href="#" onclick="selectOption('1', '<%= g.getGuaranteeID() %>')">Đang bảo hành</a>
                                            <a href="#" onclick="selectOption('2', '<%= g.getGuaranteeID() %>')">Hoàn thành bảo hành</a>
                                            <a href="#" onclick="selectOption('3', '<%= g.getGuaranteeID() %>')">Đã nhận</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>                       
                            <%}
                                    }%>
                            </tbody>
                        </table>
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
                                    <td><label>Person Guarantee:</label></td>
                                    <td><label class="lable" id="lable-person"></label></td>                            
                                </tr>
                                <tr>
                                    <td><label>Product Images:</label></td>
                                    <td><label class="lable" id="lable-images"><img style="max-height: 10rem; max-width: 10rem;" src="" id="images" alt="alt"/></label></td>                            
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
                </div>


            </div>
        </div>


        <script src="jsadmin/jquery-1.11.1.min.js"></script>
        <script src="jsadmin/bootstrap.min.js"></script>
        <script src="jsadmin/chart.min.js"></script>
        <script src="jsadmin/chart-data.js"></script>
        <script src="jsadmin/easypiechart.js"></script>
        <script src="jsadmin/easypiechart-data.js"></script>
        <script src="jsadmin/bootstrap-datepicker.js"></script>
        <script src="jsadmin/custom.js"></script>
        <script>
                                                // Lấy modal
                                                var modal = document.getElementById("myModal");
                                                // Lấy nút đóng modal
                                                var closeBtn = document.getElementsByClassName("close")[0];
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
                                                            var person = document.getElementById("lable-person");
                                                            var images = document.getElementById("images");
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
                                                            person.innerHTML = guarantee.personguarantee;
                                                            images.src = guarantee.pimg;
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
                                                };
                                                function toggleDropdown(guaranteeID) {
                                                    var dropdownContent = document.getElementById('dropdown-content-' + guaranteeID);
                                                    dropdownContent.style.display = dropdownContent.style.display === 'block' ? 'none' : 'block';
                                                }

                                                function selectOption(progress, guaranteeID) {
                                                    window.location.href = "ChangeProgress?Progress=" + progress + "&guaranteeID=" + guaranteeID;
                                                }
                                                function filterByProgress(progress) {
                                                    window.location.href = "searchGuarantee?progress=" + progress;

                                                }
                                                function AddGuarantee() {
                                                    window.location.href = "SendGuarantee.jsp";
                                                }
                                                var ulElement = document.querySelector('.dropdown-menu.dropdown-alerts');
                                                var aElements = ulElement.getElementsByTagName('a');
                                                var count = aElements.length;
                                                var spanElement = document.querySelector('.label.label-info');
                                                spanElement.textContent = count.toString();
        </script>

    </body>
</html>

