package com.example.ppoddolog.domain.board;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public class Board {
    private Integer boardId;
    private String title;
    private String content;
    private Integer usersId;
    private Integer categoryId;
    private Timestamp updatedAt;
    private Timestamp createdAt;

    // 게시글 등록
    public Board(Integer categoryId, String title, String content) {
        this.categoryId = categoryId;
        this.title = title;
        this.content = content;
    }
}
