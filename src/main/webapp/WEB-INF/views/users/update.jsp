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
                    <div class="mb-3">
                        ◆주소
                        <input id="postcode" type="text" placeholder="${usersAddress.zipCode}"
                            value="${usersAddress.zipCode}" onclick="findAddress()">
                        <button id="btnAddress" type="button" class="btn btn-primary"
                            onclick="findAddress()">우편번호찾기</button>
                        <br>
                        <input id="addr" type="text" placeholder="${usersAddress.roadName}"
                            value="${usersAddress.roadName}" style="width: 620px;" readonly>
                        <input id="detailAddress" type="text" placeholder="${usersAddress.detailAddress}"
                            value="${usersAddress.detailAddress}" style="width: 620px;">
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

            $("#btnUpdate").click(() => {
                updateUsers();
            });

            function updateUsers() {
                let usersId = $("#usersId").val();
                let data = {
                    password: $("#password").val(),
                    nickname: $("#nickname").val(),
                    email: $("#email").val(),
                    address: $("#postcode").val() + "," + $("#addr").val() + "," + $("#detailAddress").val(),
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

        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

        <%@ include file="../layout/footer.jsp" %>