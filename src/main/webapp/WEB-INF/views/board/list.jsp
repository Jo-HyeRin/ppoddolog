<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <h2 style="text-align: center">게시글 목록</h2>
        <div class="container mt-3">
            <table class="table table-bordered" style="text-align: center">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>게시글</th>
                        <th>작성자닉네임</th>
                        <th>작성일자</th>
                    </tr>
                </thead>
                <c:forEach var="boardList" items="${boardList}">
                    <tr>
                        <td>${boardList.ROW}</td>
                        <td>${boardList.title}</td>
                        <td>${boardList.nickname}</td>
                        <td>${boardList.date}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <%@ include file="../layout/footer.jsp" %>