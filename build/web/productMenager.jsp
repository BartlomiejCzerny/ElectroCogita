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
        <title>Product Manager</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <!-- attach CSS styles -->
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" />
    </head>

    <body style="background-image: linear-gradient(to right bottom, #32ff32, #7fff7f)">
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
            <div class="col-md-12" id="accMenager">


                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Price</th>
                            <th>Serial number</th>
                            <th>Image</th>


                        </tr>
                    </thead>
                    <tbody>
                    <form name="" method="post" action="product" >

                        <tr>

                            <td><input class="form-control" type="text"  name="nazwa"  ><span style="color:red"><%=(request.getAttribute("errorNazwa") == null) ? "" : request.getAttribute("errorNazwa")%></span></td>

                            <td><input class="form-control" type="text" name="rodzaj" ><span style="color:red"><%=(request.getAttribute("errorRodzaj") == null) ? "" : request.getAttribute("errorRodzaj")%></span></td>

                            <td><input class="form-control" type="number" name="cena" ><span style="color:red"><%=(request.getAttribute("errorCena") == null) ? "" : request.getAttribute("errorCena")%></span></td>

                            <td><input class="form-control" type="text" name="nrseryjny" ><span style="color:red"><%=(request.getAttribute("errorNrSeryjny") == null) ? "" : request.getAttribute("errorNrSeryjny")%></span></td>

                            <td><input class="form-control" type="text" name="image" ><span style="color:red"><%=(request.getAttribute("errorImage") == null) ? "" : request.getAttribute("errorImage")%></span></td>

                            <td><button class="btn btn-success" value="">Add Product</button>
                                <span style="color:greenyellow"><%=(request.getAttribute("addSucces") == null) ? "" : request.getAttribute("addSucces")%></span>
                                <span style="color:red"><%=(request.getAttribute("addFail") == null) ? "" : request.getAttribute("addFail")%></span>
                            </td>

                            <td></td>
                        </tr>
                    </form>

                    </tbody>
                </table>
            </div>
        </div>

        <!-- Page Content -->
        <div class="container" id="RegBody">

            <hr>


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

                    <form  action="editProduct" method="post">
                        <tr>
                        <table class="table table-striped">

                            <td><input type="text" name="id_nrSeryjny" class="form-control" id="surname" value=""></td>
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

                            <th>Nazwa</th>
                            <th>Rodzaj</th>
                            <th>Cena</th>
                            <th>NrSeryjny</th>
                            <th>Image</th>

                        </tr>
                    </thead>
                    <tbody>

                        <tr>
                    <form  action="editProduct" method="post">

                        <td><%=session.getAttribute("showNazwa")%><%if (searchShow) {%><input type="text" name="nazwaE" class="form-control" id="surname" value="<%=session.getAttribute("showNazwa")%>"><%}%></td>
                        <td><%=session.getAttribute("showRodzaj")%><%if (searchShow) {%><input type="text" name="rodzajE" class="form-control" id="surname" value="<%=session.getAttribute("showRodzaj")%>"><%}%></td>
                        <td><%=session.getAttribute("showCena")%><%if (searchShow) {%><input type="text" name="cenaE" class="form-control" id="surname" value="<%=session.getAttribute("showCena")%>"><%}%></td>
                        <td><%=session.getAttribute("showNrSeyjny")%><%if (searchShow) {%><input type="text" name="nrseryjnyE" class="form-control" id="surname" value="<%=session.getAttribute("showNrSeyjny")%>"><%}%></td>
                        <td><%=session.getAttribute("showImage")%><%if (searchShow) {%><input type="text" name="imageE" class="form-control" id="surname" value="<%=session.getAttribute("showImage")%>"><%}%></td>
                            <%if (searchShow) {%>
                        <td><button class="btn btn-success" name="btnYes" value="1" onclick="editProduct" >Yes</button></td>

                        <td><button class="btn btn-info" name="btnNo" value="1" onclick="editProduct">No</button></td>
                        <%}%>
                        <%if (!searchShow) {%>
                        <td><button class="btn btn-warning"  name="btnEdit" value="1" onclick="editProduct" >Edit</button></td>
                        <%}%>

                    </form>
                    <%if (searchShow) {%>
                    <form  action="deleteProduct" method="post">
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
                            <th>Type</th>
                            <th>Price</th>
                            <th>Serial number</th>
                            <th>Image</th>


                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String data = "select * from produkt";
                            res = stat.executeQuery(data);

                            while (res.next()) {
                        %>


                        <tr>
                    <form  action="deleteUserMore" method="post">

                        <td><%=res.getInt("idProduktu")%></td>
                        <td><%=res.getString("nazwa")%></td>
                        <td><%=res.getString("rodzaj")%></td>
                        <td><%=res.getDouble("cena")%></td>
                        <td><%=res.getString("nrseryjny")%></td>
                        <td><%=res.getString("image")%></td>
                        <form  action="deleteUserMore" name="delP" method="post">
                            <td><button class="btn btn-danger"  name="id_product_del"  value="<%=res.getInt("idProduktu")%>" onclick="deleteUser">Delete</button></td>

                        </form>

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