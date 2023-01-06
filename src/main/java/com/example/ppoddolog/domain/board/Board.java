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

    // 게시글등록
    public Board(String title, String content, Integer usersId, Integer categoryId) {
        this.title = title;
        this.content = content;
        this.usersId = usersId;
        this.categoryId = categoryId;
    }
}