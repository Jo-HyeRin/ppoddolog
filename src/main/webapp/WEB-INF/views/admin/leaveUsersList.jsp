<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <h2 style="text-align: center">탈퇴회원목록</h2>
        <div class="container mt-3">
            <table class="table table-bordered" style="text-align: center">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>유저고유번호</th>
                        <th>아이디</th>
                        <th>실명</th>
                        <th>닉네임</th>
                        <th>탈퇴일</th>
                    </tr>
                </thead>
                <c:forEach var="usersList" items="${usersList}">
                    <tr>
                        <td>${usersList.row}</td>
                        <td>${usersList.usersId}</td>
                        <td>
                            <div id="username" class="container p-4 my-4 border">
                                <a href="/admin/usersDetail/${usersList.usersId}">
                                    ${usersList.username}</a>
                            </div>
                        </td>
                        <td>${usersList.realname}</td>
                        <td>${usersList.nickname}</td>
                        <td>${usersList.date}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <%@ include file="../layout/footer.jsp" %>