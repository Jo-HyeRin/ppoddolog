<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="adminId" type="hidden" value="${principal.usersId}" />
        <input id="usersId" type="hidden" value="${usersPS.usersId}" />

        <div class="container">
            <h2>회원 정보</h2>
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

            <c:choose>
                <c:when test="${usersPS.state eq 'active'}">
                    <div class="d-grid gap-1 col-2 mx-auto">
                        <button id="btnStopUsers" type="button" class="btn btn-primary">회원정지</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="d-grid gap-1 col-2 mx-auto">
                        <button id="btnActiveUsers" type="button" class="btn btn-primary">회원정지해제</button>
                    </div>
                    <br />
                    <div class="d-grid gap-1 col-2 mx-auto">
                        <button id="btnDeleteUsers" type="button" class="btn btn-primary">회원영구삭제</button>
                    </div>
                </c:otherwise>
            </c:choose>

            <br />


        </div>

        <script>
            $("#btnStopUsers").click(() => {
                stopUsers();
            });

            function stopUsers() {
                let adminId = $("#adminId").val();
                let usersId = $("#usersId").val();
                let data = "stop";

                $.ajax("/admin/" + adminId + "/stopUsers/" + usersId, {
                    type: "PUT",
                    dataType: "json",
                    data: JSON.stringify(data),
                    headers: {
                        "Content-Type": "application/json; charset=utf-8",
                    },
                }).done((res) => {
                    if (res.code == 1) {
                        alert("회원정지 성공");
                        location.href = "/admin/" + adminId + "/activeUsersList";
                    } else {
                        alert(res.message);
                    }
                });
            }

            $("#btnActiveUsers").click(() => {
                activeUsers();
            });

            function activeUsers() {
                let adminId = $("#adminId").val();
                let usersId = $("#usersId").val();
                let data = "active";

                $.ajax("/admin/" + adminId + "/activeUsers/" + usersId, {
                    type: "PUT",
                    dataType: "json",
                    data: JSON.stringify(data),
                    headers: {
                        "Content-Type": "application/json; charset=utf-8",
                    },
                }).done((res) => {
                    if (res.code == 1) {
                        alert("회원정지해제 성공");
                        location.href = "/admin/" + adminId + "/activeUsersList";
                    } else {
                        alert(res.message);
                    }
                });
            }


            $("#btnDeleteUsers").click(() => {
                deleteUsers();
            });

            function deleteUsers() {
                let adminId = $("#adminId").val();
                let usersId = $("#usersId").val();

                $.ajax("/admin/" + adminId + "/deleteUsers/" + usersId, {
                    type: "DELETE",
                    dataType: "json",
                }).done((res) => {
                    if (res.code == 1) {
                        alert("회원영구삭제 성공");
                        location.href = "/admin/" + adminId + "/activeUsersList";
                    } else {
                        alert(res.message);
                    }
                });
            }

        </script>

        <%@ include file="../layout/footer.jsp" %>