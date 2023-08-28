<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.*" %>
<%@page import="java.util.List" %>
<!doctype html>
<html lang="en">

    <head>
        <title>Login 05</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="css/style1.css">
        <link rel="stylesheet" href="css/accountcreate.css">

    </head>
    
 
    
    <body>
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6 text-center mb-5">
                        <h2 class="heading-section">Login #05</h2>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-md-7 col-lg-5">
                        <div class="wrap">
                            <div class="img" style="background-image: url(images/bg-1.jpg);"></div>
                            <div class="login-wrap p-4 p-md-5">
                                <div class="d-flex">
                                    <div class="w-100">
                                        <h3 class="mb-4">Sign Up</h3>
                                    </div>
                                    <div class="w-100">
                                    </div>
                                </div>
                                <form method="post" class="signin-form"  action="registerr">
                                    <div class="form-group mt-3">
                        
                                        <input type="text" class="form-control" required name="username" value ="${username}"  >
                                        <label class="form-control-placeholder" for="username">Account Name</label>
                                    </div>
                                    <div><p class = "text-danger" style ="font-size: 11px; color: red">${mess5}</p></div>
                                    <div class="form-group">
                       
                                        <input id="password-field" type="password" class="form-control" required
                                               name="pass" value = "${pass}">
                                        <label class="form-control-placeholder" for="password">Password</label>
                                        <span toggle="#password-field"
                                              class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                    </div>
                                    <div><p class = "text-danger" style ="font-size: 11px; color: red">${mess}</p></div>
                                    <div><p class = "text-danger" style ="font-size: 11px; color: red">${mess1}</p></div>
                                    <div><p class = "text-danger" style ="font-size: 11px; color: red">${mess2}</p></div>
                                    <div class="form-group">
                                        <input id="password-field" type="password" class="form-control" required
                                               name="repass" value="${repass}">
           
                                        <label class="form-control-placeholder" for="password">Re-Password</label>
                                        <span toggle="#password-field"
                                              class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                    </div>
                                    <div><p class = "text-danger" style ="font-size: 11px; color: red">${mess3}</p></div>
                                    <div class="form-group mt-3">

                                        <input type="text" class="form-control" required name="fname" value ="${fname}" >
                                        <label class="form-control-placeholder" for="username">First Name</label>
                                    </div>
                                    <div class="form-group mt-3">

                                        <input type="text" class="form-control" required name="lname" value ="${lname}" >

                                        <label class="form-control-placeholder" for="username">Last Name</label>
                                    </div>
                                    <div class="form-group mt-3">

                                        <input type="text" class="form-control" required name="email"  value = "${email}">
                                        <label class="form-control-placeholder" for="username">Email</label>
                                    </div>
                                    <div><p class = "text-danger" style ="font-size: 11px; color: red">${mess4}</p></div>
                                    <div class="form-group mt-3">
                          
                                        <input type="text" class="form-control" required name="phone"  value = "${phone}">
                                        <label class="form-control-placeholder" for="username">Phone Number</label>
                                    </div>
                                    <div class="form-group mt-3">

                                        <input type="text" class="form-control" required name="address"  value ="${address}">
                                        <label class="form-control-placeholder" for="username">Address</label>
                                    </div>
                                    <div >
                                        <p style="color: #01d28e"> <input type="checkbox" required name ="checkbox" value="yes"> I agree to the terms!</p>
                                        <div><p class = "text-danger" style ="font-size: 11px; color: red">${mess6}</p></div>
                                    </div>
                                    <br> 
                                    <div class="form-group">
                                        <button type="submit" class="form-control btn btn-primary rounded submit px-3">Sign
                                            Up</button>
                                    </div>
                                    <div class="text-danger">
                                        <a>${error}</a>
                                    </div>
                                    <div class="text-danger">
                                        <a href="Login.jsp" class="cta-btn">${errorr} <i class="fa fa-arrow-circle-right"></i></a>
                                    </div>

                                    <div class="form-group d-md-flex" style="margin-left: 111px;">

                                        <div class="w-50 text-md-right">
                                            <a href="#">  Forgot Password</a>
                                        </div>
                                    </div>
                                </form>
                                <p class="text-center">Already have an account! <a data-toggle="tab" href="#signup">Sign In</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script src="js/jquery.min1.js"></script>
        <script src="js/popper1.js"></script>
        <script src="js/bootstrap.min1.js"></script>
        <script src="js/main1.js"></script>

    </body>

</html>