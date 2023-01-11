<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${principal.usersId}" />

        <div class="updatePassword_wrapper">
            <h2 class="updatePassword_title">비밀번호변경</h2>

            <div class="updatePassword_now">
                <div class="updatePassword_flex">
                    <div class="updatePassword_menu">현재 비밀번호</div>
                    <button class="updatePassword_now_button" id="btnEmailSameCheck" type="button">비밀번호확인</button>
                </div>
                <input id="passwordNow" type="password" class="updatePassword_input" placeholder="현재 비밀번호를 입력해주세요">
            </div>

            <div class="updatePassword_new">
                <div class="content">
                    <div class="content_item">
                        <div class="updatePassword_menu">새 비밀번호</div>
                    </div>
                    <input class="updatePassword_input" id="password" type="password" placeholder="새 비밀번호를 입력해주세요."
                        maxlength="20">
                </div>
                <span class="passwordValid" style="padding-left: 120px; color: red; display: none"></span>

                <div class="content">
                    <div class="updatePassword_flex">
                        <div class="updatePassword_menu">새 비밀번호확인</div>
                        <div class="updatePassword_msg" id="passwordCheck" style="visibility: hidden; color: tomato;">
                            -----비밀번호가 같지 않습니다! </div>
                    </div>
                    <input class="updatePassword_input" id="passwordConfirm" type="password"
                        placeholder="새 비밀번호를 한 번 더 입력해주세요." maxlength="20">
                </div>
                <span class="passwordCheckValid" style="padding-left: 120px; color: red; display: none"></span>
            </div>

            <div class="updatePassword_button">
                <button id="btnUpdatePassword" type="button" class="updatePassword_button_item">비밀번호 변경</button>
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
                    error: function (data, status, error) {
                        alert(data.responseText);
                        // console.log("HttpStatus: " + data.status);
                        // console.log("CustomApiException.msg: " + data.responseText);
                    },
                }).done((res) => {
                    if (res.code == 1) {
                        alert(res.msg);
                        location.href = "/users/" + usersId + "/detail";
                    } else {
                        alert(res.msg);
                        location.href = "/users/" + usersId + "/updatePassword";
                    }
                });
            }
        </script>

        <%@ include file="../layout/footer.jsp" %>