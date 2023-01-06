package com.example.ppoddolog.web.dto.board;

import com.example.ppoddolog.domain.board.Board;

import lombok.Getter;
import lombok.Setter;

public class BoardReqDto {

    @Setter
    @Getter
    public static class SaveDto {
        private Integer categoryId;
        private Integer usersId;
        private String title;
        private String content;

        public Board toEntity() {
            Board board = new Board(this.title, this.content, this.usersId, this.categoryId);
            return board;
        }
    }

}