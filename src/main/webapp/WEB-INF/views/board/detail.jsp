<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${principal.usersId}" />
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
            <button id="btnUpdateBoard" type="button" class="btn btn-primary">게시글수정</button>
        </div>
        <br />
        <div class="d-grid gap-1 col-2 mx-auto">
            <button id="btnDeleteBoard" type="button" class="btn btn-primary">게시글삭제</button>
        </div>

        <script>
            $("#btnUpdateBoard").click(() => {
                let usersId = $("#usersId").val();
                let boardId = $("#boardId").val();
                location.href = "/board/users/" + usersId + "/updateForm/" + boardId;
            });

            $("#btnDeleteBoard").click(() => {
                deleteBoard();
            });

            function deleteBoard() {
                let usersId = $("#usersId").val();
                let boardId = $("#boardId").val();

                $.ajax("/board/users/" + usersId + "/delete/" + boardId, {
                    type: "DELETE",
                    dataType: "json",
                    error: function (data, status, error) {
                        alert(data.responseText);
                    },
                }).done((res) => {
                    if (res.code == 1) {
                        alert(res.msg);
                        location.href = "/board/list";
                    } else {
                        alert(res.msg);
                        return false;
                    }
                });
            }

        </script>


        <%@ include file="../layout/footer.jsp" %>