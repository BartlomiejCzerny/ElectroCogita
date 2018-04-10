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
        <title>Order history</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <!-- attach CSS styles -->
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" />
    </head>

    <body style="background-image: linear-gradient(to right bottom, #bbf049, #c8f36d)">
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
        <!-- first section - Home -->

        <%

            Statement stat2 = null;

            ResultSet res2 = null;

            conn = PolaczenieDB.getConnection();
            stat = conn.createStatement();
            stat2 = conn.createStatement();
        %>

        <link href="css/style.css" rel="stylesheet">
        <style><%@include file="css/style.css"%></style>

        <div class="container" id="BodyProduct" >    


            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Order number</th>
                        <th>The sum of the order</th>



                    </tr>
                </thead>
                <tbody>
                    <%
                        String data = "select imie, IdZamowieniaP, suma from klient k join ZamowienieKlient zk on k.IdKlienta=zk.IdKlienta join ZamowienieProdukt zp on zp.IdZamP=zk.IdZamP join produkt p on p.IdProduktu=zp.IdProduktu where k.email='" + session.getAttribute("getEmail") + "'";
                        res = stat.executeQuery(data);

                        while (res.next()) {
                    %>
                    <tr >
                        <td style="font-weight: bold;">Email:&nbsp;<%=res.getString("imie")%></td>
                        <td style="font-weight: bold;">Order number:&nbsp;<%=res.getInt("IdZamowieniaP")%></td>
                        <td style="font-weight: bold;">The sum of the order:&nbsp;<%=res.getDouble("suma")%></td>
                        <td>

                            <%
                                String data2 = "select nazwa, rodzaj, cena, nrseryjny from produkt p join ZamowienieProdukt zp on p.IdProduktu=zp.IdProduktu where zp.IdZamowieniaP = " + res.getInt("IdZamowieniaP") + "";
                                res2 = stat2.executeQuery(data2);

                                while (res2.next()) {
                            %>

                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Game</th>
                                        <th>Type</th>
                                        <th>Price</th>
                                        <th>Serial number</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr >
                                        <td width="200" height="30"><%=res2.getString("nazwa")%></td>
                                        <td width="100" height="30"><%=res2.getString("rodzaj")%></td>
                                        <td width="100" height="30"><%=res2.getDouble("cena")%></td>
                                        <td width="200" height="30" style="font-weight: bold; color: orange;"><%=res2.getString("nrseryjny")%></td>
                                    </tr>

                                </tbody>
                            </table>




                            <%}%>
                        </td>
                    </tr>

                    <%}%>


                </tbody>
            </table>


        </div>



        <p></p>
        <!-- footer -->
        <footer>
            <hr />
            <div class="container">
                <p>Copyright &copy; ElectroCogita 2018</p>
            </div>
        </footer>
        <!-- /footer -->
        <p></p>
        <!-- attach JavaScripts -->
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="//maps.google.com/maps/api/js?sensor=true"></script>
        <script src="/js/main.js"></script>
    </body>

</html>