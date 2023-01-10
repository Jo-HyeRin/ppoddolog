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
            <link href="/css/footer.css" rel="stylesheet">
            <link href="/css/login.css" rel="stylesheet">
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

            <div class="login_wrapper">
                <h2 class="login_title">로그인</h2>
                <form>
                    <div class="login_container">
                        <div class="login_content">
                            <div class="login_content--text">아이디</div>
                            <input class="login_content--box" id="username" type="text" placeholder="아이디를 입력해주세요."
                                maxlength="20">
                        </div>
                        <div class="login_content">
                            <div class="login_content--text">비밀번호</div>
                            <input class="login_content--box" id="password" type="password" placeholder="비밀번호를 입력해주세요."
                                maxlength="20">
                        </div>
                        <div class="login_content--label">
                            <label class="form-check-label">
                                <input id="remember" class="form-check-input" type="checkbox"> 로그인상태유지
                            </label>
                        </div>
                    </div>

                    <div class="login_button">
                        <button id="btnLogin" type="button" class="login_button--item">로그인</button>
                        <button id="btnJoin" type="button" class="login_button--item">회원가입</button>
                    </div>
                </form>
            </div>

            <script>
                $("#btnLogin").click(() => {
                    let loginData = {
                        username: $("#username").val(),
                        password: $("#password").val(),
                        remember: $("#remember").prop("checked")
                    };
                    login(loginData);
                });

                function login(loginData) {
                    $.ajax("/login", {
                        type: "POST",
                        dataType: "json",
                        data: JSON.stringify(loginData),
                        headers: {
                            "Content-Type": "application/json; charset=utf-8",
                        },
                        error: function (data, status, error) {
                            alert(data.responseText);
                        },
                    }).done((res) => {
                        if (res.code == 1) {
                            let usersId = res.data;
                            location.href = "/board/users/" + usersId + "/list";
                        } else {
                            alert(res.msg);
                            return false;
                        }
                    });
                }

                $("#btnJoin").click(() => {
                    location.href = "/joinForm";
                });

            </script>

            <%@ include file="../layout/footer.jsp" %>