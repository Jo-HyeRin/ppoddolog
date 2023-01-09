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
        </head>

        <body>
            <div class="container">
                <header>
                    <nav class="navbar navbar-expand-sm bg-warning navbar-dark">
                        <a href="/main">PPODDOLOG(로고)</a>
                        <ul class="navbar-nav" style="width: 100%">
                            <c:choose>
                                <c:when test="${empty principal}">
                                    <li class="nav-link">
                                        <a href="/loginForm" style="color: #ffffff;">로그인/회원가입</a>
                                    </li>
                                </c:when>
                                <c:when test="${principal.role == 'admin'}">
                                    <li class="nav-link">
                                        <a href="/admin/${principal.usersId}/activeUsersList"
                                            style="color: #ffffff;">활동회원목록</a>
                                    </li>
                                    <li class="nav-link">
                                        <a href="/admin/${principal.usersId}/stopUsersList"
                                            style="color: #ffffff;">정지회원목록</a>
                                    </li>
                                    <li class="nav-link">
                                        <a href="/admin/${principal.usersId}/leaveUsersList"
                                            style="color: #ffffff;">탈퇴회원목록</a>
                                    </li>
                                    <li class="nav-link">
                                        <a href="/logout" onclick="disconnect()" style="color: #ffffff;">로그아웃</a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-link">
                                        <a href="/board/users/${principal.usersId}/list"
                                            style="color: #ffffff;">게시글목록</a>
                                    </li>
                                    <li class="nav-link">
                                        <a href="/users/${principal.usersId}/detail" style="color: #ffffff;">내정보보기</a>
                                    </li>
                                    <li class="nav-link">
                                        <a href="/logout" onclick="disconnect()" style="color: #ffffff;">로그아웃</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </nav>
                </header>

                <script>
                    function disconnect() {
                        aalert(res.msg);
                    }
                </script>