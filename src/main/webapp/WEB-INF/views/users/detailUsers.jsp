<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${principal.usersId}" />

        <div class="detailUsers_wrapper">
            <h2 class="detailUsers_title">프로필</h2>
            <div class="detailUsers_container">
                <div class="detailUsers_photo">
                    <div class="content_item--photo">
                        <img src="/img/${usersPS.photo}">
                    </div>
                </div>
                <div class="detailUsers_box">
                    <div class="detailUsers_content_bold">${usersPS.nickname}</div>
                    <div class="detailUsers_content_item">
                        <div class="detailUsers_content_normal">${usersPS.username}</div>
                    </div>
                </div>
            </div>
            <h2 class="detailUsers_title">기본 정보</h2>
            <div class="detailUsers_under">
                <div class="detailUsers_content">
                    <div class="detailUsers_content_item">
                        <div class="detailUsers_content_item--menu">이름</div>
                        <div class="detailUsers_content_item--val">${usersPS.realname}</div>
                    </div>
                </div>
                <div class="detailUsers_content">
                    <div class="detailUsers_content_item">
                        <div class="detailUsers_content_item--menu">이메일</div>
                        <div class="detailUsers_content_item--val">${usersPS.email}</div>
                    </div>
                </div>
                <div class="detailUsers_content">
                    <div class="detailUsers_content_item--menu">주소</div>
                    <div class="detailUsers_content_item--val">${usersPS.address}</div>
                </div>
                <div class="detailUsers_content">
                    <div class="detailUsers_content_item">
                        <div class="detailUsers_content_item--menu">연락처</div>
                        <div class="detailUsers_content_item--val">${usersPS.phone}</div>
                    </div>
                </div>
            </div>

            <div class="detailUsers_button">
                <button class="detailUsers_button_item" id="btnUpdateUsers" type="button">회원정보수정</button>
                <button class="detailUsers_button_item" id="btnUpdatePassword" type="button">비밀번호변경</button>
                <button class="detailUsers_button_item" id="btnLeaveUsers" type="button">회원탈퇴</button>
            </div>
        </div>

        <script>
            $("#btnUpdateUsers").click(() => {
                let usersId = $("#usersId").val();
                location.href = "/users/" + usersId + "/update";
            });

            $("#btnUpdatePassword").click(() => {
                let usersId = $("#usersId").val();
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