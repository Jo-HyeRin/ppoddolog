package com.example.ppoddolog.domain.board;

import java.sql.Timestamp;

import com.example.ppoddolog.web.dto.board.BoardReqDto.UpdateDto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class Board {
    private Integer boardId;
    private String title;
    private String thumbnail;
    private String content;
    private Integer usersId;
    private Integer categoryId;
    private Timestamp updatedAt;
    private Timestamp createdAt;

    // 게시글등록
    public Board(String title, String thumbnail, String content, Integer usersId, Integer categoryId) {
        this.title = title;
        this.thumbnail = thumbnail;
        this.content = content;
        this.usersId = usersId;
        this.categoryId = categoryId;
    }

    // 게시글수정
    public void updateBoard(UpdateDto updateDto) {
        this.title = updateDto.getTitle();
        this.thumbnail = updateDto.getThumbnail();
        this.content = updateDto.getContent();
        this.categoryId = updateDto.getCategoryId();
    }
}
