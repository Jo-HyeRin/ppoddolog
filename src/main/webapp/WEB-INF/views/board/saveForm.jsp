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
            <div class="mb-3">
                ◆ 게시글 내용 <input id="content" type="text" class="form-control" placeholder="내용을 입력해주세요">
            </div>
        </form>

        <div class="mb-5"></div>

        <div class="d-grid gap-1 col-2 mx-auto">
            <button id="btnSave" type="submit" class="btn btn-primary">게시글 등록</button>
        </div>

        <script>
            $("#btnSave").click(() => {
                let usersId = $("#usersId").val();
                let data = {
                    title: $("#title").val(),
                    content: $("#content").val(),
                    categoryId: $("#categoryId").val(),
                    usersId: $("#usersId").val()
                };

                $.ajax("/board/users/" + usersId + "/save", {
                    type: "POST",
                    dataType: "json",
                    data: JSON.stringify(data),
                    headers: {
                        "Content-Type": "application/json",
                    },
                }).done((res) => {
                    if (res.code == 1) {
                        alert("게시글 등록 성공");
                        location.href = "/board/list";
                    } else {
                        alert(res.msg);
                        return false;
                    }
                });
            });
        </script>

        <%@ include file="../layout/footer.jsp" %>