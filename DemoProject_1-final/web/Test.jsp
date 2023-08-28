<%-- 
    Document   : Test
    Created on : May 30, 2023, 10:59:57 AM
    Author     : Dinh Nguyen
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import = "Context.*" %>
<%@page import = "Model.*" %>
<%@page import= "java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1><%= format(1000000) %></h1>
        <script src="js/cart.js"></script>
        
    </body>
</html>
