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

// 유효성 검사 시작 ---------------------------------------------------//
function valid() {
    let username = $("#username").val();
    let password = $("#password").val();
    let passwordCheck = $("#passwordCheck").val();
    let realname = $("#realname").val();
    let nickname = $("#nickname").val();
    let email = $("#email").val();

    if (username == null) {
        return true;
    }
    if (password == null) {
        return true;
    }
    if (passwordCheck == null) {
        return true;
    }
    if (realname == null) {
        return true;
    }
    if (nickname == null) {
        return true;
    }
    if (email == null) {
        return true;
    }
    if (validUsername()) {
        return true;
    }
    if (validPassword()) {
        return true;
    }
    if (validPasswordCheck()) {
        return true;
    }
    if (validRealname()) {
        return true;
    }
    if (validNickname()) {
        return true;
    }
    if (validEmail()) {
        return true;
    } else {
        return;
    }
}

// username 유효성 검사
function validUsername() {
    let username = $("#username").val();
    var spaceRule = /\s/g;
    var korRule = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
    if (korRule.test(username)) {
        $(".usernameValid").css("display", "inline-block");
        $(".usernameValid").text(
            "아이디는 영문소문자, 숫자, 특수기호(_)만 사용 가능합니다."
        );
        return true;
    }
    if (spaceRule.test(username)) {
        $(".usernameValid").css("display", "inline-block");
        $(".usernameValid").text("공백을 제거해주세요");
        return true;
    }
    if (username.length < 1) {
        $(".usernameValid").css("display", "inline-block");
        $(".usernameValid").text("아이디는 필수 입력정보입니다.");
        return true;
    }
    if (username.length < 2) {
        $(".usernameValid").css("display", "inline-block");
        $(".usernameValid").text("아이디는 2자~15자 내외로 입력해주세요.");
        return true;
    } else {
        $(".usernameValid").css("display", "none");
        return false;
    }
}

// password 유효성 검사
function validPassword() {
    let password = $("#password").val();
    var spaceRule = /\s/g;
    var korRule = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
    if (korRule.test(password)) {
        $(".passwordValid").css("display", "inline-block");
        $(".passwordValid").text(
            "숫자, 영문 대소문자, 특수문자 중 두가지 이상으로 조합해 주십시오."
        );
        return true;
    }
    if (spaceRule.test(password)) {
        $(".passwordValid").css("display", "inline-block");
        $(".passwordValid").text("공백을 제거해주세요");
        return true;
    }
    if (password.length < 1) {
        $(".passwordValid").css("display", "inline-block");
        $(".passwordValid").text("비밀번호는 필수 정보입니다.");
        return true;
    }
    if (password.length < 4 || password.length > 20) {
        $(".passwordValid").css("display", "inline-block");
        $(".passwordValid").text(
            "비밀번호는 4자~20자 내외로 입력해주세요."
        );
        return true;
    } else {
        $(".passwordValid").css("display", "none");
        return false;
    }
}

// password확인 유효성 검사
function validPasswordSame() {
    let password = $("#password").val();
    let passwordCheck = $("#passwordCheck").val();
    if (password != passwordCheck) {
        $(".passwordCheckValid").css("display", "inline-block");
        $(".passwordCheckValid").text("비밀번호가 일치하지 않습니다.");
        return true;
    }
    if (password.length < 1) {
        $(".passwordCheckValid").css("display", "inline-block");
        $(".passwordCheckValid").text("비밀번호 재확인은 필수정보입니다.");
        return true;
    } else {
        $(".passwordCheckValid").css("display", "none");
        return false;
    }
}

// realname 유효성 검사
function validRealname() {
    let realname = $("#realname").val();
    var spaceRule = /\s/g;
    if (spaceRule.test(realname)) {
        $(".realnameValid").css("display", "inline-block");
        $(".realnameValid").text("공백을 제거해주세요");
        return true;
    }
    if (realname.length < 1) {
        $(".realnameValid").css("display", "inline-block");
        $(".realnameValid").text("닉네임은 필수 정보입니다.");
        return true;
    } else {
        $(".realnameValid").css("display", "none");
        return false;
    }
}

// nickname 유효성 검사
function validNickname() {
    let nickname = $("#nickname").val();
    var spaceRule = /\s/g;
    if (spaceRule.test(nickname)) {
        $(".nicknameValid").css("display", "inline-block");
        $(".nicknameValid").text("공백을 제거해주세요");
        return true;
    }
    if (nickname.length < 1) {
        $(".nicknameValid").css("display", "inline-block");
        $(".nicknameValid").text("닉네임은 필수 정보입니다.");
        return true;
    } else {
        $(".nicknameValid").css("display", "none");
        return false;
    }
}

// email 유효성 검사
function validEmail() {
    let email = $("#email").val();
    var spaceRule = /\s/g;
    var emailRule = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if (spaceRule.test(email)) {
        $(".emailValid").css("display", "inline-block");
        $(".emailValid").text("공백을 제거해주세요");
        return true;
    }
    if (email.length < 1) {
        $(".emailValid").css("display", "inline-block");
        $(".emailValid").text("이메일은 필수 정보입니다.");
        return true;
    }
    if (!emailRule.test(email)) {
        $(".emailValid").css("display", "inline-block");
        $(".emailValid").text("올바르지 않은 이메일 형식입니다.");
        return true;
    } else {
        $(".emailValid").css("display", "none");
        return false;
    }
}
