<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <div class="container">
            <h2>회원가입</h2>
            <form>
                <div class="mb-3 mt-3">
                    ◆아이디 <input id="username" type="text" class="form-control" placeholder="아이디를 입력해주세요."
                        maxlength="20">
                    <button id="btnUsernameSameCheck" class="btn btn-warning" type="button">아이디 중복체크</button>
                </div>
                <span class="usernameValid" style="padding-left: 120px; color: red; display: none"></span>
                <div class="mb-3">
                    ◆비밀번호 <input id="password" type="password" class="form-control" placeholder="비밀번호를 입력해주세요"
                        maxlength="20">
                </div>
                <span class="passwordValid" style="padding-left: 120px; color: red; display: none"></span>
                <div class="mb-3">
                    ◆비밀번호확인
                    <span id="passwordCheck" style="visibility: hidden; color: tomato;">
                        -----비밀번호가 같지 않습니다! </span>
                    <input id="passwordConfirm" type="password" class="form-control" placeholder="비밀번호를 한 번 더 입력해주세요"
                        maxlength="20">
                </div>
                <span class="passwordCheckValid" style="padding-left: 120px; color: red; display: none"></span>
                <div class="mb-3">
                    ◆이름 <input id="realname" type="text" class="form-control" placeholder="이름을 입력해주세요" maxlength="20">
                </div>
                <span class="realnameValid" style="padding-left: 120px; color: red; display: none"></span>
                <div class="mb-3">
                    ◆닉네임 <input id="nickname" type="text" class="form-control" placeholder="닉네임을 입력해주세요" maxlength="20">
                    <button id="btnNicknameSameCheck" class="btn btn-warning" type="button">닉네임 중복체크</button>
                </div>
                <span class="nicknameValid" style="padding-left: 120px; color: red; display: none"></span>
                <div class="mb-3">
                    ◆이메일<input id="email" type="text" class="form-control" placeholder="이메일을 입력해주세요" maxlength="50">
                    <button id="btnEmailSameCheck" class="btn btn-warning" type="button">이메일 중복체크</button>
                </div>
                <span class="emailValid" style="padding-left: 120px; color: red; display: none"></span>
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
                    ◆전화번호<input id="phone" type="text" class="form-control" placeholder="전화번호 양식 : 000-000-0000"
                        maxlength="20">
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

        <script src="/js/joinUsers.js"></script>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

        <%@ include file="../layout/footer.jsp" %>