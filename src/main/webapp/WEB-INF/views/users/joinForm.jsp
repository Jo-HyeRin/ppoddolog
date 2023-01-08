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
                    ◆비밀번호확인
                    <span id="passwordCheck" style="visibility: hidden; color: tomato;">
                        -----비밀번호가 같지 않습니다! </span>
                    <input id="passwordConfirm" type="password" class="form-control" placeholder="비밀번호를 한 번 더 입력해주세요">
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
                    ◆주소
                    <input id="postcode" type="text" placeholder="우편번호" readonly onclick="findAddress()">
                    <button id="btnAddress" type="button" class="btn btn-primary"
                        onclick="findAddress()">우편번호찾기</button>
                    <br>
                    <input id="addr" type="text" placeholder="주소" style="width: 620px;" readonly>
                    <input id="detailAddress" type="text" placeholder="상세주소" style="width: 620px;">
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
            // 패스워드 일치 여부 체크
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

            // 주소 불러오기
            function findAddress() {
                new daum.Postcode({
                    oncomplete: function (data) {
                        // 검색결과 항목을 선택했을때 실행할 코드
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가짐

                        let roadAddr = data.roadAddress; // 도로명 주소 변수
                        let jibunAddr = data.jibunAddress; // 지번 주소 변수

                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.getElementById('postcode').value = data.zonecode;
                        if (roadAddr !== '') {
                            document.getElementById("addr").value = roadAddr;
                        } else if (jibunAddr !== '') {
                            document.getElementById("addr").value = jibunAddr;
                        }
                    }
                }).open();
            }

            // 회원가입
            function join() {
                let data = {
                    username: $("#username").val(),
                    password: $("#password").val(),
                    realname: $("#realname").val(),
                    nickname: $("#nickname").val(),
                    email: $("#email").val(),
                    address: $("#postcode").val() + "," + $("#addr").val() + "," + $("#detailAddress").val(),
                    phone: $("#phone").val(),
                    photo: $("#photo").val(),
                };

                $.ajax("/join", {
                    type: "POST",
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
                        location.href = "/loginForm";
                    } else {
                        alert(res.msg);
                        return false;
                    }
                });
            }
        </script>

        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

        <%@ include file="../layout/footer.jsp" %>