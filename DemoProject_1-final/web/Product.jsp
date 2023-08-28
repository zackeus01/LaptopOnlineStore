<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import = "Context.*" %>
<%@page import = "Model.*" %>
<%@page import= "java.util.*" %>
<%@page import= "java.time.LocalDateTime" %>
<%@page import= "java.time.format.DateTimeFormatter" %>
<%@page import= "java.text.DecimalFormat" %>
<html lang="en">
    <head>
        <%
        DecimalFormat df = new DecimalFormat("#0.0");
        List<Review> reviews = new ArrayList<>();
        if (session.getAttribute("reviews") != null) {
            reviews = (List<Review>) session.getAttribute("reviews");
        }
        Product p = (Product) session.getAttribute("p");
        ProductType pt = (ProductType) session.getAttribute("pt");
        %>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title><%= pt.getPname() %></title>

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

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>
    <body>
        <!-- HEADER -->
        <%@include file="HeaderHome.jsp" %>     

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- Product main img -->
                    <div class="col-md-5 col-md-push-2">
                        <div id="product-main-img">
                            <c:forEach items="${sessionScope.images}" var="img">
                                <div class="product-preview">
                                    <img src="${img}" alt="">
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- /Product main img -->

                    <!-- Product thumb imgs -->
                    <div class="col-md-2  col-md-pull-5">
                        <div id="product-imgs">
                            <c:forEach items="${sessionScope.images}" var="img">
                                <div class="product-preview">
                                    <img src="${img}" alt="">
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- /Product thumb imgs -->

                    <!-- Product details -->
                    <div class="col-md-5">
                        <div class="product-details">
                            <h2 class="product-name"><%= pt.getPname() %></h2>
                            <div>
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
                                <a class="review-link" href="#tab3"><%= reviews.size() %> Review(s) | Add your review</a>
                            </div>
                            <div>
                                <h3 class="product-price"><%= fm.formatPrice(p.getPrice()) %>
                                    <del class="product-old-price"><%= fm.formatPrice(p.getPrice()) %></del>
                                </h3>
                                <% 
                                    if (pt.getQuantity() > 0) {
                                %>
                                <span class="product-available">In Stock</span>
                                <% } 
                                    if (pt.getQuantity() == 0) {
                                %>
                                <span class="product-available">Out Of Stock</span>
                                <% } %>
                            </div>
                            <p><%= pt.getDescribe() %></p>

                            <div class="add-to-cart">
                                <div class="qty-label">
                                    Qty
                                    <div class="input-number">
                                        <input id="quantityInput<%= p.getSeri() %>" type="text" value="1">
                                        <span class="qty-up" onclick="incrementValue('<%= p.getSeri() %>')">+</span>
                                        <span class="qty-down" onclick="decrementValue('<%= p.getSeri() %>')">-</span>
                                    </div>
                                </div>
                                <form action="cart" method="post" style="display: inline;">
                                    <% if (session.getAttribute("acc") != null) { %>
                                    <button type="button" class="add-to-cart-btn" onclick="addToCart('<%= p.getSeri() %>')">
                                        <i class="fa fa-shopping-cart"></i> add to cart
                                    </button>
                                    <% } else { %>
                                    <button type="button" class="add-to-cart-btn" onclick="redirectToLogin()">
                                        <i class="fa fa-shopping-cart"></i> add to cart
                                    </button>
                                    <% } %>

                                    <script>
                                        function redirectToLogin() {
                                            window.location.href = "Login.jsp";
                                        }
                                    </script>

                                </form>


                            </div>

                            <ul class="product-btns">
                                <li><a href="#"><i class="fa fa-heart-o"></i> add to wishlist</a></li>
                                <li><a href="#"><i class="fa fa-exchange"></i> add to compare</a></li>
                            </ul>

                            <ul class="product-links">
                                <li>Category:</li>
                                <li><a href="#">Headphones</a></li>
                                <li><a href="#">Accessories</a></li>
                            </ul>

                            <ul class="product-links">
                                <li>Share:</li>
                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                <li><a href="#"><i class="fa fa-envelope"></i></a></li>
                            </ul>

                        </div>
                    </div>
                    <!-- /Product details -->

                    <!-- Product tab -->
                    <div class="col-md-12">
                        <div id="product-tab">
                            <!-- product tab nav -->
                            <ul class="tab-nav">
                                <li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
                                <li><a data-toggle="tab" href="#tab2">Details</a></li>
                                <li><a data-toggle="tab" href="#tab3">Reviews (<%= reviews.size() %>)</a></li>
                            </ul>
                            <!-- /product tab nav -->

                            <!-- product tab content -->
                            <div class="tab-content">
                                <!-- tab1  -->
                                <div id="tab1" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p><%= pt.getDescribe() %></p>
                                        </div>
                                    </div>
                                </div>
                                <!-- /tab1  -->

                                <!-- tab2  -->
                                <div id="tab2" class="tab-pane fade in">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="container">
                                                <div class="laptop-detail">
                                                    <div class="detail-item">
                                                        <span class="detail-title">Ram</span>
                                                        <span class="detail-content"><%= pt.getRam() %></span>
                                                    </div>
                                                    <div class="detail-item">
                                                        <span class="detail-title">CPU</span>
                                                        <span class="detail-content"><%= pt.getCpu() %></span>
                                                    </div>
                                                    <div class="detail-item">
                                                        <span class="detail-title">Hard Drive</span>
                                                        <span class="detail-content"><%= pt.getHarddriver() %></span>
                                                    </div>
                                                    <div class="detail-item">
                                                        <span class="detail-title">Screen</span>
                                                        <span class="detail-content"><%= pt.getScreen() %></span>
                                                    </div>
                                                    <div class="detail-item">
                                                        <span class="detail-title">Color</span>
                                                        <span class="detail-content"><%= pt.getColor() %></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /tab2  -->

                                <!-- tab3  -->
                                <div id="tab3" class="tab-pane fade in">
                                    <div class="row">
                                        <!-- Rating -->
                                        <div class="col-md-3">
                                            <div id="rating">

                                                <div class="rating-avg">
                                                    <span><%= df.format(avg) %></span>
                                                    <div class="rating-stars">
                                                        <% 
                                                            for (int i=0; i<totalStar; i++) { 
                                                        %>
                                                        <i class="fa fa-star"></i>
                                                        <%  } for (int i=0; i<5-totalStar; i++) { %>
                                                        <i class="fa fa-star-o empty"></i>
                                                        <% } %>
                                                    </div>
                                                </div>
                                                <ul class="rating">
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: <%= fivePercentage %>%;"></div>
                                                        </div>
                                                        <span class="sum"><%= five %></span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: <%= fourPercentage %>%;"></div>
                                                        </div>
                                                        <span class="sum"><%= four %></span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: <%= threePercentage %>%;"></div>
                                                        </div>
                                                        <span class="sum"><%= three %></span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: <%= twoPercentage %>%;"></div>
                                                        </div>
                                                        <span class="sum"><%= two %></span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: <%= onePercentage %>%;"></div>
                                                        </div>
                                                        <span class="sum"><%= one %></span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- /Rating -->

                                        <!-- Reviews -->
                                        <div class="col-md-6">
                                            <div id="reviews">
                                                <ul class="reviews">
                                                    <%
                                                        if (reviews.isEmpty() || reviews.size()==0) {
                                                    %>
                                                    <p class="review-notification">There aren't any reviews yet</p>
                                                    <%    }
                                                    else {
                                                        Pagination Page = new Pagination();
                                                        Page = (Pagination) session.getAttribute("rpage");
                                                        int startItem = Page.getStartItem();
                                                        int lastItem = Page.getLastItem();
                                                        int index=0;
                                                          for (Review r : reviews) {
                                                            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd MMM YYYY, h:mm a");
                                                            if (index >= startItem && index <=lastItem) {
                                                    %>
                                                    <li>
                                                        <div class="review-heading">
                                                            <h5 class="name"><%= r.getName() %></h5>
                                                            <p class="date"><%= dtf.format(r.getPostTime()) %></p>
                                                            <div class="review-rating">
                                                                <% int count = r.getRating();
                                                                    for (int i=0; i<5; i++) { 
                                                                        if (count > 0) {
                                                                %>
                                                                <i class="fa fa-star"></i>
                                                                <%      } else { %>
                                                                <i class="fa fa-star-o empty"></i>
                                                                <% } count--;
                                                                } %>
                                                            </div>
                                                        </div>
                                                        <div class="review-body">
                                                            <p><%= r.getReview() %></p>
                                                        </div>
                                                    </li>
                                                    <%
                                                        }
                                                        index++;
                                                      }
                                                    %>
                                                </ul>
                                                <ul class="reviews-pagination">
                                                    <c:if test="${sessionScope.rpage.getTotalPage()==1}">
                                                        <li class="active"><a href="product?seri=<%=p.getSeri()%>&rcp=1">1</a></li>
                                                        </c:if>
                                                        <c:if test="${sessionScope.rpage.getTotalPage()!=1}">
                                                            <c:if test="${sessionScope.rpage.getCurrentPage()==1}">
                                                            <li class="active"><a href="product?seri=<%=p.getSeri()%>&rcp=1">1</a></li>
                                                            <li><a href="product?seri=<%=p.getSeri()%>&rcp=2">2</a></li>
                                                            <li><a href="product?seri=<%=p.getSeri()%>&rcp=${sessionScope.rpage.getTotalPage()}">>></a></li>
                                                            </c:if>
                                                            <c:if test="${sessionScope.rpage.getCurrentPage()>1&&sessionScope.rpage.getCurrentPage()<sessionScope.rpage.getTotalPage()}">
                                                            <li><a href="product?seri=<%=p.getSeri()%>&rcp=1"><<</a></li>
                                                            <li><a href="product?seri=<%=p.getSeri()%>&rcp=${sessionScope.rpage.getCurrentPage()-1}">${sessionScope.rpage.getCurrentPage()-1}</a></li>
                                                            <li class="active"><a href="product?seri=<%=p.getSeri()%>&rcp=${sessionScope.rpage.getCurrentPage()}">${sessionScope.rpage.getCurrentPage()}</a></li>
                                                            <li><a href="product?seri=<%=p.getSeri()%>&rcp=${sessionScope.rpage.getCurrentPage()+1}">${sessionScope.rpage.getCurrentPage()+1}</a></li>
                                                            <li><a href="product?seri=<%=p.getSeri()%>&rcp=${sessionScope.rpage.getTotalPage()}">>></a></li>
                                                            </c:if>
                                                            <c:if test="${sessionScope.rpage.getCurrentPage()==sessionScope.rpage.getTotalPage()}">
                                                            <li><a href="product?seri=<%=p.getSeri()%>&rcp=1"><<</a></li>
                                                            <li><a href="product?seri=<%=p.getSeri()%>&rcp=${sessionScope.rpage.getCurrentPage()-1}">${sessionScope.rpage.getCurrentPage()-1}</a></li>
                                                            <li class="active"><a href="product?seri=<%=p.getSeri()%>&rcp=${sessionScope.rpage.getCurrentPage()}">${sessionScope.rpage.getCurrentPage()}</a></li>
                                                            </c:if>
                                                        </c:if>
                                                </ul>
                                                <% } %>
                                            </div>
                                        </div>
                                        <!-- /Reviews -->

                                        <!-- Review Form -->
                                        <div class="col-md-3">
                                            <form class="review-form">
                                                <c:if test="${sessionScope.acc != null}">
                                                    <c:set var="acc" value="${sessionScope.acc}" />
                                                    <c:set var="fullName" value="${acc.getFname()} ${acc.getLname()}" />
                                                </c:if>
                                                <input id="nameInput" class="input" type="text" placeholder="Your Name" value="${fullName}">
                                                <input id="emailInput" class="input" type="email" placeholder="Your Email" value="${acc.getEmail()}">
                                                <textarea id="reviewInput" class="input" placeholder="Your Review"></textarea>
                                                <div class="input-rating">
                                                    <span>Your Rating: </span>
                                                    <div class="stars">
                                                        <input id="star5" name="rating" value="5" type="radio"><label for="star5"></label>
                                                        <input id="star4" name="rating" value="4" type="radio"><label for="star4"></label>
                                                        <input id="star3" name="rating" value="3" type="radio"><label for="star3"></label>
                                                        <input id="star2" name="rating" value="2" type="radio"><label for="star2"></label>
                                                        <input id="star1" name="rating" value="1" type="radio"><label for="star1"></label>
                                                    </div>
                                                </div>
                                                <button name="addReview" class="primary-btn" onclick="submitReview()">Submit</button>
                                                <input hidden name="seri" value="<%= p.getSeri() %>">
                                                <input hidden name="name" id="nameInputHidden">
                                                <input hidden name="email" id="emailInputHidden">
                                                <input hidden name="review" id="reviewInputHidden">
                                                <input hidden name="rating" id="ratingInputHidden">
                                            </form>
                                            <p id="notification" style="color: red; display: none;"></p>
                                        </div>
                                        <!-- /Review Form -->

                                    </div>
                                </div>
                                <!-- /tab3  -->
                            </div>
                            <!-- /product tab content  -->
                        </div>
                    </div>
                    <!-- /product tab -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- Section -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">

                    <div class="col-md-12">
                        <div class="section-title text-center">
                            <h3 class="title">Related Products</h3>
                        </div>
                    </div>

                    <!-- product -->
                    <div class="col-md-3 col-xs-6">
                        <div class="product">
                            <div class="product-img">
                                <img src="./img/product01.png" alt="">
                                <div class="product-label">
                                    <span class="sale">-30%</span>
                                </div>
                            </div>
                            <div class="product-body">
                                <p class="product-category">Category</p>
                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                <div class="product-rating">
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
                    <!-- /product -->

                    <!-- product -->
                    <div class="col-md-3 col-xs-6">
                        <div class="product">
                            <div class="product-img">
                                <img src="./img/product02.png" alt="">
                                <div class="product-label">
                                    <span class="new">NEW</span>
                                </div>
                            </div>
                            <div class="product-body">
                                <p class="product-category">Category</p>
                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                <div class="product-rating">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
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
                    <!-- /product -->

                    <div class="clearfix visible-sm visible-xs"></div>

                    <!-- product -->
                    <div class="col-md-3 col-xs-6">
                        <div class="product">
                            <div class="product-img">
                                <img src="./img/product03.png" alt="">
                            </div>
                            <div class="product-body">
                                <p class="product-category">Category</p>
                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                <div class="product-rating">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-o"></i>
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
                    <!-- /product -->

                    <!-- product -->
                    <div class="col-md-3 col-xs-6">
                        <div class="product">
                            <div class="product-img">
                                <img src="./img/product04.png" alt="">
                            </div>
                            <div class="product-body">
                                <p class="product-category">Category</p>
                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                <div class="product-rating">
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
                    <!-- /product -->

                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /Section -->

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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/productDetail.js"></script>

    </body>
</html>
