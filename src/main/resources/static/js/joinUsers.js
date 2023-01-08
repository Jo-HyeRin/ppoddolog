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