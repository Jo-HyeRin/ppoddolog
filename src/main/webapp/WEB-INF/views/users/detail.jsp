<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${principal.usersId}" />

        <div class="container">
            <h2>나의 정보 보기</h2>
            <form>
                <div class="left_input">
                    <br />
                    <div id="username">${usersPS.username}</div>
                    <br />
                    <div id="realname">${usersPS.realname}</div>
                    <br />
                    <div id="nickname">${usersPS.nickname}</div>
                    <br />
                    <div id="email">${usersPS.email}</div>
                    <br />
                    <div id="address">${usersPS.address}</div>
                    <br />
                    <div id="phone">${usersPS.phone}</div>
                    <br />
                    <div id="photo">${usersPS.photo}</div>
                    <br />
                </div>
            </form>

            <div class="mb-5"></div>

            <div class="d-grid gap-1 col-2 mx-auto">
                <button id="btnUpdate" type="submit" class="btn btn-primary">회원수정하기</button>
            </div>

        </div>

        <script>
            $("#btnUpdate").click(() => {
                let usersId = $("#usersId").val();
                alert("회원수정페이지로 이동합니다");
                location.href = "/users/" + usersId + "/update";
            });
        </script>

        <%@ include file="../layout/footer.jsp" %>