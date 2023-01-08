<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${principal.usersId}" />

        <div class="container">
            <h2>나의 정보 수정</h2>
            <form>
                <div class="left_input">
                    <br />
                    <div class="mb-3 mt-3" id="username">
                        <h3>◆아이디</h3> ${usersPS.username}
                    </div>
                    <br />
                    <div class="mb-3 mt-3" id="realname">
                        <h3>◆이름</h3>${usersPS.realname}
                    </div>
                    <br />
                    <div class="mb-3 mt-3">
                        <h3>◆닉네임</h3>
                        <input id="nickname" type="text" value="${usersPS.nickname}" class="form-control"
                            placeholder="${usersPS.nickname}">
                    </div>
                    <div class="mb-3 mt-3">
                        <h3>◆이메일</h3><input id="email" type="text" value="${usersPS.email}" class="form-control"
                            placeholder="${usersPS.email}">
                    </div>
                    <br />
                    <div class="mb-3 mt-3">
                        <h3>◆주소</h3><input id="address" type="text" value="${usersPS.address}" class="form-control"
                            placeholder="${usersPS.address}">
                    </div>
                    <br />
                    <div class="mb-3 mt-3">
                        <h3>◆연락처</h3><input id="phone" type="text" value="${usersPS.phone}" class="form-control"
                            placeholder="${usersPS.phone}">
                    </div>
                    <br />
                    <div class="mb-3 mt-3">
                        <h3>◆사진</h3><input id="photo" type="text" value="${usersPS.photo}" class="form-control"
                            placeholder="${usersPS.photo}">
                    </div>
                    <br />
                </div>
            </form>

            <div class="mb-5"></div>

            <div class="d-grid gap-1 col-2 mx-auto">
                <button id="btnUpdate" type="button" class="btn btn-primary">회원수정완료</button>
            </div>

        </div>

        <script>
            $("#btnUpdate").click(() => {
                updateUsers();
            });

            function updateUsers() {
                let usersId = $("#usersId").val();
                let data = {
                    password: $("#password").val(),
                    nickname: $("#nickname").val(),
                    email: $("#email").val(),
                    address: $("#address").val(),
                    phone: $("#phone").val(),
                    photo: $("#photo").val()
                };

                $.ajax("/users/" + usersId + "/update", {
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
                        location.href = "/users/" + usersId + "/detail";
                    } else {
                        alert(res.msg);
                    }
                });
            }
        </script>

        <%@ include file="../layout/footer.jsp" %>