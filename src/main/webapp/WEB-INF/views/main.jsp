<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>PPODDOLOG</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" rel="stylesheet">
            <link href="/css/reset.css" rel="stylesheet">
            <link href="/css/header-main.css" rel="stylesheet">
            <link href="/css/main.css" rel="stylesheet">
        </head>

        <body>
            <!-- header start -->
            <header class="header">
                <div class="header_wrapper">
                    <h1 class="header_start">
                        <button class="header_heart">&#9829;</button>
                        <span class="header_title">
                            <button class="header_title--button" onclick='location.href="/main"'>PPODDOLOG</button>
                        </span>
                    </h1>
                    <div class="header_end">
                        <button class="header_end--button" onclick='location.href="/loginForm"'>로그인/회원가입</button>
                    </div>
                </div>
            </header>
            <!-- header end -->

            <!-- main container start -->
            <div class="main">
                <div class="main_wrapper">
                    <div class="main_item">
                        <h1 class="main_title">PPODDOLOG</h1>
                        <div class="main-content">
                            <div class="main_img">
                                <img src="img/ddoddo.jpg">
                            </div>
                            <div class="main_text">
                                안녕하세요<br /><br />
                                또또의 블로그 입니다 <br /><br />
                                이곳은<br /><br />
                                로그인 유저만 이용할 수 있습니다.<br /><br />
                                회원가입 후 로그인 해주세요 :)<br /><br />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%@ include file="layout/footer.jsp" %>