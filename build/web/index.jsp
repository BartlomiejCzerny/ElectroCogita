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
    <title>ElectroCogita</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <!-- attach CSS styles -->
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet" />
</head>

<body>
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
    <div id="home" class="home">
        <div class="text-vcenter">
            <h1>Great products</h1>
            <h3>Just a dream</h3>
            <a href="#about" class="btn btn-default btn-lg">Continue</a>
        </div>
    </div>
    <!-- /first section -->
    <p></p>
    <!-- second section - About -->
    <div id="about" class="pad-section">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <img src="https://images.morele.net/i500/1456883_0_i500.jpg" alt="Lenovo V310-15IKB" />
                </div>
                <div class="col-sm-6 text-center">
                    <h2>Lenovo V310-15IKB</h2>
                    <p class="lead">Simply perfect laptop.</p>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <img src="http://xahoithongtin.com.vn/dataimages/201704/original/images1925408_iPhone_7.png" alt="iPhone 7" />
                </div>
                <div class="col-sm-6 text-center">
                    <h2>iPhone 7</h2>
                    <p class="lead">Best smartphone for everyone.</p>
                </div>
            </div>
        </div>
         <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <img src="http://shop.d-nexus.com/images/Canon_MX897_01.jpg" alt="Canon MX897" />
                </div>
                <div class="col-sm-6 text-center">
                    <h2>Canon MX897</h2>
                    <p class="lead">Awesome all in one device.</p>
                </div>
            </div>
        </div>
    </div>
    <!-- /second section -->
    <p></p>
    <!-- third section - Services -->
    <!-- /third section -->
    <p></p>
    <!-- fourth section - Information -->

    <p></p>
    <!-- footer -->
    <footer>
        <hr />
        <div class="container">
            <p class="text-right">Copyright &copy; ElectroCogita 2018</p>
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