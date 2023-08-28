<%-- 
    Document   : HeaderHome
    Created on : Jun 8, 2023, 7:08:39 PM
    Author     : win
--%>

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

    </head>
    <%
        SupplierDAO supDao = new SupplierDAO();
        MyFormatter fm = new MyFormatter();
        List<Supplier> supList = supDao.getAllSupplier();
        List<Cart> wishlists = new ArrayList<>();
        List<Cart> carts = new ArrayList<>();
        if (session.getAttribute("Cart") != null) {
            carts = (List<Cart>) session.getAttribute("Cart");
        }
        if (session.getAttribute("WistList") != null) {
            wishlists = (List<Cart>) session.getAttribute("WistList");
        }

    %>
    <body>
        <!-- HEADER -->
        <header>
            <!-- TOP HEADER -->
            <div id="top-header">
                <div class="container">

                    <ul class="header-links pull-left">
                        <c:forEach items="${aa}" var="item">
                            <c:if test="${item.getNwId() == 1}">
                                <li><a href="#"><i class="fa fa-phone">${item.getTitle()}</i></a></li>
                                    </c:if>
                                    <c:if test="${item.getNwId() == 2}">
                                <li><a href="#"><i class="fa fa-envelope-o">${item.getTitle()}</i></a></li>
                                    </c:if>
                                    <c:if test="${item.getNwId() == 3}">
                                <li><a href="#"><i class="fa fa-map-marker">${item.getTitle()}</i></a></li>
                                    </c:if>
                                </c:forEach>

                    </ul>
                    <ul class="header-links pull-right">
                        <c:if test="${sessionScope.acc != null}">
                            <li><a href="logout"><i class="fa fa-user-o"></i> Logout</a></li>
                            </c:if>
                            <c:if test="${sessionScope.acc == null}">
                            <li><a href="Login.jsp"><i class="fa fa-user-o"></i> Login</a></li>
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
            <!-- /TOP HEADER -->

            <!-- MAIN HEADER -->
            <div id="header">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <!-- LOGO -->
                        <div class="col-md-3">
                            <div class="header-logo">
                                <a href="home" class="logo">
                                    <img src="./img/logo.png" alt="">
                                </a>
                            </div>
                        </div>
                        <!-- /LOGO -->

                        <!-- SEARCH BAR -->
                        <div class="col-md-6">
                            <div class="header-search">
                                <form action="searchhome" method="post">
                                    <select class="input-select">
                                        <option value="0">All Categories</option>                                       
                                    </select>
                                    <input class="input" id="search" name="key" placeholder="Search here">
                                    <button class="search-btn">Search</button>
                                    <ul id="searchResults" class=""></ul>
                                </form>
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
                                        xhr.open('GET', 'searchhome?keyword=' + keyword, true);
                                        xhr.onreadystatechange = function () {
                                            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                                                var products = JSON.parse(xhr.responseText);

                                                // Display the search results
                                                for (var i = 0; i < products.length; i++) {
                                                    var li = document.createElement('li');
                                                    var productLink = document.createElement('a');
                                                    productLink.href = 'searchhomesmart?value=' + products[i].value + '&table=' + products[i].table + '&colum=' + products[i].colum; // Set the link URL
                                                    var productName = products[i].value;
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

                        </div>
                        <!-- /SEARCH BAR -->

                        <!-- ACCOUNT -->
                        <div class="col-md-3 clearfix">
                            <div class="header-ctn">
                                <!-- Wishlist -->
                                <div class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                        <i class="fa fa-shopping-cart"></i>
                                        <span>Your WishList</span>
                                        <% if (wishlists == null || wishlists.size()==0) { %>
                                        <div class="qty">0</div>
                                        <% } %>
                                        <% if (wishlists != null || wishlists.size()>0) { %>
                                        <div class="qty"><%= wishlists.size() %></div>
                                        <% } %>
                                    </a>
                                    <!-- wishlist dropdown -->
                                    <div class="cart-dropdown">
                                        <% if (wishlists != null && !wishlists.isEmpty()) { %>
                                        <div class="cart-list">
                                            <!-- Wishlist Items -->
                                            <% for (Cart c : wishlists) { %>
                                            <div class="product-widget">
                                                <div class="product-img">
                                                    <img src="<%= c.getImg() %>" alt="">
                                                </div>
                                                <div class="product-body">
                                                    <h3 class="product-name"><a href="#"><%= c.getpName() %></a></h3>
                                                    <h4 class="product-price"><fmt:formatNumber type="currency" value="<%= c.getPrice() %>" currencyCode="VND" maxFractionDigits="0" /></h4>
                                                </div>
                                                <a href="wishlist?seri=<%= c.getSeri() %>&delwishlish=2"><button name="delwishlish" class="delete"><i class="fa fa-close"></i></button></a>
                                            </div>
                                            <% } %>
                                            <!-- Wishlist Items -->
                                        </div>
                                        <% } else { %>
                                        <div class="empty-wishlist-notification">
                                            Your Wishlist is empty!
                                        </div>
                                        <% } %>
                                    </div>
                                </div>
                                <!-- /Wishlist -->


                                <!-- Cart -->
                                <div class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                        <i class="fa fa-shopping-cart"></i>
                                        <span>Your Cart</span>
                                        <% if (carts == null || carts.size()==0) { %>
                                        <div class="qty">0</div>
                                        <% } %>
                                        <% if (carts != null || carts.size()>0) { %>
                                        <div class="qty"><%= carts.size() %></div>
                                        <% } %>
                                    </a>
                                    <!-- cart dropdown -->
                                    <div id="cartContainer" class="cart-dropdown">
                                        <div class="cart-list">
                                            <% if (carts != null && !carts.isEmpty()) { %>
                                            <!-- Cart Items -->
                                            <% for (Cart c : carts) { %>
                                            <div class="product-widget">
                                                <div class="product-img">
                                                    <img src="<%= c.getImg() %>" alt="">
                                                </div>
                                                <div class="product-body">
                                                    <h3 class="product-name"><a href="#"><%= c.getpName() %></a></h3>
                                                    <h4 class="product-price"><span class="qty"><%= c.getQuantity() %>x</span><%= fm.formatPrice(c.getPrice()) %></h4>
                                                </div>
                                                <a href="cart?seri=<%= c.getSeri() %>&delSmall=1"><button name="delSmall" class="delete"><i class="fa fa-close"></i></button></a>
                                            </div>
                                            <% } %>
                                            <% } else { %>
                                            <div class="empty-cart-notification">
                                                Your cart is empty!
                                            </div>
                                            <% } %>
                                            <!-- Cart Items -->
                                        </div>
                                        <div class="cart-summary">
                                            <small><%= carts.size() %> Item(s) selected</small>
                                            <% float total = 0;
                                                for (Cart c : carts) { 
                                                    total += c.getQuantity() * c.getPrice();
                                                }
                                            %>
                                            <h5>SUBTOTAL: <fmt:formatNumber type="currency" value="<%= total %>" currencyCode="VND" maxFractionDigits="0" /></h5>
                                        </div>
                                        <div class="cart-btns">
                                            <a href="cart?btnViewCart=1">View Cart</a>
                                            <a href="checkout">Checkout <i class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div>
                                    <!-- cart dropdown -->
                                </div>
                                <!-- Cart -->

                                <!-- Menu Toogle -->
                                <div class="menu-toggle">
                                    <a href="#">
                                        <i class="fa fa-bars"></i>
                                        <span>Menu</span>
                                    </a>
                                </div>
                                <!-- /Menu Toogle -->
                            </div>
                        </div>
                        <!-- /ACCOUNT -->
                    </div>
                    <!-- row -->
                </div>
                <!-- container -->
            </div>
            <!-- /MAIN HEADER -->
        </header>
        <!-- /HEADER -->

        <!-- NAVIGATION -->
        <nav id="navigation">
            <!-- container -->
            <div class="container">
                <!-- responsive-nav -->
                <div id="responsive-nav">
                    <!-- NAV -->
                    <ul class="main-nav nav navbar-nav">
                        <c:forEach items="${aa}" var="item">
                            <c:if test="${item.getNwId() == 4}">
                                <li class="active"><a href="home">${item.getTitle()}</a></li>
                                </c:if>
                                <c:if test="${item.getNwId() == 5}">
                                <li class=""><a href="Warranty.jsp">${item.getTitle()}</a></li>
                                </c:if>
                            </c:forEach>
                    </ul>

                    <!-- /NAV -->
                </div>
                <!-- /responsive-nav -->
            </div>
            <!-- /container -->
        </nav>

    </body>
</html>
