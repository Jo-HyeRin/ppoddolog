<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="boardId" type="hidden" value="${boardPS.boardId}" />

        <h2 style="text-align: center">게시글 상세보기</h2>

        <form>
            <div class="left_input">
                <br />
                <div class="mb-3 mt-3" id="title">
                    <h3>◆ title </h3> ${boardPS.title}
                </div>
                <br />
                <div class="mb-3 mt-3" id="content">
                    <h3>◆ content </h3> ${boardPS.content}
                </div>
                <br />
                <div class="mb-3 mt-3" id="categoryName">
                    <h3>◆ categoryName </h3> ${boardPS.categoryName}
                </div>
                <br />
                <div class="mb-3 mt-3" id="nickname">
                    <h3>◆ nickname </h3> ${boardPS.nickname}
                </div>
                <br />
                <div class="mb-3 mt-3" id="date">
                    <h3>◆ date </h3> ${boardPS.date}
                </div>
                <br />
            </div>
        </form>

        <div class="d-grid gap-1 col-2 mx-auto">
            <button id="btnUpdate" type="button" class="btn btn-primary">게시글수정</button>
        </div>

        <script>
            $("#btnUpdate").click(() => {
                let boardId = $("#boardId").val();
                location.href = "/board/updateForm/" + boardId;
            });
        </script>


        <%@ include file="../layout/footer.jsp" %>