<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${usersPS.usersId}" />

        <div class="container">
            <h2>회원 정보 보기</h2>
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

            <br />
            <div class="d-grid gap-1 col-2 mx-auto">
                <button id="btnDeleteUsers" type="button" class="btn btn-primary">회원영구삭제</button>
            </div>

        </div>

        <script>
            $("#btnDeleteUsers").click(() => {
                DeleteUsers();
            });

            function DeleteUsers() {
                let usersId = $("#usersId").val();

                $.ajax("/admin/deleteUsers/" + usersId, {
                    type: "DELETE",
                    dataType: "json",
                }).done((res) => {
                    if (res.code == 1) {
                        alert("회원영구삭제 성공");
                        location.href = "/";
                    } else {
                        alert(res.message);
                    }
                });
            }

        </script>

        <%@ include file="../layout/footer.jsp" %>