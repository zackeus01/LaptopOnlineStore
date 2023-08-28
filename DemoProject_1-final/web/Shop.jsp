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
    <%
      List<ProductDisplay> shopProducts = (List<ProductDisplay>)session.getAttribute("shopProduct");  

        ProductTypeDAO ptDao = new ProductTypeDAO();
        ProductDAO pDao = new ProductDAO();
        ReviewDAO reDao = new ReviewDAO();
    %>

    <body>
        <!-- HEADER -->
        <%@include file="HeaderHome.jsp" %>            

        <!-- /BREADCRUMB -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- ASIDE -->
                    <div id="aside" class="col-md-3">
                        <!-- aside Widget -->

                        <!-- /aside Widget -->

                        <!-- aside Widget -->
                        <form action="shop" method="post"id="myform">
                            <div class="aside">
                                <h3 class="aside-title">Price</h3>
                                <div class="price-filter">
                                    <div id="price-slider"></div>
                                    <div class="input-number price-min">
                                        <input id="price-min" type="number" name="minprice" >
                                        <span class="qty-up">+</span>
                                        <span class="qty-down">-</span>
                                    </div>
                                    <span>-</span>
                                    <div class="input-number price-max">
                                        <input id="price-max" type="number" name="maxprice" >
                                        <span class="qty-up">+</span>
                                        <span class="qty-down">-</span>
                                    </div>
                                </div>
                            </div>
                            <!-- /aside Widget -->

                            <!-- aside Widget -->
                            <div class="aside">
                                <h3 class="aside-title">Brand</h3>
                                <div class="checkbox-filter">
                                    <c:forEach items="${sessionScope.sup}" var="s" varStatus="status">
                                        <div class="input-checkbox">
                                            <input class="brand" type="checkbox" id="brand-${status.index}" name="brand" value="${s.getSid()}">
                                            <label for="brand-${status.index}">
                                                <span></span>
                                                ${s.getSname()}
                                                <!--<small>(578)</small>-->
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </form>

                        <!-- /aside Widget -->

                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Top selling</h3>
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="./img/product01.png" alt="">
                                </div>
                                <div class="product-body">
                                    <p class="product-category">Category</p>
                                    <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                    <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                </div>
                            </div>

                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="images/dell1.jpg" alt="">
                                </div>
                                <div class="product-body">
                                    <p class="product-category">Category</p>
                                    <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                    <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                </div>
                            </div>

                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="./img/product03.png" alt="">
                                </div>
                                <div class="product-body">
                                    <p class="product-category">Category</p>
                                    <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                    <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                </div>
                            </div>
                        </div>
                        <!-- /aside Widget -->
                    </div>
                    <!-- /ASIDE -->

                    <!-- STORE -->
                    <div id="store" class="col-md-9">
                        <!-- store top filter -->
                        <div class="store-filter clearfix">
                            <div class="store-sort">
                                <label>
                                    Sort By:
                                    <select class="input-select">
                                        <option value="0">Popular</option>
                                        <option value="1">Position</option>
                                    </select>
                                </label>

                                <label>
                                    Show:
                                    <select class="input-select">
                                        <option value="0">20</option>
                                        <option value="1">50</option>
                                    </select>
                                </label>
                            </div>
                            <ul class="store-grid">
                                <li class="active"><i class="fa fa-th"></i></li>
                                <li><a href="#"><i class="fa fa-th-list"></i></a></li>
                            </ul>
                        </div>
                        <!-- /store top filter -->

                        <!-- store products -->
                        <div class="row">
                            <%  
                                Pagination Page = new Pagination();
                                Page = (Pagination) session.getAttribute("page");
                                int startItem = Page.getStartItem();
                                int lastItem = Page.getLastItem();
                                int index=0;
                                  for (ProductDisplay p : shopProducts) {
                                    if (index >= startItem && index <=lastItem) {
                            %>
                            <!-- product -->
                            <div class="col-md-4 col-xs-6">
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
                                    <form action="shop" method="post">
                                        <div class="add-to-cart">
                                            <button name="addToCart" class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                            <input hidden name="seri" value="<%= p.getSeri()%>">
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <!-- /product -->
                        <%
                            }
                            index++;
                          }
                        %>
                    </div>
                    <!-- /store products -->

                    <!-- store bottom filter -->
                    <%@include file="jspComponent/pagination.jsp" %>
                    <!-- /store bottom filter -->
                </div>
                <!-- /STORE -->
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /SECTION -->

    <!-- NEWSLETTER -->
    <%@include file="jspComponent/newsletter.jsp" %>
    <!-- /NEWSLETTER -->

    <!-- FOOTER -->
    <%@include file="jspComponent/footer.jsp" %>
    <!-- /FOOTER -->

    <!-- jQuery Plugins -->
    <script src="js/shop.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <script src="js/main.js"></script>
    <script src="js/shop.js"></script>

</body>
</html>
