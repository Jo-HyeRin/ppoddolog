<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>PPODDOLOG</title>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" rel="stylesheet">
            <link href="/css/style.css" rel="stylesheet">
            <link href="/css/header-other.css" rel="stylesheet">
            <link href="/css/footer.css" rel="stylesheet">
            <link href="/css/navigation.css" rel="stylesheet">
            <link href="/css/detailUsers.css" rel="stylesheet">
            <link href="/css/updateUsers.css" rel="stylesheet">
        </head>

        <body>
            <div class="container">
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
                            <button class="header_profile" onclick='location.href="/main"'></button>
                            <div class="header_user">${principal.username}님 환영합니다:)</div>
                        </div>
                    </div>
                </header>
                <!-- header end -->

                <!-- navigation start -->
                <nav class="nav">
                    <ul class="nav_wrapper">
                        <c:choose>
                            <c:when test="${empty principal}">
                                <li class="nav-link">
                                    <button class="nav_icon">&#9829;</button>
                                    <button class="nav_menu" onclick='location.href="/loginForm"'>로그인/회원가입</button>
                                </li>
                            </c:when>
                            <c:when test="${principal.role == 'admin'}">
                                <li class="nav-link">
                                    <button class="nav_icon">&#9829;</button>
                                    <button class="nav_menu"
                                        onclick='location.href="/admin/${principal.usersId}/activeUsersList"'>활동회원목록</button>
                                </li>
                                <li class="nav-link">
                                    <button class="nav_icon">&#9829;</button>
                                    <button class="nav_menu"
                                        onclick='location.href="/admin/${principal.usersId}/stopUsersList"'>정지회원목록</button>
                                </li>
                                <li class="nav-link">
                                    <button class="nav_icon">&#9829;</button>
                                    <button class="nav_menu"
                                        onclick='location.href="/admin/${principal.usersId}/leaveUsersList"'>탈퇴회원목록</button>
                                </li>
                                <li class="nav-link">
                                    <a href="/logout" onclick="disconnect()" style="color: #ffffff;">로그아웃</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-link">
                                    <button class="nav_icon">&#9829;</button>
                                    <button class="nav_menu"
                                        onclick='location.href="/board/users/${principal.usersId}/list"'>게시글목록</button>
                                </li>
                                <li class="nav-link">
                                    <button class="nav_icon">&#9829;</button>
                                    <button class="nav_menu"
                                        onclick='location.href="/users/${principal.usersId}/detail"'>내정보보기</button>
                                </li>
                                <li class="nav-link">
                                    <button class="nav_icon">&#9829;</button>
                                    <button class="nav_menu" onclick='location.href="/logout"'>로그아웃</button>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </nav>
                <!-- navigation end -->

                <script>
                    function disconnect() {
                        aalert(res.msg);
                    }
                </script>