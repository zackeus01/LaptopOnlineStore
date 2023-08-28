<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="css/accountcreate.css">
    </head>
    <body>

        <form method="POST" class="form" action="register2">
            <div class="title">Welcome</div>
            <div class="subtitle">Enter your infomation</div>

            <div class="input-container ic2">
                <input id="AccountName" class="input" type="text" placeholder=" " name="acname">
                <div class="cut"></div>
                <label for="text" class="placeholder">Account Name</label>
            </div>
            <div class="input-container ic2">
                <input id="pass" class="input" type="password" placeholder="" name="pass">
                <div class="cut cut-short"></div>
                <label for="address" class="placeholder"><Address>Pass</Address></label>
            </div>
            <div class="text-danger">
                <a>${errol}</a>
            </div>
            <button type="submit button" class="submit">Create Account</button>


        </form>
    </body>
</html>