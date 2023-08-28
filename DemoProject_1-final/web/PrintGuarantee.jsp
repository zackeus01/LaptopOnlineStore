<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        
        <script>
        </script>
        <style>
            #success_message{
                display: none;
            }
        </style>
    </head>
    <%
        String msg = (String) request.getAttribute("msg");
        Account acc = (Account) session.getAttribute("acc");
        Guarantee g = (Guarantee) request.getAttribute("g");
        List<String> list = (List<String>) request.getAttribute("list");
    %>
    <body>
        <%@include file="HeaderHome.jsp" %>
        <div class="container">

            <form class="well form-horizontal" action="printGuarantee" method="post"  id="contact_form">
                <fieldset>                    
                        <!-- Form Name -->
                        <legend>Trung tâm bảo hành laptop!</legend>
                        <% if(msg != null){%>
                        <h3 style="text-align: center;"><%= msg%></h3>
                        <%}%>
                        <!-- Text input-->
                        <div class="form-group">
                            <label class="col-md-3 control-label" >Serial Number</label> 
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-tag"></i></span>
                                    <input name="seri" placeholder="Seri" class="form-control"  type="text" value="<%= g.getSeri()%>" readonly>
                                </div>                               
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">FullName</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                    <input  name="name" value="<%= g.getFullname()%>" class="form-control"  type="text" readonly>
                                </div>
                            </div>
                        </div>


                        <!-- Text input-->
                        <div class="form-group">
                            <label class="col-md-3 control-label">Email</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                    <input name="email" value="<%= g.getEmail()%>" class="form-control"  type="text" readonly>
                                </div>
                            </div>
                        </div>


                        <!-- Text input-->

                        <div class="form-group">
                            <label class="col-md-3 control-label">Phone Number</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                                    <input name="phone" value="<%= g.getPhone()%>" class="form-control" type="text" readonly>
                                </div>
                            </div>
                        </div>

                        <!-- Text input-->

                        <div class="form-group">
                            <label class="col-md-3 control-label">Address</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                    <input name="address" value="<%= g.getAddress()%>" class="form-control" type="text" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Date Buy</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input name="buy" value="<%= list.get(0)%>" class="form-control" type="text" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label">Warranty period</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input name="period" value="<%= list.get(1)%>" class="form-control" type="text" readonly>
                                </div>
                                <p id="date" style="display: none; margin: 1% 0% 0% 2%;"></p>
                            </div>
                        </div>
                                <%
                                            int price = (int)  g.getExpense();
                                   String result = String.format("%,d", price);
                                        %>
                        <div class="form-group">
                            <label class="col-md-3 control-label"> Expense</label>  
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
                                    <input name="expense" value="<%= result%>" id="numberInput" oninput="formatNumber()" class="form-control" type="text" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label" >Describe</label> 
                            <div class="col-md-6 inputGroupContainer">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-comment"></i></span>
                                    <textarea name="describe" placeholder="Mô tả tình trạng laptop của bạn" class="form-control"  type="text" row ="2" readonly><%= g.getDescribe()%></textarea>
                                </div>
                            </div>
                        </div>                                      

                    <!-- Button -->
                    <div class="form-group">
                        <label class="col-md-3 control-label"></label>
                        <div class="col-md-4">
                            <button class="btn btn-warning" onclick="printInvoice()" >Xuất file<span class="glyphicon glyphicon-send"></span></button>
                        </div>

                    </div>

                </fieldset>
            </form>              
        </div>
        <%@include file="Footer.jsp" %>
        <script type="text/javascript">
                function formatDate(date) {
                    var day = date.getDate();
                    var month = date.getMonth() + 1;
                    var year = date.getFullYear();
                    return day + "/" + month + "/" + year;
                }                
                function formatNumber() {
                    var input = document.getElementById("numberInput");
                    var value = input.value;
                    // Loại bỏ tất cả các ký tự không phải số và dấu chấm
                    value = value.replace(/[^\d.]/g, "");
                    // Chèn dấu phẩy giữa các cụm ba số liên tiếp
                    value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    // Gán giá trị đã định dạng vào ô input
                    input.value = value;
                }              
        </script>
    </body>
</html>
