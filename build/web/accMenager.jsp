<%@page import="system.edycji.EditUserServlet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.PolaczenieDB"%>
<%@page  language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="system.rejestracji.*"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="author" content="Script Tutorials" />
        <title>Account Manager</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <!-- attach CSS styles -->
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" />
    </head>

    <body style="background-image: linear-gradient(to right bottom, #b6d5ed, #c4ddf0)">
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
        <div class="container" id="RegBody">
            <%
                boolean tableShow = false;
                boolean searchShow = false;
                boolean showAll = false;

                String s;
                String s2;
                String s3;

                conn = PolaczenieDB.getConnection();
                stat = conn.createStatement();

                s = String.valueOf(request.getAttribute("tableShow"));
                tableShow = Boolean.parseBoolean(s);

                s2 = String.valueOf(request.getAttribute("searchShow"));
                searchShow = Boolean.parseBoolean(s2);

                s3 = String.valueOf(request.getAttribute("showAll"));
                showAll = Boolean.parseBoolean(s3);

            %>

            <link href="css/style.css" rel="stylesheet">
            <style><%@include file="css/style.css"%></style>
            <div class="container" id="accMenager">
                <div class="col-lg-5">

                    <form  action="editUser" method="post">
                        <tr>
                        <table class="table table-striped">

                            <td><input type="text" name="id_email" class="form-control" id="surname" value=""></td>
                            <td><button class="btn btn-info"  name="search" value="1" onclick="search" >Search</button></td>
                            <td><button class="btn btn-primary"  name="showAll" value="1" onclick="showAll" >ShowAll</button></td>
                            <tr>

                            </tr>
                        </table>

                </div>
                <%if (tableShow) {%>
                <table class="table table-striped">
                    <thead>
                        <tr>

                            <th>Name</th>
                            <th>Surname</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>Rank</th>


                        </tr>
                    </thead>
                    <tbody>

                        <tr>
                    <form  action="editUser" method="post">

                        <td><%=session.getAttribute("showImie")%><%if (searchShow) {%><input type="text" name="imieE" class="form-control" id="surname" value="<%=session.getAttribute("showImie")%>"><%}%></td>
                        <td><%=session.getAttribute("showNazwisko")%><%if (searchShow) {%><input type="text" name="nazwiskoE" class="form-control" id="surname" value="<%=session.getAttribute("showNazwisko")%>"><%}%></td>
                        <td><%=session.getAttribute("showTelefon")%><%if (searchShow) {%><input type="text" name="telefonE" class="form-control" id="surname" value="<%=session.getAttribute("showTelefon")%>"><%}%></td>
                        <td><%=session.getAttribute("showEmail")%><%if (searchShow) {%><input type="text" name="emailE" class="form-control" id="surname" value="<%=session.getAttribute("showEmail")%>"><%}%></td>
                        <td><%=session.getAttribute("showHaslo")%><%if (searchShow) {%><input type="text" name="hasloE" class="form-control" id="surname" value="<%=session.getAttribute("showHaslo")%>"><%}%></td>
                        <td><%=session.getAttribute("showRanga")%><%if (searchShow) {%><select class="form-control" name="rangaE"><option value="Admin">Admin</option><option value="Pracownik">Pracownik</option><option value="User" selected>User</option></select><%}%></td>                
                        <%if (searchShow) {%>
                        <td><button class="btn btn-success" name="btnYes" value="1" onclick="editUser" >Yes</button></td>

                        <td><button class="btn btn-info" name="btnNo" value="1" onclick="editUser">No</button></td>
                        <%}%>
                        <%if (!searchShow) {%>
                        <td><button class="btn btn-warning"  name="btnEdit" value="1" onclick="editUser" >Edit</button></td>
                        <%}%>

                    </form>
                    <%if (searchShow) {%>
                    <form  action="deleteUser" method="post">
                        <td><button class="btn btn-danger"  name="id_klient_value" value="<%=session.getAttribute("showEmail")%>" onclick="deleteUser">Delete</button></td>

                    </form>
                    <%}%>


                    </form>



                    </tbody>
                </table>
                <%}%>

                <%if (showAll) {%>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Name</th>
                            <th>Surname</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>Rank</th>


                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String data = "select * from klient";
                            res = stat.executeQuery(data);

                            while (res.next()) {
                        %>


                        <tr >
                    <form  action="deleteUserMore" method="post">

                        <td><%=res.getInt("idklienta")%></td>
                        <td><%=res.getString("imie")%></td>
                        <td><%=res.getString("nazwisko")%></td>
                        <td><%=res.getString("telefon")%></td>
                        <td><%=res.getString("email")%></td>
                        <td><%=res.getString("haslo")%></td>
                        <th><%=res.getString("ranga")%></th>


                    </form>

                    </tr>
                    <%
                        }
                    %>

                    </tbody>
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