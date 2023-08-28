<!DOCTYPE html>
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
        <link type="text/css" rel="stylesheet" href="css/new.css"/>
        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <link href="css/style1.css" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="css/style2.css"/>
        <link type="text/css" rel="stylesheet" href="css/reset.css"/>
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>
    <body>
        <%@include file="HeaderHome.jsp" %> 
        <!-- HEADER -->
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!--/.row-->
                    <form class="d-flex" action="searchcompare" method="get">
                        <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm kiếm" aria-label="Tìm kiếm">
                    </form>
                    <div class="col-md-12">
                        <div class="row">

                            <div class="col-md-4 col-xs-6">
                                <div class="product">
                                    <div class="product-img">
                                        <img src="${detail.getImage()}" alt="">
                                    </div>
                                    <div class="product-body">
                                        <p class="product-category">${detail.getSname()}</p>
                                        <h3 class="product-name"><a href="#">${detail.getPname()}</a></h3>
                                        <h4 class="product-price"><fmt:formatNumber type="currency" value="${detail.getPrice()}" currencyCode="VND" maxFractionDigits="0" />
                                            <del class="product-old-price"><fmt:formatNumber type="currency" value="${detail.getPrice()}" currencyCode="VND" maxFractionDigits="0" /></del></h4>                                        <div class="product-rating">
                                        </div>
                                        <div class="product-btns">
                                            <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                            <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                            <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                        </div>
                                    </div>
                                    <div class="add-to-cart">
                                        <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4 col-xs-6">

                            </div>



                            <c:forEach items="${data}" var="p">
                                <!-- product -->
                                <div class="col-md-4 col-xs-6">
                                    <div class="product">
                                        <div class="product-img">
                                            <img src="${p.getImage()}" alt="">
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category">${p.getSname()}</p>
                                            <h3 class="product-name"><a href="#">${p.getPname()}</a></h3>
                                            <h4 class="product-price"><fmt:formatNumber type="currency" value="${p.getPrice()}" currencyCode="VND" maxFractionDigits="0" />
                                                <del class="product-old-price"><fmt:formatNumber type="currency" value="${p.getPrice()}" currencyCode="VND" maxFractionDigits="0" /></del></h4>                                        <div class="product-rating">
                                            </div>
                                            <div class="product-btns">
                                                <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                                <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                            </div>
                                        </div>
                                        <div class="add-to-cart">
                                            <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                        </div>
                                    </div>
                                </div>                                                <!-- /product -->
                            </c:forEach>
                            <div id="slick-nav-1" class="products-slick-nav"></div>
                        </div>



                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>



            <!-- NEWSLETTER -->
            <div id="newsletter" class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="">
                                <section class="cd-products-comparison-table">    
                                    <div class="cd-products-table">
                                        
                                        <div class="cd-products-wrapper">
                                            <ul class="cd-products-columns">
                                                <li class="product">
                                                    <ul class="cd-features-list">
                                                        <li>Name</li>
                                                        <li>Price</li>
                                                        <li>Ram</li>
                                                        <li>CPU </li>
                                                        <li>Hard Driver</li>
                                                        <li>Screen</li>
                                                    </ul>
                                                </li>
                                                <li class="product">
                                                    <ul class="cd-features-list">
                                                        <li>${detail.getPname()}</li>
                                                        <li>${detail.getPrice()}</li>
                                                        <li>${detail.getRam()}</li>
                                                        <li>${detail.getCpu()}</li>
                                                        <li>${detail.getHd()}</li>
                                                        <li>${detail.getSc()}</li>
                                                    </ul>
                                                </li> <!-- .product -->
                                                <c:forEach items="${data}" var="p">
                                                    <li class="product">
                                                        <ul class="cd-features-list">
                                                            <li>${p.getPname()}</li>
                                                            <li>${p.getPrice()}</li>
                                                            <li>${p.getRam()}</li>
                                                            <li>${p.getCpu()}</li>
                                                            <li>${p.getHd()}</li>
                                                            <li>${p.getSc()}</li>
                                                        </ul>
                                                    </li> <!-- .product -->
                                                </c:forEach>
                                            </ul> <!-- .cd-products-columns -->
                                        </div> <!-- .cd-products-wrapper -->
                                    </div> <!-- .cd-products-table -->
                                </section>    
                            </div>
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
                            <div class="col-md-3 col-xs-6">
                                <div class="footer">
                                    <h3 class="footer-title">About Us</h3>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut.</p>
                                    <ul class="footer-links">
                                        <li><a href="#"><i class="fa fa-map-marker"></i>1734 Stonecoal Road</a></li>
                                        <li><a href="#"><i class="fa fa-phone"></i>+021-95-51-84</a></li>
                                        <li><a href="#"><i class="fa fa-envelope-o"></i>email@email.com</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-6">
                                <div class="footer">
                                    <h3 class="footer-title">Categories</h3>
                                    <ul class="footer-links">
                                        <li><a href="#">Hot deals</a></li>
                                        <li><a href="#">Laptops</a></li>
                                        <li><a href="#">Smartphones</a></li>
                                        <li><a href="#">Cameras</a></li>
                                        <li><a href="#">Accessories</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="clearfix visible-xs"></div>

                            <div class="col-md-3 col-xs-6">
                                <div class="footer">
                                    <h3 class="footer-title">Information</h3>
                                    <ul class="footer-links">
                                        <li><a href="#">About Us</a></li>
                                        <li><a href="#">Contact Us</a></li>
                                        <li><a href="#">Privacy Policy</a></li>
                                        <li><a href="#">Orders and Returns</a></li>
                                        <li><a href="#">Terms & Conditions</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-6">
                                <div class="footer">
                                    <h3 class="footer-title">Service</h3>
                                    <ul class="footer-links">
                                        <li><a href="#">My Account</a></li>
                                        <li><a href="#">View Cart</a></li>
                                        <li><a href="#">Wishlist</a></li>
                                        <li><a href="#">Track My Order</a></li>
                                        <li><a href="#">Help</a></li>
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
    </body>
</html>
