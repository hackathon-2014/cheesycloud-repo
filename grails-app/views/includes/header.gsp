<%--
  Created by IntelliJ IDEA.
  User: mattgarkusha
  Date: 8/23/14
  Time: 10:51 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Food Run</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="<g:resource dir="css" file="style.css" />">
    <link rel="stylesheet" href="<g:resource dir="css" file="mainStyles.css" />">

    <script src="<g:resource dir="js" file="jquery-2.1.1.min.js" />"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</head>

<body>
<div class="navbar navbar-default">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-inverse-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#"><img src="<g:resource dir="images" file="foodRunLogo.png"/>"  class="logo"></a>
    </div>
    <div class="navbar-collapse collapse navbar-inverse-collapse">
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">User <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="#">Settings</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Logout</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>