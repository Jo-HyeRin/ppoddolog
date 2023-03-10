<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <div class="container">
            <h2>회원가입</h2>
            <form>
                <div class="mb-3 mt-3">
                    ◆아이디 <input id="username" type="text" class="form-control" placeholder="아이디를 입력해주세요.">
                </div>
                <div class="mb-3">
                    ◆비밀번호 <input id="password" type="password" class="form-control" placeholder="비밀번호를 입력해주세요">
                </div>
                <div class="mb-3">
                    ◆이름 <input id="realname" type="text" class="form-control" placeholder="이름을 입력해주세요">
                </div>
                <div class="mb-3">
                    ◆닉네임 <input id="nickname" type="text" class="form-control" placeholder="닉네임을 입력해주세요">
                </div>
                <div class="mb-3">
                    ◆이메일<input id="email" type="text" class="form-control" placeholder="이메일을 입력해주세요">
                </div>
                <div class="mb-3">
                    ◆주소 <input id="address" type="text" class="form-control" placeholder="주소를 입력해주세요">
                </div>
                <div class="mb-3">
                    ◆전화번호<input id="phone" type="text" class="form-control" placeholder="전화번호 양식 : 000-000-0000">
                </div>
                <div class="mb-3">
                    ◆사진 <input id="photo" type="text" class="form-control" placeholder="사진을 입력해주세요">
                </div>
            </form>

            <div class="mb-5"></div>

            <div class="d-grid gap-1 col-2 mx-auto">
                <button onclick="join()" type="submit" class="btn btn-primary">회원가입하기</button>
            </div>

        </div>

        <script>
            function join() {
                let data = {
                    username: $("#username").val(),
                    password: $("#password").val(),
                    realname: $("#realname").val(),
                    nickname: $("#nickname").val(),
                    email: $("#email").val(),
                    address: $("#address").val(),
                    phone: $("#phone").val(),
                    photo: $("#photo").val(),
                };

                $.ajax("/join", {
                    type: "POST",
                    dataType: "json",
                    data: JSON.stringify(data),
                    headers: {
                        "Content-Type": "application/json",
                    },
                }).done((res) => {
                    if (res.code == 1) {
                        alert("회원가입이 완료되었습니다.");
                        location.href = "/loginForm";
                    } else {
                        alert(res.msg);
                        return false;
                    }
                });
            }
        </script>

        <%@ include file="../layout/footer.jsp" %>