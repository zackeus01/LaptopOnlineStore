<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
    <head>
        <title>Login 05</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="css/accountcreate.css">


    </head>
    <body>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v17.0&appId=YOUR_APP_ID&autoLogAppEvents=1"></script>


        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                </div>
                <div class="row justify-content-center">
                    <div class="col-md-7 col-lg-5">
                        <div class="wrap">
                            <div class="img" style="background-image: url(https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//News/1499962//laptop-20-800x450-2.jpg);"></div>
                            <div class="login-wrap p-4 p-md-5">
                                <div class="d-flex">
                                    <div class="w-100">
                                        <h3 class="mb-4">Sign In</h3>
                                    </div>



                                    <!-- The JS SDK Login Button -->


                                    <div class="w-100">
                                        <p class="social-media d-flex justify-content-end">
                                            <a href="https://www.facebook.com/v17.0/dialog/oauth?client_id=793594985493909&redirect_uri=http://localhost:9999/DemoProject_1_bk/facebook-login&scope=email" class="social-icon d-flex align-items-center justify-content-center"><span class="fa fa-facebook"></span></a>
                                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:8080/DemoProject_1_bk/LoginGG&response_type=code&client_id=246464562091-p1hb056q2pbgg21c46t3fk931dga40ct.apps.googleusercontent.com&approval_prompt=force"
                                               class="social-icon d-flex align-items-center justify-content-center"><span
                                                    class="fa fa-google"></span></a>
                                        </p>
                                    </div>

                                </div>
                                <form action="login" class="signin-form" method="post">
                                    <div class="form-group mt-3"> 
                                        <input type="text" class="form-control" required name="acname">
                                        <label class="form-control-placeholder" for="username">Username</label>
                                    </div>
                                    <div class="form-group">
                                        <input id="password-field" type="password" class="form-control" required name="pass">
                                        <label class="form-control-placeholder" for="password">Password</label>
                                        <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="form-control btn btn-primary rounded submit px-3">Sign In</button>
                                    </div>
                                    <div class="text-danger">
                                        <a>${error}</a>
                                    </div>
                                    <div class="form-group d-md-flex">
                                        <div class="w-50 text-left">
                                            <label class="checkbox-wrap checkbox-primary mb-0">Remember Me
                                                <input type="checkbox" checked>
                                                <span class="checkmark"></span>
                                            </label>
                                        </div>
                                        <div class="w-50 text-md-right">
                                            <a href="Email.jsp">Forgot Password</a>
                                        </div>
                                    </div>
                                </form>

                                <p class="text-center">Not a member? <a href="Register.jsp">Sign Up</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <script src="js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>

