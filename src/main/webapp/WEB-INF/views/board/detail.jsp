<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${principal.usersId}" />
        <input id="boardId" type="hidden" value="${boardPS.boardId}" />
        <input id="likesId" type="hidden" value="${boardPS.likesId}" />

        <h2 style="text-align: center">게시글 상세보기</h2>

        <form>
            <div class="left_input">
                <br />
                <div class="mb-3 mt-3" id="title">
                    <h3>◆ title </h3> ${boardPS.title}
                </div>
                <br />
                <div>
                    좋아요수 : <span id="countLikes">${boardPS.likesCount}</span>
                    <c:choose>
                        <c:when test="${boardPS.isLikes eq true}">
                            <i id="iconLikes" class='${"fa-solid"} fa-heart my_pointer my_red'></i>
                        </c:when>
                        <c:otherwise>
                            <i id="iconLikes" class='${"fa-regular"} fa-heart my_pointer my_red'></i>
                        </c:otherwise>
                    </c:choose>

                </div>

                <br />
                <div class="mb-3">◆사진</div>
                <div class="right">
                    <img src="/img/${boardPS.thumbnail}" style="width: 200px">
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
            // 하트 채우기
            function renderLikes() {
                $("#iconLikes").removeClass("fa-regular");
                $("#iconLikes").addClass("fa-solid");
            }

            // 하트 비우기
            function renderCancelLikes() {
                $("#iconLikes").removeClass("fa-solid");
                $("#iconLikes").addClass("fa-regular");
            }

            $("#iconLikes").click(() => {
                let isLikesState = $("#iconLikes").hasClass("fa-solid");

                if (isLikesState) {
                    deleteLikes();
                } else {
                    insertLikes();
                }
            });

            // DB에 insert 요청하기
            function insertLikes() {
                let boardId = $("#boardId").val();

                $.ajax("/board/" + boardId + "/likes", {
                    type: "POST",
                    dataType: "json"
                }).done((res) => {
                    if (res.code == 1) {
                        renderLikes();
                        let count = $("#countLikes").text();
                        $("#countLikes").text(Number(count) + 1);
                        $("#likesId").val(res.data.likesId);
                    } else {
                        alert("좋아요 추가 실패");
                    }
                });
            }

            // DB에 delete 요청하기
            function deleteLikes() {
                let boardId = $("#boardId").val();
                let likesId = $("#likesId").val();

                $.ajax("/board/" + boardId + "/unlikes/" + likesId, {
                    type: "DELETE",
                    dataType: "json"
                }).done((res) => {
                    if (res.code == 1) {
                        renderCancelLikes();
                        let count = $("#countLikes").text();
                        $("#countLikes").text(Number(count) - 1);
                    } else {
                        alert("좋아요 취소 실패");
                    }
                });
            }

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