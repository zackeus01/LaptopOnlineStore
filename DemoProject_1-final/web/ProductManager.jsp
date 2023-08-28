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
    </head>
    <%                     
            ProductDAO productdao = new ProductDAO();
            ProductTypeDAO ptd = new ProductTypeDAO();
            List<Product> list = new ArrayList<>();
            list = (List<Product>) request.getAttribute("list");
            if(list == null){
            list = (List<Product>) productdao.getProductDesc();}
            SupplierDAO sd = new SupplierDAO();
            List<Supplier> s = (List<Supplier>) sd.getSupplier();
            GuaranteeDAO gd = new GuaranteeDAO();
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
                <div class="col-lg-6 row" style="display: inline-block;">
                    <form action="search" method="post" > 
                        <div class="form-group col-lg-12 row " >
                            <input type="text" class="form-control"  id="search" placeholder="Search" style="height: 38px; width: 300px;" >                                     
                            <input type="submit"  value="Search" style="height: 38px; width: 100px;">  
                            <ul id="searchResults" class=""></ul>
                        </div>
                    </form>
                </div>

                <div class="col-lg-2" style="display: inline-block;">
                    <h2>Product</h2>
                    <% 
          String msg;
          msg =(String) request.getAttribute("msg");
          if(msg !=null){
                    %>
                    <h3><%= msg%></h3><%}%>
                </div>



                <div class="dropdown col-lg-2 row" style="display: inline-block; margin-left: 18%;">
                    <button class="dropbtn">ALL Product &#9660;</button>
                    <div class="dropdown-content">
                        <% for(Supplier su : s ){%>
                        <a href="listproduct?sid=<%= su.getSid()%>"><%= su.getSname()%></a>  
                        <%}%>
                    </div>
                </div>
                <script>
                    document.getElementById('search').addEventListener('input', function (event) {
                        var keyword = event.target.value.toLowerCase();
                        var searchResults = document.getElementById('searchResults');

                        // Clear previous search results
                        while (searchResults.firstChild) {
                            searchResults.removeChild(searchResults.firstChild);
                        }

                        // Check if the entered keyword is not empty
                        if (keyword.length > 0) {
                            // Send an Ajax request to search in the database
                            var xhr = new XMLHttpRequest();
                            xhr.open('GET', 'search?keyword=' + keyword, true);
                            xhr.onreadystatechange = function () {
                                if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                                    var products = JSON.parse(xhr.responseText);

                                    // Display the search results
                                    for (var i = 0; i < products.length; i++) {
                                        var li = document.createElement('li');
                                        var productLink = document.createElement('a');
                                        productLink.href = 'searchsmart?pid=' + products[i].pid; // Set the link URL
                                        var productName = products[i].pname;
                                        productLink.innerHTML = highlightKeyword(productName, keyword);

                                        // Add click event listener to the link
                                        li.addEventListener('click', function (e) {
//                                            e.preventDefault(); // Prevent default link behavior
                                            window.location.href = productLink.href; // Redirect to the link URL
                                        });

                                        li.appendChild(productLink);
                                        searchResults.appendChild(li);
                                    }
                                }
                            };
                            xhr.send();
                        }
                    });

                    function highlightKeyword(text, keyword) {
                        var regex = new RegExp('(' + keyword + ')', 'gi');
                        return text.replace(regex, '<span style="color: red;">$1</span>');
                    }
                </script>


            </div><!--/.row-->


            <!--/.main-->
            <div class="row">
                <div class="tbl-header col-lg-12">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <thead>
                            <tr>
                                <th><b>Image</b></th>
                                <th><b>Code Product</b></th>
                                <th><b>Seri</b></th>
                                <th><b>Name Product</b></th>
                                <!--                                <th><b>Product Information</b></th>-->
                                <th><b>Price</b></th>
                                <th><b>Color</b></th>
                                <th><b>Sell</b></th>
                                <th><b>Guarantee</b></th>
                                <th><b></b></th>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div class="tbl-content col-lg-12">
                    <table cellpadding="0" cellspacing="0" border="0">

                        <%                                     
                                 List<Product> listproduct = new ArrayList<>();
                                  ProductTypeDAO producttype = new ProductTypeDAO();
                                   for(Product p : list){
                                   ProductType pt = producttype.getProductType(p.getPid());
                                   int price = (int) p.getPrice();
                                   String result = String.format("%,d", price);
                        %>

                        <tr>
                            <td name="imgproduct"><img class="imgbook" id="division" src="<%= p.getImg()%>" alt=""></td>
                            <td name="idprod" id="division"><%= pt.getPid()%> </td>
                            <td name="seriprod" id="division"><%= p.getSeri() %> </td>
                            <td name="nameproduct" id="division"><%= pt.getPname() %>
                                <%if(gd.countRecordsByProductID(pt.getPid()) >= 1 && odd.countRecordsByProductID(pt.getPid()) >=1){%>
                                <p style="color: red;  cursor: pointer;" onclick="guaranteeProduct('<%= pt.getPid()%>')">(More than 5 products warranty)</p>
                                <%}%>
                            </td>                              
                            <td name="priceproduct" id="number" ><%=result %> VND</td>    
                            <td name="colorproduct" id="division"><%= pt.getColor()%></td>
                            <td name="saleproduct" id="division"><%= p.getSell()%> %</td>
                            <td name="guaranteeproduct" id="division"><%= p.getGuarantee()%> month </td>
                            <td name="button" id="division">
                                <a href="UpdateProduct.jsp?seri=<%= p.getSeri()%>" style="text-decoration: none;">
                                    <div id="addproduct">
                                        <h3 style="color: beige;"> <i class="fas fa-pen"></i> </h3>
                                    </div>
                                </a>
                            </td>
                        </tr>
                        <%}%>   

                    </table>

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
                                    window.onload = function () {
                                        var chart1 = document.getElementById("line-chart").getContext("2d");
                                        window.myLine = new Chart(chart1).Line(lineChartData, {
                                            responsive: true,
                                            scaleLineColor: "rgba(0,0,0,.2)",
                                            scaleGridLineColor: "rgba(0,0,0,.05)",
                                            scaleFontColor: "#c5c7cc"
                                        });
                                    };
                                    function guaranteeProduct(Pid) {
                                        window.location.href = "guaranteeProduct?pid=" + Pid;
                                    }
                                    var ulElement = document.querySelector('.dropdown-menu.dropdown-alerts');
                                    var aElements = ulElement.getElementsByTagName('a');
                                    var count = aElements.length;
                                    var spanElement = document.querySelector('.label.label-info');
                                    spanElement.textContent = count.toString();
        </script>

    </body>
</html>
