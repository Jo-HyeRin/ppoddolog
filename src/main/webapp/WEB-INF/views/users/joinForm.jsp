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
            <link href="/css/join.css" rel="stylesheet">
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

            <div class="wrapper">
                <h2 class="title">회원가입</h2>
                <form>
                    <div class="container">
                        <div class="content">
                            <div class="content_item">
                                <div class="content_item--text">아이디</div>
                                <button class="content_item--button" id="btnUsernameSameCheck" type="button">아이디
                                    중복체크</button>
                            </div>
                            <input class="content_box" id="username" type="text" placeholder="아이디를 입력해주세요."
                                maxlength="20">
                        </div>
                        <span class="usernameValid" style="padding-left: 120px; color: red; display: none"></span>

                        <div class="content">
                            <div class="content_item">
                                <div class="content_item--text">비밀번호</div>
                            </div>
                            <input class="content_box" id="password" type="password" placeholder="비밀번호를 입력해주세요."
                                maxlength="20">
                        </div>
                        <span class="passwordValid" style="padding-left: 120px; color: red; display: none"></span>

                        <div class="content">
                            <div class="content_item">
                                <div class="content_item--text">비밀번호확인</div>
                                <div class="content_item--password" id="passwordCheck"
                                    style="visibility: hidden; color: tomato;">
                                    -----비밀번호가 같지 않습니다! </div>
                            </div>
                            <input class="content_box" id="passwordConfirm" type="password"
                                placeholder="비밀번호를 한 번 더 입력해주세요." maxlength="20">
                        </div>
                        <span class="passwordCheckValid" style="padding-left: 120px; color: red; display: none"></span>

                        <div class="content">
                            <div class="content_item">
                                <div class="content_item--text">이름</div>
                            </div>
                            <input class="content_box" id="realname" type="text" placeholder="이름을 입력해주세요."
                                maxlength="20">
                        </div>
                        <span class="realnameValid" style="padding-left: 120px; color: red; display: none"></span>

                        <div class="content">
                            <div class="content_item">
                                <div class="content_item--text">닉네임</div>
                                <button class="content_item--button" id="btnNicknameSameCheck" type="button">닉네임
                                    중복체크</button>
                            </div>
                            <input class="content_box" id="nickname" type="text" placeholder="닉네임을 입력해주세요."
                                maxlength="20">
                        </div>
                        <span class="nicknameValid" style="padding-left: 120px; color: red; display: none"></span>

                        <div class="content">
                            <div class="content_item">
                                <div class="content_item--text">이메일</div>
                                <button class="content_item--button" id="btnEmailSameCheck" type="button">이메일
                                    중복체크</button>
                            </div>
                            <input class="content_box" id="email" type="text" placeholder="이메일을 입력해주세요." maxlength="20">
                        </div>
                        <span class="emailValid" style="padding-left: 120px; color: red; display: none"></span>

                        <div class="content">
                            <div class="content_item">
                                <div class="content_item--text">주소</div>
                                <input class="content_item--button" id="postcode" type="text" placeholder="우편번호"
                                    readonly onclick="findAddress()" style="border-radius:5px;">
                                <button class="content_item--button" id="btnAddress" type="button"
                                    onclick="findAddress()">우편번호찾기</button>
                            </div>
                            <input class="content_box" id="addr" type="text" placeholder="주소" readonly>
                            <input class="content_box" id="detailAddress" type="text" placeholder="상세주소">
                        </div>

                        <div class="content">
                            <div class="content_item">
                                <div class="content_item--text">연락처</div>
                                <button class="content_item--button" id="btnPhoneSameCheck" type="button">연락처
                                    중복체크</button>
                            </div>
                            <input class="content_box" id="phone" type="text" placeholder="연락처를 입력해주세요." maxlength="20">
                        </div>

                        <div class="content">
                            <div class="content_item">
                                <div class="content_item--text">사진</div>
                            </div>
                            <div class="form-group">
                                <input type="file" id="file" accept="image/*" onchange="setThumbnail(event)">
                            </div>
                            <div class="content_item--photo" id="imageContainer"></div>
                        </div>

                    </div>
                </form>
                <div>
                    <button class="button_item" id="btnJoin" type="button">회원가입</button>
                </div>
            </div>

            <script src="/js/joinUsers.js"></script>
            <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

            <%@ include file="../layout/footer.jsp" %>