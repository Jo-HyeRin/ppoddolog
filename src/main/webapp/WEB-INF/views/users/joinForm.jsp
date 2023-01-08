<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <div class="container">
            <h2>회원가입</h2>
            <form>
                <div class="mb-3 mt-3">
                    ◆아이디 <input id="username" type="text" class="form-control" placeholder="아이디를 입력해주세요.">
                    <button id="btnUsernameSameCheck" class="btn btn-warning" type="button">아이디 중복체크</button>
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
                    <button id="btnNicknameSameCheck" class="btn btn-warning" type="button">닉네임 중복체크</button>
                </div>
                <div class="mb-3">
                    ◆이메일<input id="email" type="text" class="form-control" placeholder="이메일을 입력해주세요">
                    <button id="btnEmailSameCheck" class="btn btn-warning" type="button">이메일 중복체크</button>
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
                    <button id="btnPhoneSameCheck" class="btn btn-warning" type="button">연락처 중복체크</button>
                </div>
                <div class="mb-3">◆사진</div>
                <div style="width: 400px;">
                    <div class="form-group">
                        <input type="file" id="file" accept="image/*" onchange="setThumbnail(event)">
                    </div>
                    <div id="imageContainer"></div>
                </div>

            </form>

            <div class="mb-5"></div>

            <div class="d-grid gap-1 col-2 mx-auto">
                <button id="btnJoin" type="button" class="btn btn-primary">회원가입하기</button>
            </div>

        </div>

        <script>
            // 아이디 중복체크
            let isUsernameSameCheck = false;
            let checkedUsername = "";
            $("#btnUsernameSameCheck").click(() => {
                if ($("#username").val() == "") {
                    alert("아이디를 입력하세요");
                    return;
                } else {
                    let username = $("#username").val();

                    $.ajax("/checkUsername/" + username, {
                        type: "GET",
                        dataType: "json",
                        async: true,
                        error: function (data, status, error) {
                            alert(data.responseText);
                        },
                    }).done((res) => {
                        if (res.code == 1) {
                            if (res.data == false) {
                                alert(res.msg);
                                isUsernameSameCheck = true;
                                checkedUsername = $("#username").val();
                            } else {
                                isUsernameSameCheck = false;
                                $("#username").val("");
                            }
                        }
                    });
                }
            });

            // 닉네임 중복체크
            let isNicknameSameCheck = false;
            let checkedNickname = "";
            $("#btnNicknameSameCheck").click(() => {
                if ($("#nickname").val() == "") {
                    alert("닉네임을 입력하세요");
                    return;
                } else {
                    let nickname = $("#nickname").val();

                    $.ajax("/checkNickname/" + nickname, {
                        type: "GET",
                        dataType: "json",
                        async: true,
                        error: function (data, status, error) {
                            alert(data.responseText);
                        },
                    }).done((res) => {
                        if (res.code == 1) {
                            if (res.data == false) {
                                alert(res.msg);
                                isNicknameSameCheck = true;
                                checkedNickname = $("#nickname").val();
                            } else {
                                isNicknameSameCheck = false;
                                $("#nickname").val("");
                            }
                        }
                    });
                }
            });

            // 이메일 중복체크
            let isEmailSameCheck = false;
            let checkedEmail = "";
            $("#btnEmailSameCheck").click(() => {
                if ($("#email").val() == "") {
                    alert("이메일을 입력하세요");
                    return;
                } else {
                    let email = $("#email").val();

                    $.ajax("/checkEmail/" + email, {
                        type: "GET",
                        dataType: "json",
                        async: true,
                        error: function (data, status, error) {
                            alert(data.responseText);
                        },
                    }).done((res) => {
                        if (res.code == 1) {
                            if (res.data == false) {
                                alert(res.msg);
                                isEmailSameCheck = true;
                                checkedEmail = $("#email").val();
                            } else {
                                isEmailSameCheck = false;
                                $("#email").val("");
                            }
                        }
                    });
                }
            });

            // 연락처 중복체크
            let isPhoneSameCheck = false;
            let checkedPhone = "";
            $("#btnPhoneSameCheck").click(() => {
                if ($("#phone").val() == "") {
                    alert("연락처를 입력하세요");
                    return;
                } else {
                    let phone = $("#phone").val();

                    $.ajax("/checkPhone/" + phone, {
                        type: "GET",
                        dataType: "json",
                        async: true,
                        error: function (data, status, error) {
                            alert(data.responseText);
                        },
                    }).done((res) => {
                        if (res.code == 1) {
                            if (res.data == false) {
                                alert(res.msg);
                                isPhoneSameCheck = true;
                                checkedPhone = $("#phone").val();
                            } else {
                                isPhoneSameCheck = false;
                                $("#phone").val("");
                            }
                        }
                    });
                }
            });

            // 회원가입
            $("#btnJoin").click(() => {
                if (isUsernameSameCheck == false) {
                    alert("아이디 중복 체크를 진행해주세요");
                    return;
                } else if (checkedUsername != $("#username").val()) {
                    alert("가입할 아이디가 상이합니다. 체크된 아이디 : " + checkedUsername);
                    return;
                }

                if (isNicknameSameCheck == false) {
                    alert("닉네임 중복 체크를 진행해주세요");
                    return;
                } else if (checkedNickname != $("#nickname").val()) {
                    alert("가입할 닉네임이 상이합니다. 체크된 닉네임 : " + checkedNickname);
                    return;
                }

                if (isEmailSameCheck == false) {
                    alert("이메일 중복 체크를 진행해주세요");
                    return;
                } else if (checkedNickname != $("#nickname").val()) {
                    alert("가입할 이메일이 상이합니다. 체크된 이메일 : " + checkedEmail);
                    return;
                }

                if (isPhoneSameCheck == false) {
                    alert("연락처 중복 체크를 진행해주세요");
                    return;
                } else if (checkedPhone != $("#phone").val()) {
                    alert("가입할 연락처가 상이합니다. 체크된 연락처 : " + checkedPhone);
                    return;
                }

                join();
            });

            function join() {
                let data = {
                    username: $("#username").val(),
                    password: $("#password").val(),
                    realname: $("#realname").val(),
                    nickname: $("#nickname").val(),
                    email: $("#email").val(),
                    address: $("#postcode").val() + "," + $("#addr").val() + "," + $("#detailAddress").val(),
                    phone: $("#phone").val(),
                };
                let formData = new FormData();
                formData.append('file', $("#file")[0].files[0]);
                formData.append('joinDto', new Blob([JSON.stringify(data)], { type: "application/json" }));

                $.ajax("/join", {
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    enctype: 'multipart/form-data',
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

        <script src="/js/joinUsers.js"></script>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

        <%@ include file="../layout/footer.jsp" %>