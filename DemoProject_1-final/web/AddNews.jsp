<%-- 
    Document   : AddNews
    Created on : Jun 6, 2023, 9:46:55 PM
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
        <script src="jsadmin/ckeditor/ckeditor.js"></script>
        <!--Custom Font-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous"/>
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->
    </head>
    <%                     
           NewDAO nd = new NewDAO();
           List<News> listnew = (List<News>) nd.getListNew();
            SupplierDAO sd = new SupplierDAO();
        List<Supplier> s = (List<Supplier>) sd.getSupplier();
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
            <ul class="nav menu">
                <li class="active"><a href="ProductManager.jsp"><em class="fa fa-dashboard">&nbsp;</em> Home</a></li>
                <li><a href="widgets.html"><em class="fa fa-calendar">&nbsp;</em> Widgets</a></li>
                <li><a href="charts.html"><em class="fa fa-bar-chart">&nbsp;</em> Charts</a></li>
                <li><a href="GuaranteeAdmin.jsp"><span class="icon"><i class="fas fa-shield-alt"></i></span> Guarantee</a></li>              
                <li><a href="addoldprod1.jsp"> <em class="fa fa-plus"></em> Add Old Product</a></li>
                <li><a href="AddNews.jsp"> <em class="fa fa-plus"></em> Add New</a></li>
                <li><a href="News.jsp"><em class="fa fa-clone">&nbsp;</em> News</a></li>
                <li class="parent "><a data-toggle="collapse" href="#sub-item-1">
                        <em class="fa fa-navicon">&nbsp;</em> Multilevel <span data-toggle="collapse" href="#sub-item-1" class="icon pull-right"><em class="fa fa-plus"></em></span>
                    </a>
                    <ul class="children collapse" id="sub-item-1">
                        <li><a class="" href="#">
                                <span class="fa fa-arrow-right">&nbsp;</span> Sub Item 1
                            </a></li>
                        <li><a class="" href="#">
                                <span class="fa fa-arrow-right">&nbsp;</span> Sub Item 2
                            </a></li>
                        <li><a class="" href="#">
                                <span class="fa fa-arrow-right">&nbsp;</span> Sub Item 3
                            </a></li>
                    </ul>
                </li>
                <li><a href="logout"><em class="fa fa-power-off">&nbsp;</em> Logout</a></li>
            </ul>
        </div><!--/.sidebar-->

        <div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
            <div class="row">
                <ol class="breadcrumb">
                    <li><a href="ProductManager.jsp">
                            <em class="fa fa-home"></em>
                        </a></li>
                    <li class="active">Home</li>
                </ol>

            </div><!--/.row-->

            <!--/.row-->


            <!--/.main-->
            <div class="row">
                <h2> Add News</h2>
                <% String msg = (String) request.getAttribute("msg");
                if(msg != null){%>
                <h4><%= msg%></h4><%}%>
                <form action="addnew" method="post" class="col-lg-12" enctype="multipart/form-data">
                    <div class="form-group">
                        <h4>News Title</h4>
                        <input type="text" name="title" class="form-control" style="width: 100%;">
                    </div>

                    <div class="form-group">
                        <h4>New Content</h4>
                        <textarea name="content" id="content" class="form-control"></textarea>
                    </div>

                    <div class="form-group">
                        <h4>News Link</h4>
                        <input type="text" name="newurl" class="form-control" style="width: 100%;">
                    </div>

                    <div class="form-group">
                        <h4>News Images</h4>
                        <div class="custom-file">
                            <input type="file" name="image" class="custom-file-input" onchange="showImage(this);">
                            <label class="custom-file-label" for="customFile">Choose file</label>
                        </div>
                        <img id="preview" src="#" alt="Your Image" style="width: 100%; max-height: 600px;">
                    </div>               
                    <script>
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
                    <input type="submit" value="Save">
                </form>

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
                        CKEDITOR.replace('content');
        </script>

    </body>
</html>
