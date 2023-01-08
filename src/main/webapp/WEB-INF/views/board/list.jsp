<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${principal.usersId}" />

        <br />
        <h2 style="text-align: center">게시글 목록</h2>
        <br />

        <!-- 카테고리 & 검색 -->
        <div class="d-flex justify-content-between" style="width:1190px">
            <select id="select_category" name="category" style="width: 150px; left: 10%">
                <option id="categories">== 전체보기 ==</option>
                <c:forEach var="categoryList" items="${categoryList}">
                    <option value="${categoryList.categoryId}">${categoryList.categoryName}</option>
                </c:forEach>
            </select>

            <form class="d-flex" method="get" action="/board/list">
                <input class="searchForm" type="text" placeholder="Search" name="keyword">
                <button id="keyword" class="searchsubmit" type="submit">🔍</button>
            </form>
        </div>

        <!-- 게시글 목록 -->
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
                        <td>${boardList.row}</td>
                        <td>
                            <div id="title" class="container p-4 my-4 border">
                                <a href="/board/users/${boardList.usersId}/detail/${boardList.boardId}">
                                    ${boardList.title}</a>
                            </div>
                        </td>
                        <td>${boardList.nickname}</td>
                        <td>${boardList.date}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <!-- 페이징 -->
        <div class="d-flex justify-content-center">
            <ul class="pagination">
                <li class='page-item ${paging.first ? "disabled" : " "}'><a class="page-link"
                        href="?page=${paging.currentPage-1}&keyword=${paging.keyword}">Prev</a>
                </li>

                <c:forEach var="num" begin="${paging.startPageNum}" end="${paging.lastPageNum}" step="1">
                    <li class='page-item ${paging.currentPage == num-1 ? "active" : ""}'>
                        <a class="page-link" href="?page=${num-1}&keyword=${paging.keyword}">${num}</a>
                    </li>
                </c:forEach>

                <li class='page-item ${paging.last ? "disabled" : " "}'><a class="page-link"
                        href="?page=${paging.currentPage+1}&keyword=${paging.keyword}">Next</a>
                </li>
            </ul>
        </div>

        <!-- 버튼 -->
        <div class="d-grid gap-1 col-2 mx-auto">
            <button id="btnSave" type="submit" class="btn btn-primary">게시글 등록</button>
        </div>

        <script>
            $("#btnSave").click(() => {
                let usersId = $("#usersId").val();
                let boardId = $("#boardId").val();
                location.href = "/board/users/" + usersId + "/saveForm";
            });
        </script>

        <%@ include file="../layout/footer.jsp" %>