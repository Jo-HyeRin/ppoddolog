<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <input id="usersId" type="hidden" value="${principal.usersId}" />

        <h2>게시글 등록</h2>
        <form>
            <p>카테고리 :</p>
            <select id="categoryId">
                <c:forEach var="categoryList" items="${categoryList}">
                    <option value="${categoryList.categoryId}">${categoryList.categoryName}</option>
                </c:forEach>
            </select>
            <div class="mb-3">
                ◆ 게시글 제목 <input id="title" type="text" class="form-control" placeholder="제목을 입력해주세요">
            </div>
            <br />
            <div class="mb-3">◆사진</div>
            <div style="width: 400px;">
                <div id="imageContainer" class="form-group">
                    <input type="file" id="file" accept="image/*" onchange="setThumbnail(event)">
                </div>
            </div>
            <br />
            <div class="mb-3">
                ◆ 게시글 내용 <input id="content" type="text" class="form-control" placeholder="내용을 입력해주세요">
            </div>
        </form>

        <div class="mb-5"></div>

        <div class="d-grid gap-1 col-2 mx-auto">
            <button id="btnSave" type="submit" class="btn btn-primary">게시글 등록</button>
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

            $("#btnSave").click(() => {
                let usersId = $("#usersId").val();
                let data = {
                    title: $("#title").val(),
                    content: $("#content").val(),
                    categoryId: $("#categoryId").val(),
                    usersId: $("#usersId").val()
                };
                let formData = new FormData();
                formData.append('file', $("#file")[0].files[0]);
                formData.append('saveDto', new Blob([JSON.stringify(data)], { type: "application/json" }));

                $.ajax("/board/users/" + usersId + "/save", {
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
                        location.href = "/board/users/" + usersId + "/list";
                    } else {
                        alert(res.msg);
                        return false;
                    }
                });
            });
        </script>

        <%@ include file="../layout/footer.jsp" %>