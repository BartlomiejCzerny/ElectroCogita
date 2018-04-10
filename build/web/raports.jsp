<%@page import="java.io.PrintWriter"%>
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
        <title>Raports</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <!-- attach CSS styles -->
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" />
    </head>

    <body style="background-image: linear-gradient(to right bottom, #ffae19, #ffc04c)">
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
            <!-- Raport 1--->
            <div class="col-md-2">
                <h3>Client Order</h3>
                <form name="sentMessage" method="post" action="raports.jsp" id="contactForm" novalidate>

                    <div class="control-group form-group">
                        <div class="controls">
                            <label>Value - email </label>
                            <input type="text" placeholder="Enter email" name="raport1" class="form-control" id="name" required data-validation-required-message="Please enter your name.">

                            <p class="help-block"></p>
                        </div>
                    </div>


                    <div id="success"></div>
                    <!-- For success/fail messages -->
                    <button type="submit" name="btn1" value="true" class="btn btn-primary">Generate</button>
                </form>               
            </div>
            <!-- Raport 2--->

<!--            <div class="col-md-2">
                <h3>Order value</h3>
                <form name="sentMessage" method="post" action="raports.jsp" id="contactForm" novalidate>

                    <div class="control-group form-group">
                        <div class="controls">
                            <label>Order value >= value </label>
                            <input type="text" placeholder="Enter value" name="raport2" class="form-control" id="name" required data-validation-required-message="Please enter your name.">

                            <p class="help-block"></p>
                        </div>
                    </div>


                    <div id="success"></div>
                     For success/fail messages 
                    <button type="submit" name="btn2" value="true" class="btn btn-primary">Generate</button>
                </form>    
            </div>-->

            <!-- Raport 3--->

            <div class="col-md-2">
                <h3>Product price</h3>
                <form name="sentMessage" method="post" action="raports.jsp" id="contactForm" novalidate>

                    <div class="control-group form-group">
                        <div class="controls">
                            <label>Product price >= value </label>
                            <input type="text" placeholder="Enter price" name="raport3" class="form-control" id="name" required data-validation-required-message="Please enter your name.">

                            <p class="help-block"></p>
                        </div>
                    </div>


                    <div id="success"></div>
                    <!-- For success/fail messages -->
                    <button type="submit" name="btn3" value="true" class="btn btn-primary">Generate</button>
                </form>    
            </div>
            <!-- Raport 4--->

            <div class="col-md-2">
                <h3>Order count</h3>
                <form name="sentMessage" method="post" action="raports.jsp" id="contactForm" novalidate>

                    <div class="control-group form-group">
                        <div class="controls">
                            <label>Without value show all</label>
                            <input type="text" placeholder="Enter email" name="raport4" class="form-control" id="name" required data-validation-required-message="Please enter your name.">

                            <p class="help-block"></p>
                        </div>
                    </div>


                    <div id="success"></div>
                    <!-- For success/fail messages -->
                    <button type="submit" name="btn4" value="true" class="btn btn-primary">Generate</button>
                </form>    
            </div>







            <div class="container">    

                <%if (Boolean.valueOf(request.getParameter("btn1")) && !request.getParameter("raport1").isEmpty()) {%>
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
                            String data = "select imie, IdZamowieniaP, suma from klient k join ZamowienieKlient zk on k.IdKlienta=zk.IdKlienta join ZamowienieProdukt zp on zp.IdZamP=zk.IdZamP join produkt p on p.IdProduktu=zp.IdProduktu where k.email='" + request.getParameter("raport1") + "'";
                            res = stat.executeQuery(data);

                            while (res.next()) {
                        %>
                        <tr >
                            <td style="font-weight: bold;">Email:&nbsp;<%=res.getString("imie")%></td>
                            <td style="font-weight: bold;">Order number:&nbsp;<%=res.getInt("IdZamowieniaP")%></td>
                            <td style="font-weight: bold;">The sum of the order:&nbsp;<%=res.getDouble("suma")%></td>
                            <td>

                                <%
                                    String data2 = "select nazwa, Rodzaj, cena, nrseryjny from produkt p join ZamowienieProdukt zp on p.IdProduktu=zp.IdProduktu where zp.IdZamowieniaP = " + res.getInt("IdZamowieniaP") + "";
                                    res2 = stat2.executeQuery(data2);

                                    while (res2.next()) {
                                %>

                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Product</th>
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
                <%}%>



                <%if (Boolean.valueOf(request.getParameter("btn2")) && !request.getParameter("raport2").isEmpty()) {%>
                <table class="table table-striped">
                    <thead>
                        <tr>

                            <th>Name</th>
                            <th>Surmame</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>id_order</th>
                            <th>Price</th>



                        </tr>
                    </thead>
                    <%

                        String data = "select imie, nazwisko,telefon, email, IdZamowieniaK, suma from zamk zk join klient k on k.IdKlienta=zk.IdKlienta where suma >= " + request.getParameter("raport2") + " order by k.imie";
                        res = stat.executeQuery(data);

                        while (res.next()) {
                    %>
                    <tbody>

                        <tr >

                            <td style="font-weight: bold;"><%=res.getString("imie")%></td>
                            <td style="font-weight: bold;"><%=res.getString("nazwisko")%></td>
                            <td style="font-weight: bold;"><%=res.getString("telefon")%></td>
                            <td style="font-weight: bold;"><%=res.getString("email")%></td>
                            <td style="font-weight: bold;"><%=res.getInt("IdZamowieniaK")%></td>
                            <td style="font-weight: bold;"><%=res.getDouble("suma")%></td>




                            </td>
                        </tr>




                    </tbody>
                    <%}%>    
                </table>

                <%} else {
                  }%>

                <%if (Boolean.valueOf(request.getParameter("btn3")) && !request.getParameter("raport3").isEmpty()) {%>
                <table class="table table-striped">
                    <thead>
                        <tr>

                            <th>Product</th>
                            <th>Price</th>




                        </tr>
                    </thead>
                    <%
                        String data = "select nazwa, cena from produkt where cena >= " + request.getParameter("raport3") + " order by nazwa";
                        res = stat.executeQuery(data);

                        while (res.next()) {
                    %>
                    <tbody>

                        <tr >

                            <td style="font-weight: bold;"><%=res.getString("nazwa")%></td>
                            <td style="font-weight: bold;"><%=res.getDouble("cena")%></td>




                            </td>
                        </tr>




                    </tbody>
                    <%}%>
                </table>

                <%}%>

                <%if (Boolean.valueOf(request.getParameter("btn4"))) {%>
                <table class="table table-striped">
                    <thead>
                        <tr>

                            <th>Name</th>
                            <th>Surname</th>
                            <th>Sum of orders</th>



                        </tr>
                    </thead>
                    <%
                        if (!request.getParameter("raport4").isEmpty()) {
                            String data = "select imie, nazwisko, count(IdZamowieniaK) as sumOrder from klient k join ZamowienieKlient zk on k.IdKlienta=zk.IdKlienta where k.email = '" + request.getParameter("raport4") + "' group by (k.imie, k.nazwisko)";
                            res = stat.executeQuery(data);
                        } else {
                            String data = "select imie, nazwisko, count(IdZamowieniaK) as sumOrder from klient k join ZamowienieKlient zk on k.IdKlienta=zk.IdKlienta where zk.IdZamowieniaK >0 group by (k.imie, k.nazwisko)";
                            res = stat.executeQuery(data);

                        }
                        while (res.next()) {


                    %>
                    <tbody>

                        <tr >

                            <td style="font-weight: bold;"><%=res.getString("imie")%></td>
                            <td style="font-weight: bold;"><%=res.getString("nazwisko")%></td>
                            <td style="font-weight: bold;"><%=res.getInt("sumOrder")%></td>





                            </td>
                        </tr>




                    </tbody>
                    <%}%>    
                </table>

                <%}%>




            </div>
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
