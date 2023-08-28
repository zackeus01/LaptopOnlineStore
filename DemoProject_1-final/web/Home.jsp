<!DOCTYPE HTML>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import = "Context.*" %>
<%@page import = "Model.*" %>
<%@page import= "java.util.*" %>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Electro - HTML Ecommerce Template</title>

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <link href="css/style1.css" rel="stylesheet">

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->       
        <script
        src="https://maps.googleapis.com/maps/api/js?v=AIzaSyD8OEVG-zMQ5eo5dgeVlr_TEvgMpEdC5g0&sensor=false"></script>
        <script>
            var map;
            function initialize() {
                var mapOptions = {
                    zoom: 8,
                    center: new google.maps.LatLng(21.01335013401592, 105.52704283777423),
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById('map-canvas'),
                        mapOptions);
            }
            google.maps.event.addDomListener(window, 'load', initialize);
        </script>

    </head>
    <%
       Formatter format = new Formatter();
        NewDAO nd = new NewDAO();
        List<News> listnew = (List<News>)nd.getTop3New();
        List<ProductDisplay> products = (List<ProductDisplay>)session.getAttribute("product");
        List<ProductDisplay> topSells = (List<ProductDisplay>)session.getAttribute("topSell");
        
        ProductTypeDAO ptDao = new ProductTypeDAO();
        ProductDAO pDao = new ProductDAO();
        ReviewDAO reDao = new ReviewDAO();
    %>
    <body>
        <!-- HEADER -->
        <%@include file="HeaderHome.jsp" %>            
        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- shop -->
                    <div class="col-md-5 col-xs-4">
                        <div class="shop col-md-12 col-xs-12">
                            <div class="shop-img">
                                <img src="./img/shop01.png" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>Laptop<br>Collection</h3>
                                <a href="shop?all=1" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /shop -->

                    <!--                     shop 
                                        <div class="col-md-4 col-xs-6">
                                            <div class="shop">
                                                <div class="shop-img">
                                                    <img src="./img/shop02.png" alt="">
                                                </div>
                                                <div class="shop-body">
                                                       <h3>Cameras<br>Collection</h3>
                                                    <a href="shop" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                         /shop -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">

                    <!-- section title -->
                    <div class="col-md-12">
                        <div class="section-title">
                            <h3 class="title">New Products</h3>
                            <div name="supSelect" class="section-nav">
                                <ul class="section-tab-nav tab-nav">
                                    <%
                                        for (Supplier sup : supList) {
                                            int ss = 1;
                                            Object ssObj = request.getAttribute("ss");
                                            if (ssObj != null) {
                                                ss = (int) ssObj;
                                            }
                                    %>
                                    <li <% if (ss==sup.getSid()) { %>class="active"<% } %>>
                                        <a data-toggle="tab" onclick="redirectToHomeController('<%= sup.getSid() %>')"><%= sup.getSname() %></a>
                                    </li>
                                    <% 
                                        }
                                    %>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <script>
                        function redirectToHomeController(supSelect) {
                            var url = "home?supSelect=" + supSelect;
                            window.location.href = url;
                        }
                    </script>
                    <!-- /section title -->
                    <% 
                        if(session.getAttribute("product1") != null){
                            session.setAttribute("product", session.getAttribute("product1"));
                        }
                    %>
                    <!-- Products tab & slick -->
                    <div class="col-md-12">
                        <div class="row">
                            <div class="products-tabs">
                                <!-- tab -->
                                <div id="tab1" class="tab-pane active">
                                    <div class="products-slick" data-nav="#slick-nav-1">
                                        <% for (ProductDisplay p : products) {
                                        // product
                                        %>
                                        <div class="product">
                                            <div class="product-img">
                                                <img src="<%= p.getImg() %>" alt="" >
                                                <div class="product-label">
                                                    <span class="sale">- <%= p.getSell() %> % </span>
                                                </div>
                                            </div>
                                            <div class="product-body">
                                                <p class="product-category"><%= p.getSname() %></p>
                                                <h3 class="product-name"><a href="product?seri=<%= p.getSeri() %>"><%= p.getPname() %> (<%= p.getSeri() %>)</a></h3>
                                                <h4 class="product-price"><%= fm.formatPrice(p.getPrice() - p.getPrice()*p.getSell()/100) %>
                                                <del class="product-old-price"><%= fm.formatPrice(p.getPrice()) %></del></h4>
                                                <% int pid = pDao.getProductIdBySeri(p.getSeri());
                                                   List<Review> reviews = reDao.getReviewByPid(pid); %>
                                                <% 
                                                int totalStar;
                                                int one=0, two=0, three=0, four=0, five=0, sum = 0;
                                                double fivePercentage=0, fourPercentage=0, threePercentage=0, twoPercentage=0, onePercentage=0;
                                                double avg=0;
                                                if (reviews.isEmpty() || reviews.size()==0) {
                                                    totalStar = 5;
                                                }
                                                else {
                                                    for (Review r : reviews) {
                                                        int star = r.getRating();
                                                        if (star == 1) {
                                                            one++;
                                                        } else if (star == 2) {
                                                            two++;
                                                        } else if (star == 3) {
                                                            three++;
                                                        } else if (star == 4) {
                                                            four++;
                                                        } else five++;
                                                        sum += star;
                                                    }
                                                    avg = (double)sum/reviews.size();
                                                    fivePercentage = (double)five / reviews.size() * 100;
                                                    fourPercentage = (double)four / reviews.size() * 100;
                                                    threePercentage = (double)three / reviews.size() * 100;
                                                    twoPercentage = (double)two / reviews.size() * 100;
                                                    onePercentage = (double)one / reviews.size() * 100;
                                                    if (Math.ceil(avg)-avg < 0.5) {
                                                        totalStar = (int)Math.ceil(avg);
                                                    } else totalStar = (int)Math.floor(avg);
                                                }
                                                %>
                                                <div class="product-rating">
                                                    <% 
                                                    for (int i=0; i<totalStar; i++) { 
                                                    %>
                                                    <i class="fa fa-star"></i>
                                                    <%  } for (int i=0; i<5-totalStar; i++) { %>
                                                    <i class="fa fa-star-o empty"></i>
                                                    <% } %>
                                                </div>
                                                <div class="product-btns">
                                                    <button class="add-to-wishlist" name="addToWishList"><a href="wishlist?seri=<%= p.getSeri() %>"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></a></button>
                                                    <button class="add-to-compare" onclick="window.location.href = 'compare?seri=<%= p.getSeri() %>'"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                                </div>
                                            </div>
                                            <form action="home" method="post">
                                                <div class="add-to-cart">
                                                    <button name="addToCart" class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                                    <input type="hidden" name="seri" value="<%= p.getSeri() %>">
                                                </div>
                                            </form>
                                        </div>
                                        <%-- /product --%>
                                        <% } %>
                                    </div>
                                    <div id="slick-nav-1" class="products-slick-nav"></div>
                                </div>
                                <!-- /tab -->
                            </div>
                        </div>
                    </div>
                    <!-- Products tab & slick -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- HOT DEAL SECTION -->
        <div id="hot-deal" class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="hot-deal">
                            <ul class="hot-deal-countdown">
                                <li>
                                    <div>
                                        <h3>02</h3>
                                        <span>Days</span>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <h3>10</h3>
                                        <span>Hours</span>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <h3>34</h3>
                                        <span>Mins</span>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <h3>60</h3>
                                        <span>Secs</span>
                                    </div>
                                </li>
                            </ul>
                            <h2 class="text-uppercase">hot deal this week</h2>
                            <p>New Collection Up to 50% OFF</p>
                            <a class="primary-btn cta-btn" href="#">Shop now</a>
                        </div>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /HOT DEAL SECTION -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">

                    <!-- section title -->
                    <div class="col-md-12">
                        <div class="section-title">
                            <h3 class="title">Top selling</h3>
                        </div>
                    </div>
                    <!-- /section title -->

                    <!-- Products tab & slick -->
                    <div class="col-md-12">
                        <div class="row">
                            <div class="products-tabs">
                                <!-- tab -->
                                <div id="tab2" class="tab-pane active">
                                    <div class="products-slick" data-nav="#slick-nav-2">
                                        <% for (ProductDisplay p : topSells) {
                                        // product
                                        %>
                                        <div class="product">
                                            <div class="product-img">
                                                <img src="<%= p.getImg() %>" alt="">
                                                <div class="product-label">
                                                    <span class="sale">- <%= p.getSell() %> % </span>
                                                </div>
                                            </div>
                                            <div class="product-body">
                                                <p class="product-category"><%= p.getSname() %></p>
                                                <h3 class="product-name"><a href="product?seri=<%= p.getSeri() %>"><%= p.getPname() %> (<%= p.getSeri() %>)</a></h3>
                                                <h4 class="product-price"><%= fm.formatPrice(p.getPrice() - p.getPrice()*p.getSell()/100) %>
                                                <del class="product-old-price"><%= fm.formatPrice(p.getPrice()) %></del></h4>
                                                <% int pid = pDao.getProductIdBySeri(p.getSeri());
                                                   List<Review> reviews = reDao.getReviewByPid(pid); %>
                                                <% 
                                                int totalStar;
                                                int one=0, two=0, three=0, four=0, five=0, sum = 0;
                                                double fivePercentage=0, fourPercentage=0, threePercentage=0, twoPercentage=0, onePercentage=0;
                                                double avg=0;
                                                if (reviews.isEmpty() || reviews.size()==0) {
                                                    totalStar = 5;
                                                }
                                                else {
                                                    for (Review r : reviews) {
                                                        int star = r.getRating();
                                                        if (star == 1) {
                                                            one++;
                                                        } else if (star == 2) {
                                                            two++;
                                                        } else if (star == 3) {
                                                            three++;
                                                        } else if (star == 4) {
                                                            four++;
                                                        } else five++;
                                                        sum += star;
                                                    }
                                                    avg = (double)sum/reviews.size();
                                                    fivePercentage = (double)five / reviews.size() * 100;
                                                    fourPercentage = (double)four / reviews.size() * 100;
                                                    threePercentage = (double)three / reviews.size() * 100;
                                                    twoPercentage = (double)two / reviews.size() * 100;
                                                    onePercentage = (double)one / reviews.size() * 100;
                                                    if (Math.ceil(avg)-avg < 0.5) {
                                                        totalStar = (int)Math.ceil(avg);
                                                    } else totalStar = (int)Math.floor(avg);
                                                }
                                                %>
                                                <div class="product-rating">
                                                    <% 
                                                    for (int i=0; i<totalStar; i++) { 
                                                    %>
                                                    <i class="fa fa-star"></i>
                                                    <%  } for (int i=0; i<5-totalStar; i++) { %>
                                                    <i class="fa fa-star-o empty"></i>
                                                    <% } %>
                                                </div>
                                                <div class="product-btns">
                                                    <button class="add-to-wishlist" name="addToWishList"><a href="wishlist?seri=<%= p.getSeri() %>"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></a></button>
                                                    <button class="add-to-compare" onclick="window.location.href = 'compare?seri=<%= p.getSeri() %>'"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                                </div>
                                            </div>
                                            <form action="home" method="post">
                                                <div class="add-to-cart">
                                                    <button name="addToCart" class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                                    <input type="hidden" name="seri" value="<%= p.getSeri() %>">
                                                </div>
                                            </form>
                                        </div>
                                        <%-- /product --%>
                                        <% } %>
                                    </div>
                                    <div id="slick-nav-2" class="products-slick-nav"></div>
                                </div>
                                <!-- /tab -->
                            </div>
                        </div>
                    </div>
                    <!-- /Products tab & slick -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-4 col-xs-6">
                        <div class="section-title">
                            <h4 class="title">Top selling</h4>
                            <div class="section-nav">
                                <div id="slick-nav-3" class="products-slick-nav"></div>
                            </div>
                        </div>

                        <div class="products-widget-slick" data-nav="#slick-nav-3">
                            <c:forEach items="${sessionScope.topSell}" var="p" varStatus="status">
                                <!-- Check if a new column should start -->
                                <c:if test="${status.index % 3 == 0}">
                                    <div>
                                    </c:if>

                                    <!-- product widget -->
                                    <div class="product-widget">
                                        <div class="product-img">
                                            <img src="${p.getImg()}" alt="">
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category">${p.getSname()}</p>
                                            <h3 class="product-name"><a href="product?seri=${p.getSeri()}">${p.getPname()} (${p.getSeri()})</a></h3>
                                            <h4 class="product-price"><fmt:formatNumber type="currency" value="${p.getPrice()}" currencyCode="VND" maxFractionDigits="0" />
                                                <del class="product-old-price"><fmt:formatNumber type="currency" value="${p.getPrice()}" currencyCode="VND" maxFractionDigits="0" /></del>
                                            </h4>
                                        </div>
                                    </div>
                                    <!-- /product widget -->

                                    <!-- Check if a column should end -->
                                    <c:if test="${status.index % 3 == 2 or status.last}">
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="col-md-4 col-xs-6">
                        <div class="section-title">
                            <h4 class="title">Top selling</h4>
                            <div class="section-nav">
                                <div id="slick-nav-4" class="products-slick-nav"></div>
                            </div>
                        </div>

                        <div class="products-widget-slick" data-nav="#slick-nav-4">
                            <c:forEach items="${sessionScope.topSell}" var="p" varStatus="status">
                                <!-- Check if a new column should start -->
                                <c:if test="${status.index % 3 == 0}">
                                    <div>
                                    </c:if>

                                    <!-- product widget -->
                                    <div class="product-widget">
                                        <div class="product-img">
                                            <img src="${p.getImg()}" alt="">
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category">${p.getSname()}</p>
                                            <h3 class="product-name"><a href="product?seri=${p.getSeri()}">${p.getPname()} (${p.getSeri()})</a></h3>
                                            <h4 class="product-price"><fmt:formatNumber type="currency" value="${p.getPrice()}" currencyCode="VND" maxFractionDigits="0" />
                                                <del class="product-old-price"><fmt:formatNumber type="currency" value="${p.getPrice()}" currencyCode="VND" maxFractionDigits="0" /></del>
                                            </h4>
                                        </div>
                                    </div>
                                    <!-- /product widget -->

                                    <!-- Check if a column should end -->
                                    <c:if test="${status.index % 3 == 2 or status.last}">
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="clearfix visible-sm visible-xs"></div>

                    <div class="col-md-4 col-xs-6">
                        <div class="section-title">
                            <h4 class="title">Top selling</h4>
                            <div class="section-nav">
                                <div id="slick-nav-5" class="products-slick-nav"></div>
                            </div>
                        </div>

                        <div class="products-widget-slick" data-nav="#slick-nav-5">
                            <c:forEach items="${sessionScope.topSell}" var="p" varStatus="status">
                                <!-- Check if a new column should start -->
                                <c:if test="${status.index % 3 == 0}">
                                    <div>
                                    </c:if>

                                    <!-- product widget -->
                                    <div class="product-widget">
                                        <div class="product-img">
                                            <img src="${p.getImg()}" alt="">
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category">${p.getSname()}</p>
                                            <h3 class="product-name"><a href="product?seri=${p.getSeri()}">${p.getPname()} (${p.getSeri()})</a></h3>
                                            <h4 class="product-price"><fmt:formatNumber type="currency" value="${p.getPrice()}" currencyCode="VND" maxFractionDigits="0" />
                                                <del class="product-old-price"><fmt:formatNumber type="currency" value="${p.getPrice()}" currencyCode="VND" maxFractionDigits="0" /></del>
                                            </h4>
                                        </div>
                                    </div>
                                    <!-- /product widget -->

                                    <!-- Check if a column should end -->
                                    <c:if test="${status.index % 3 == 2 or status.last}">
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>

                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- NEWSLETTER -->
        <div id="newsletter" class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="newsletter">
                            <p>Sign Up for the <strong>NEWSLETTER</strong></p>
                            <form>
                                <input class="input" type="email" placeholder="Enter Your Email">
                                <button class="newsletter-btn"><i class="fa fa-envelope"></i> Subscribe</button>
                            </form>
                            <ul class="newsletter-follow">
                                <li>
                                    <a href="#"><i class="fa fa-facebook"></i></a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-twitter"></i></a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-instagram"></i></a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-pinterest"></i></a>
                                </li>
                            </ul>
                        </div>
                        <div id="map-canvas" style="height:300px; width:500px"></div>

                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /NEWSLETTER -->

        <!-- FOOTER -->
        <footer id="footer">
            <!-- top footer -->
            <div class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <script type="text/javascript" src="https://ahachat.com/customer-chats/customer_chat_sp0EzwJkMw6485736e1ee7b.js"></script>                        <div class="newsletter">
                            <div class="col-md-3 col-xs-6">
                                <div class="footer">
                                    <h3 class="footer-title">About Us</h3>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut.</p>

                                    <ul class="footer-links">

                                        <c:forEach items="${aa}" var="item">
                                            <c:if test="${item.getNwId() == 3}">
                                                <li><a href="#"><i class="fa fa-map-marker"></i>${item.getTitle()}</a></li>
                                                    </c:if>
                                                    <c:if test="${item.getNwId() == 1}">
                                                <li><a href="#"><i class="fa fa-phone"></i>${item.getTitle()}</a></li>
                                                    </c:if>
                                                    <c:if test="${item.getNwId() == 2}">
                                                <li><a href="#"><i class="fa fa-envelope-o"></i>${item.getTitle()}</a></li>
                                                    </c:if>
                                                </c:forEach>
                                    </ul>

                                </div>
                            </div>

                            <div class="col-md-3 col-xs-6">
                                <div class="footer">
                                    <c:forEach items="${aaa}" var="item">
                                        <c:if test="${item.getNwgId() == 2}">
                                            <h3 class="footer-title">${item.getNw()}</h3>
                                        </c:if>
                                    </c:forEach>
                                    <ul class="footer-links">
                                        <c:forEach items="${aa}" var="item">
                                            <c:if test="${item.getNwId() == 4}">
                                                <li><a href="#">${item.getTitle()}</a></li>
                                                </c:if>
                                                <c:if test="${item.getNwId() == 5}">
                                                <li><a href="Warranty.jsp">${item.getTitle()}</a></li>
                                                </c:if>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-6">
                                <div class="footer">
                                    <c:forEach items="${aaa}" var="item">
                                        <c:if test="${item.getNwgId() == 3}">
                                            <h3 class="footer-title">${item.getNw()}</h3>
                                        </c:if>
                                    </c:forEach>
                                    <ul class="footer-links">
                                        <c:forEach items="${aa}" var="item">
                                            <c:if test="${item.getNwId() == 6}">
                                                <li><a href="#">${item.getTitle()}</a></li>
                                                </c:if>
                                                <c:if test="${item.getNwId() == 7}">
                                                <li><a href="#">${item.getTitle()}</a></li>
                                                </c:if>
                                                <c:if test="${item.getNwId() == 8}">
                                                <li><a href="#">${item.getTitle()}</a></li>
                                                </c:if>
                                                <c:if test="${item.getNwId() == 9}">
                                                <li><a href="#">${item.getTitle()}</a></li>
                                                </c:if>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-6">
                                <div class="footer">
                                    <c:forEach items="${aaa}" var="item">
                                        <c:if test="${item.getNwgId() == 4}">
                                            <h3 class="footer-title">${item.getNw()}</h3>
                                        </c:if>
                                    </c:forEach>
                                    <ul class="footer-links">
                                        <c:forEach items="${aa}" var="item">
                                            <c:if test="${item.getNwId() == 10}">
                                                <li><a href="#">${item.getTitle()}</a></li>
                                                </c:if>
                                                <c:if test="${item.getNwId() == 11}">
                                                <li><a href="#">${item.getTitle()}</a></li>
                                                </c:if>
                                                <c:if test="${item.getNwId() == 12}">
                                                <li><a href="">${item.getTitle()}</a></li>
                                                </c:if>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>

                        </div>
                        <!-- /row -->
                    </div>
                    <!-- /container -->
                </div>
                <!-- /top footer -->

                <!-- bottom footer -->
                <div id="bottom-footer" class="section">
                    <div class="container">
                        <!-- row -->
                        <div class="row">
                            <div class="col-md-12 text-center">
                                <ul class="footer-payments">
                                    <li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
                                    <li><a href="#"><i class="fa fa-credit-card"></i></a></li>
                                    <li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
                                    <li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
                                    <li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
                                    <li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
                                </ul>
                                <span class="copyright">
                                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                    Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                </span>
                            </div>
                        </div>
                        <!-- /row -->
                    </div>
                    <!-- /container -->
                </div>
                <!-- /bottom footer -->
        </footer>
        <!-- /FOOTER -->

        <!-- jQuery Plugins -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/cart.js"></script>
        <!--        <script
                    type="text/javascript"
                    src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.3.1/mdb.min.js"
                ></script>-->
    </body>
</html>
