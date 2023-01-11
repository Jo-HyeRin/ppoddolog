<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${principal.usersId}" />

        <div class="updateUsers_wrapper">
            <h2 class="updateUsers_title">프로필</h2>
            <div class="updateUsers_container">
                <div class="updateUsers_box--top">
                    <div class="updateUsers_photo">
                        <img src="/img/${usersPS.photo}">
                    </div>
                    <br />
                    <div class="updateUsers_photoname">
                        <input type="file" id="file" accept="image/*" onchange="setThumbnail(event)">
                    </div>
                    <div class="updateUsers_photo" id="imageContainer" style="display:none;"></div>
                </div>
                <div class="updateUsers_box--bottom">
                    <div class="updateUsers_box--text">${usersPS.realname}</div>
                    <div class="updateUsers_box--text">${usersPS.username}</div>
                </div>
            </div>

            <form>
                <div class="updateUsers_under">
                    <div class="updateUsers_content">
                        <div class="updateUsers_content_item">
                            <div class="updateUsers_content_item--text">닉네임</div>
                            <button class="updateUsers_content_item--button" id="btnNicknameSameCheck" type="button">닉네임
                                중복체크</button>
                        </div>
                        <input class="updateUsers_input_box" id="nickname" value="${usersPS.nickname}" type="text"
                            placeholder="${usersPS.nickname}" maxlength="20">
                    </div>
                    <span class="nicknameValid" style="padding-left: 120px; color: red; display: none"></span>

                    <div class="updateUsers_content">
                        <div class="updateUsers_content_item">
                            <div class="updateUsers_content_item--text">이메일</div>
                            <button class="updateUsers_content_item--button" id="btnEmailSameCheck" type="button">이메일
                                중복체크</button>
                        </div>
                        <input class="updateUsers_input_box" id="email" type="text" value="${usersPS.email}"
                            placeholder="${usersPS.email}" maxlength="20">
                    </div>
                    <span class="emailValid" style="padding-left: 120px; color: red; display: none"></span>

                    <div class="updateUsers_content">
                        <div class="updateUsers_content_item">
                            <div class="updateUsers_content_item--text">주소</div>
                            <input class="updateUsers_content_item--button" id="postcode" type="text"
                                value="${usersAddress.zipCode}" placeholder="${usersAddress.zipCode}" readonly
                                onclick="findAddress()" style="border-radius:5px;">
                            <button class="updateUsers_content_item--button" id="btnAddress" type="button"
                                onclick="findAddress()">우편번호찾기</button>
                        </div>
                        <input class="updateUsers_input_box" id="addr" type="text" value="${usersAddress.roadName}"
                            placeholder="${usersAddress.roadName}" readonly>
                        <input class="updateUsers_input_box" id="detailAddress" type="text"
                            value="${usersAddress.detailAddress}" placeholder="${usersAddress.detailAddress}">
                    </div>

                    <div class="updateUsers_content">
                        <div class="updateUsers_content_item">
                            <div class="updateUsers_content_item--text">연락처</div>
                            <button class="updateUsers_content_item--button" id="btnPhoneSameCheck" type="button">연락처
                                중복체크</button>
                        </div>
                        <input class="updateUsers_input_box" id="phone" type="text" value="${usersPS.phone}"
                            placeholder="${usersPS.phone}" maxlength="20">
                    </div>
                </div>
            </form>

            <div class="updateUsers_button">
                <button class="updateUsers_button_item" id="btnUpdate" type="button">회원수정완료</button>
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

            //사진 미리 보기
            function setThumbnail(event) {
                let reader = new FileReader();
                reader.onload = function (event) {
                    if (document.getElementById("newImg")) {
                        document.getElementById("newImg").remove();
                    }
                    let img = document.createElement("img");
                    let oldImg = $("#oldImg");
                    oldImg.remove();
                    img.setAttribute("src", event.target.result);
                    img.setAttribute("id", "newImg");
                    document.querySelector("#imageContainer").appendChild(img);
                };
                reader.readAsDataURL(event.target.files[0]);
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
                    phone: $("#phone").val()
                };
                let formData = new FormData();
                formData.append('file', $("#file")[0].files[0]);
                formData.append('updateDto', new Blob([JSON.stringify(data)], { type: "application/json" }));

                $.ajax("/users/" + usersId + "/update", {
                    type: "PUT",
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
                        location.href = "/users/" + usersId + "/detail";
                    } else {
                        alert(res.msg);
                    }
                });
            }
        </script>

        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

        <%@ include file="../layout/footer.jsp" %>