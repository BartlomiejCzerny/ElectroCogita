<%@page import="src.PolaczenieDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="author" content="Script Tutorials" />
        <title>Products</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <!-- attach CSS styles -->
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" />
    </head>

    <body style="background-image: linear-gradient(to right bottom, #3d3bff, #7e7cff)">
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


        <!--main-->
        <div class="container" id="BodyProduct">
            <div class="row">

                <%
                    conn = PolaczenieDB.getConnection();
                    stat = conn.createStatement();


                %>
                <%          String data = "select * from produkt";
                    res = stat.executeQuery(data);

                    while (res.next()) {
                %>


                <div class="col-sm-4">
                    <div class="panel panel-default">
                        <div class="panel-thumbnail"><img src="<%=res.getString("image")%>" class="img-responsive"></div>
                        <div class="panel-body" style="text-align: center;">
                            <p class="lead" ><%=res.getString("nazwa")%> (<%=res.getString("rodzaj")%>)</p>

                            <p>

                            <form  action="shoppingcart" name="formBuy" method="post">
                                <button style="font-weight: bold" class="btn btn-info" id="" name="btnBuy" value="<%=res.getInt("idproduktu")%>">Buy<b> &nbsp; <%=res.getDouble("cena")%>&nbsp;EUR</b></button>
                            </form>

                            </p>
                        </div>
                    </div>
                </div><!--/col-->
            
        <%

            }
        %>



        <p></p>
        <!-- footer -->
        <br>
    
    <div class="clearfix"></div>
        <footer>
            <hr />
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; ElectroCogita 2018</p>
                </div>
            </div>
        </footer>
    </div>
    </div>
        <!-- /footer -->
        <p></p>
        <!-- attach JavaScripts -->
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="//maps.google.com/maps/api/js?sensor=true"></script>
        <script src="/js/main.js"></script>
    </body>

</html>
