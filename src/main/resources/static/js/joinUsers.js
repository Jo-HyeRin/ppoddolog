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