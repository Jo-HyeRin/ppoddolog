<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <div class="container">
            <h2>로그인</h2>
            <form>
                <div class="mb-3 mt-3">
                    ◆아이디 <input id="username" type="text" class="form-control" placeholder="아이디를 입력해주세요.">
                </div>
                <div class="mb-3">
                    ◆비밀번호 <input id="password" type="password" class="form-control" placeholder="비밀번호를 입력해주세요">
                </div>
                <div class="mb-5"></div>

                <div class="d-grid gap-1 col-2 mx-auto">
                    <button id="btnLogin" type="button" class="btn btn-primary">로그인</button>
                </div>
                </br>
                <div class="d-grid gap-1 col-2 mx-auto">
                    <button id="btnJoin" type="button" class="btn btn-primary">회원가입</button>
                </div>
            </form>
        </div>

        <script>
            $("#btnLogin").click(() => {
                let loginData = {
                    username: $("#username").val(),
                    password: $("#password").val()
                }
                login(loginData);
            });

            function login(loginData) {
                $.ajax("/login", {
                    type: "POST",
                    dataType: "json",
                    data: JSON.stringify(loginData),
                    headers: {
                        "Content-Type": "application/json; charset=utf-8",
                    },
                }).done((res) => {
                    if (res.code == 1) {
                        alert(res.msg);
                        location.href = "/";
                    } else {
                        alert(res.msg);
                        return false;
                    }
                });
            }

            $("#btnJoin").click(() => {
                alert(res.msg);
                location.href = "/joinForm";
            });

        </script>

        <%@ include file="../layout/footer.jsp" %>