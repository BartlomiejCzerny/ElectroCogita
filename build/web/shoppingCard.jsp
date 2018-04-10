<%@page import="system.edycji.EditUserServlet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="shopping.cart.Cart2"%>
<%@page import="src.PolaczenieDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="system.rejestracji.*"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="author" content="Script Tutorials" />
        <title>Shopping card</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <!-- attach CSS styles -->
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" />
    </head>

    <body style="background-image: linear-gradient(to right bottom, #ff1919, #ff4c4c)">
        <p></p>
        <!-- navigation panel -->
        <div class="navbar-wrapper">
            <div class="container">
                <nav class="navbar navbar-inverse" role="navigation">
                    <div class="container-fluid">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-main"> <span class="sr-only">Toggle navigation</span>  <span class="icon-bar"></span>  <span class="icon-bar"></span>  <span class="icon-bar"></span> 
                            </button> <a class="navbar-brand" href="index.jsp">ElectroCogita</a>
                        </div>
                        <div class="collapse navbar-collapse" id="navbar-collapse-main">
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="index.jsp">Home</a>
                                </li>
                                <li><a href="products.jsp">Products</a>
                                </li>
                                <li><a href="contact_support.jsp">Contact</a>
                                </li>

                                <%
                                    if (session.getAttribute("User") != null) {
                                %> 


                                <%}%>




                                <%
                                    if (session.getAttribute("Admin") != null) {

                                %> 

                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">AdminMenager<span class="caret"></span></a>
                                    <ul class="dropdown-menu" role="menu">
                                        <li><a href="accMenager.jsp">AccountMenager</a></li>
                                        <li><a href="productMenager.jsp">ProductMenager</a></li>
                                        <li><a href="raports.jsp">Raports</a></li>

                                    </ul>
                                </li>




                                <%}%>

                                <%
                                    if (session.getAttribute("Pracownik") != null) {
                                %> 


                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">WorkerMenager<span class="caret"></span></a>
                                    <ul class="dropdown-menu" role="menu">
                                        <li><a href="productMenager.jsp">ProductMenager</a></li>
                                        <li><a href="raports.jsp">Raports</a></li>


                                    </ul>
                                </li>




                                <%}%>


                                <%
                                    if (session.getAttribute("Admin") == null && session.getAttribute("Pracownik") == null && session.getAttribute("User") == null) {
                                %> 
                                <li><a href="register.jsp">Register</a></li>
                                <li><a href="sign_in.jsp">Sign in</a></li>

                                <%}%>
                                <%

                                    Connection conn = null;
                                    Statement stat = null;
                                    ResultSet res = null;


                                %>
                                <%                         if (session.getAttribute("Admin") != null || session.getAttribute("Pracownik") != null || session.getAttribute("User") != null) {%>
                                <li>   <form  action="shoppingcart" name="formBuy" method="post">
                                        <button class="btn btn-large" id="btmProductBuy" name="iconCard" value="true" style=" background-color: lightslategrey; padding: 4px 8px; margin-right:12px; margin-top: 5px;" ><span style="color:#fff; font-size: 20px; margin-top: 0px; margin-left:9px; margin-right:12px;" class="glyphicon glyphicon-shopping-cart" ></span></button>
                                    </form></li>
                                <li style="color:lightskyblue; margin-top: 14px; font-size:17px; "> 

                                    <%=(session.getAttribute("Admin") == null) ? "" : " | Welcome! " + session.getAttribute("Admin") + " |"%>
                                    <%=(session.getAttribute("Pracownik") == null) ? "" : " | Welcome! " + session.getAttribute("Pracownik") + " |"%>
                                    <%=(session.getAttribute("User") == null) ? "" : " | Welcome! " + session.getAttribute("User") + " |"%>
                                </li>

                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">MyPanel<span class="caret"></span></a>
                                    <ul class="dropdown-menu" role="menu">

                                        <li><a href="orderHistory.jsp" style="color: #3aa343; font-weight: bold;" >My Order</a></li>
                                        <li><a href="logout" style="color: #bc7820; font-weight: 600; font-size: 14px;  ">Logout!</a></li>

                                    </ul>
                                </li>


                                <%}%>

                            </ul>
                        </div>
                        <!-- /.navbar-collapse -->
                    </div>
                    <!-- /.container-fluid -->
                </nav>
            </div>
        </div>


        <link href="css/style.css" rel="stylesheet">
        <style><%@include file="css/style.css"%></style>

        <div class="container" id="BodyProduct" >    



            <%

                boolean anyProduct = false;
                String s2;
                conn = PolaczenieDB.getConnection();
                stat = conn.createStatement();

                s2 = String.valueOf(request.getAttribute("anyProduct"));

                anyProduct = Boolean.parseBoolean(s2);
                double suma = 0;

            %>



            <div class="container">    
                <% if (anyProduct) {

                        List<Cart2> list = (List<Cart2>) session.getAttribute("list");
                       if (list.size() != 0) {%>

                <%
                    for (int i = 0; i < list.size(); i++) {

                %>
                <table class="table table-striped">

                    <thead>
                        <tr>
                            <!-- <th>id_product</th> --->
                            <th>Name</th>
                            <th>Type</th>
                            <th>Price</th>
                            <!-- <th>Game key</th> --->
                            <!-- <th>Image</th> --->


                        </tr>
                    </thead>
                    <tbody>
                        <%            String data = "select * from produkt where idproduktu=" + list.get(i) + "";
                            res = stat.executeQuery(data);
                            res.next();
                            suma = suma + res.getDouble("cena");
                            session.setAttribute("sumOreder", suma);
                        %>



                        <tr >


                  <!--  <td width="200" height="30" ><%=res.getInt("idproduktu")%></td> --->
                            <td width="200" height="30"><%=res.getString("nazwa")%></td>
                            <td width="200" height="30"><%=res.getString("rodzaj")%></td>
                            <td width="200" height="30"><%=res.getDouble("cena")%></td>
                            <td><form  action="deleteCard" method="post">
                                    <td><button class="btn btn-danger"  name="cardID" value="<%session.setAttribute("delCard", list.get(i));%>" onclick="deleteUser">Delete</button></td>


                                </form></td>
                               <!--  <td width="200" height="30"><%=res.getString("nrseryjny")%></td> --->
                               <!--  <td width="200" height="30"><%=res.getString("image")%></td> --->




                        </tr>


                    </tbody>
                </table>

                <% }%>         


                <form  action="order" method="post">
                    <p style="font-weight: bold; font-size: 21px; color: #104f00 ; "> <button style="font-weight: bold; padding-left: 50px; padding-right: 50px; " class="btn btn-primary"  name="order" value="1" onclick="order">Order</button>&nbsp;  Price:&nbsp; <% out.println(suma); %>EUR</p>

                </form> 

                <% } else {
                   request.getRequestDispatcher("emptyCard.jsp").forward(request, response);
               }%>
                <% }%>

            </div>



        </div>
   

    
    <!-- attach JavaScripts -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="//maps.google.com/maps/api/js?sensor=true"></script>
    <script src="/js/main.js"></script>
</body>

</html>