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
                    <div class="mb-3">
                        ◆주소 : <input id="content" type="text" value="${usersPS.address}" class="form-control"
                            placeholder=${usersPS.address} readonly>
                    </div>
                    <br />
                    <div id="phone">${usersPS.phone}</div>
                    <br />
                    <div id="photo">${usersPS.photo}</div>
                    <br />
                </div>
            </form>

            <div class="mb-5"></div>

            <div class="d-grid gap-1 col-2 mx-auto">
                <button id="btnUpdateUsers" type="submit" class="btn btn-primary">회원수정하기</button>
            </div>
            <br />
            <div class="d-grid gap-1 col-2 mx-auto">
                <button id="btnUpdatePassword" type="submit" class="btn btn-primary">비밀번호변경</button>
            </div>
            <br />
            <div class="d-grid gap-1 col-2 mx-auto">
                <button id="btnLeaveUsers" type="button" class="btn btn-primary">회원탈퇴하기</button>
            </div>

        </div>

        <script>
            $("#btnUpdateUsers").click(() => {
                let usersId = $("#usersId").val();
                alert("회원수정 페이지로 이동합니다");
                location.href = "/users/" + usersId + "/update";
            });

            $("#btnUpdatePassword").click(() => {
                let usersId = $("#usersId").val();
                alert("비밀번호변경 페이지로 이동합니다");
                location.href = "/users/" + usersId + "/updatePassword";
            });

            $("#btnLeaveUsers").click(() => {
                leaveUsers();
            });

            function leaveUsers() {
                let usersId = $("#usersId").val();
                let data = "inactive";

                $.ajax("/users/" + usersId + "/leave", {
                    type: "PUT",
                    dataType: "json",
                    data: JSON.stringify(data),
                    headers: {
                        "Content-Type": "application/json; charset=utf-8",
                    },
                    error: function (data, status, error) {
                        alert(data.responseText);
                    },
                }).done((res) => {
                    if (res.code == 1) {
                        alert(res.msg);
                        location.href = "/";
                    } else {
                        alert(res.msg);
                    }
                });
            }

        </script>

        <%@ include file="../layout/footer.jsp" %>