<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

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
                <div class="mb-3 mt-3" id="content">
                    <h3>◆ categoryName </h3> ${boardPS.categoryName}
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


        <%@ include file="../layout/footer.jsp" %>