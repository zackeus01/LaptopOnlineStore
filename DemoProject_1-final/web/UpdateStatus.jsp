<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "Model.*" %>
<%@page import= "java.util.*" %>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lumino - Dashboard</title>
        <link href="cssadmin/bootstrap.min.css" rel="stylesheet">
        <link href="cssadmin/font-awesome.min.css" rel="stylesheet">
        <link href="cssadmin/datepicker3.css" rel="stylesheet">
        <link href="cssadmin/styles.css" rel="stylesheet">
        <link href="cssadmin/listproducts.css" rel="stylesheet">
        <link href="cssadmin/dropdown.css" rel="stylesheet">
        <link href="cssadmin/newproduct.css" rel="stylesheet">
        <script src="jsadmin/ckeditor/ckeditor.js"></script>

        <!--Custom Font-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous"/>
    </head>

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
                                <em class="fa fa-bell"></em><span class="label label-info">5</span>
                            </a>
                            <ul class="dropdown-menu dropdown-alerts">
                                <li><a href="#">
                                        <div><em class="fa fa-envelope"></em> 1 New Message
                                            <span class="pull-right text-muted small">3 mins ago</span></div>
                                    </a></li>
                                <li class="divider"></li>
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
        <div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
            <div class="profile-sidebar">
                <div class="profile-userpic">
                    <img src="http://placehold.it/50/30a5ff/fff" class="img-responsive" alt="">
                </div>
                <div class="profile-usertitle">
                    <div class="profile-usertitle-name">Username</div>
                    <div class="profile-usertitle-status"><span class="indicator label-success"></span>Online</div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="divider"></div>
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
                    <li><a href="#">
                            <em class="fa fa-home"></em>
                        </a></li>
                    <li class="active">Dashboard</li>
                </ol>
            </div><!--/.row-->

            <div class="row">

                <div class="col-lg-4">
                    <h2>Update Status</h2>
                </div>


            </div><!--/.row-->
            <h3>Current Status</h3>
            <span >${requestScope.detail.status}</span>

            <h3>Edit Status</h3>
            <form action="uploadorder" method="post">
                <select name="status" id="" class="" style="width:  170px; height: 50px" >
                    <option value="0">0</option>
                    <option value="1">1</option>                                           
                    <option value="2">2</option>
                    <option value="3">3</option>
                </select>

                <input type="text" value="${requestScope.detail.getOrderID()}" name="orderid" hidden="">

                <p>Note:</p>
                <p>-Choose 0: Đã đặt hàng </p>
                <p>-Choose 1: Đã xác nhận </p>
                <p>-Choose 2: Đang giao hàng </p>
                <p>-Choose 3: Đã nhận hàng </p>
                <div class="button">
                    <button class="button btn_cancel"> <a href="OrderDetail.jsp"
                                                          style="text-decoration: none;">Cancel</a></button>
                    <input type="submit" class="button btn_save" value="Update">

                </div>
            </form>
        </div>

        <script>
            var tdElements = document.getElementsByName("priceproduct");

            // Duyệt qua danh sách các thẻ <td> và thực hiện thao tác trên mỗi thẻ
            for (var i = 0; i < tdElements.length; i++) {
                var td = tdElements[i];
                // Thực hiện các thao tác mong muốn trên mỗi thẻ <td> tại đây
                // Ví dụ: định dạng giá tiền
                var price = parseInt(td.innerHTML);
                var formattedPrice = price.toLocaleString().replace(/\B(?=(\d{3})+(?!\d))/g, '.');
                // Gán giá trị đã định dạng vào ô input
                priceElement.innerHTML = formattedPrice;
            }
        </script>
        <script src="jsadmin/jquery-1.11.1.min.js"></script>
        <script src="jsadmin/bootstrap.min.js"></script>
        <script src="jsadmin/chart.min.js"></script>
        <script src="jsadmin/chart-data.js"></script>
        <script src="jsadmin/easypiechart.js"></script>
        <script src="jsadmin/easypiechart-data.js"></script>
        <script src="jsadmin/bootstrap-datepicker.js"></script>
        <script src="jsadmin/custom.js"></script>
        <script>
            window.onload = function () {
                var chart1 = document.getElementById("line-chart").getContext("2d");
                window.myLine = new Chart(chart1).Line(lineChartData, {
                    responsive: true,
                    scaleLineColor: "rgba(0,0,0,.2)",
                    scaleGridLineColor: "rgba(0,0,0,.05)",
                    scaleFontColor: "#c5c7cc"
                });
            };
            CKEDITOR.replace('describe');
        </script>

    </body>

</html>
