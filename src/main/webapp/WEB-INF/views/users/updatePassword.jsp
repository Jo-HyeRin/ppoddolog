<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${principal.usersId}" />

        <div class="container">
            <h2>비밀번호변경</h2>
            <form>
                <div class="left_input">
                    <br />
                    <div class="mb-3">
                        ◆ 현재 비밀번호 <input id="passwordNow" type="password" class="form-control"
                            placeholder="현재 비밀번호를 입력해주세요">
                    </div>
                    <br />
                    <div class="mb-3">
                        ◆ 새 비밀번호 <input id="password" type="password" class="form-control" placeholder="새 비밀번호를 입력해주세요">
                    </div>
                    <br />
                    <div class="mb-3">
                        ◆ 새 비밀번호확인
                        <span id="passwordCheck" style="visibility: hidden; color: tomato;">
                            -----비밀번호가 같지 않습니다! </span>
                        <input id="passwordConfirm" type="password" class="form-control"
                            placeholder="비밀번호를 한 번 더 입력해주세요">
                    </div>
                    <br />
                </div>
            </form>

            <div class="mb-5"></div>

            <div class="d-grid gap-1 col-2 mx-auto">
                <button id="btnUpdatePassword" type="button" class="btn btn-primary">비밀번호변경완료</button>
            </div>

        </div>

        <script>
            // 새 비밀번호 일치 여부 체크
            $("#passwordConfirm").keyup((event) => {
                event.preventDefault();
                if ($("#password").val() != $("#passwordConfirm").val()) {
                    $("#passwordCheck").css("visibility", "visible");
                    $("#btnSave").attr(`disabled`, true);
                } else {
                    $("#passwordCheck").css("visibility", "hidden");
                    $("#btnSave").removeAttr(`disabled`);
                }
            });

            $("#btnUpdatePassword").click(() => {
                updatePassword();
            });

            function updatePassword() {
                let usersId = $("#usersId").val();
                let data = {
                    passwordNow: $("#passwordNow").val(),
                    password: $("#password").val()
                };

                $.ajax("/users/" + usersId + "/updatePassword", {
                    type: "PUT",
                    dataType: "json",
                    data: JSON.stringify(data),
                    headers: {
                        "Content-Type": "application/json; charset=utf-8",
                    },
                }).done((res) => {
                    if (res.code == 1) {
                        alert("비밀번호변경 성공");
                        location.href = "/users/" + usersId + "/detail";
                    } else {
                        alert(res.message);
                    }
                });
            }
        </script>

        <%@ include file="../layout/footer.jsp" %>