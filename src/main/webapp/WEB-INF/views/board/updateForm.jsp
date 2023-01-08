<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${principal.usersId}" />
        <input id="boardId" type="hidden" value="${boardPS.boardId}" />

        <h2 style="text-align: center">게시글 수정</h2>

        <form>
            <div class="left_input">
                <br />
                <div class="mb-3 mt-3">
                    <h3>◆ title </h3>
                    <input id="title" type="text" value="${boardPS.title}" class="form-control"
                        placeholder=${boardPS.title}>
                </div>
                <br />
                <div class="mb-3 mt-3">◆ thumbnail</div>
                <input type="file" id="file" onchange="setThumbnail(event)" />
                <div id="imageContainer">
                    <img id="oldImg" src="/img/${boardPS.thumbnail}">
                </div>
                <br />
                <div class="mb-3 mt-3">
                    <h3>◆ content </h3>
                    <input id="content" type="text" value="${boardPS.content}" class="form-control"
                        placeholder=${boardPS.content}>
                </div>
                <br />
                <div class="mb-3 mt-3" id="content">
                    <h3>◆ categoryName </h3> ${boardPS.categoryName}
                    <br />
                    <select id="categoryId">
                        <c:forEach var="categoryList" items="${categoryList}">
                            <option value="${categoryList.categoryId}">${categoryList.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>
                <br />
                <div class="mb-3 mt-3" id="content">
                    <h3>◆ nickname </h3> ${boardPS.nickname}
                </div>
                <br />
                <div class="mb-3 mt-3" id="content">
                    <h3>◆ date </h3> ${boardPS.date}
                </div>
                <br />
            </div>
        </form>

        <div class="d-grid gap-1 col-2 mx-auto">
            <button id="btnUpdate" type="button" class="btn btn-primary">게시글수정완료</button>
        </div>

        <script>
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

            $("#btnUpdate").click(() => {
                updateBoard();
            });

            function updateBoard() {
                let usersId = $("#usersId").val();
                let boardId = $("#boardId").val();
                let data = {
                    title: $("#title").val(),
                    content: $("#content").val(),
                    categoryId: $("#categoryId").val()
                };
                let formData = new FormData();
                formData.append('file', $("#file")[0].files[0]);
                formData.append('updateDto', new Blob([JSON.stringify(data)], { type: "application/json" }));

                $.ajax("/board/users/" + usersId + "/update/" + boardId, {
                    type: "PUT",
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
                        location.href = "/board/users/" + usersId + "/detail/" + boardId;
                    } else {
                        alert(res.msg);
                    }
                });
            }
        </script>


        <%@ include file="../layout/footer.jsp" %>