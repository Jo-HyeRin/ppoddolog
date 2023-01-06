package com.example.ppoddolog.web.dto;

import com.example.ppoddolog.domain.board.Board;

import lombok.Getter;
import lombok.Setter;

public class BoardReqDto {

    @Setter
    @Getter
    public static class SaveDto {
        private Integer categoryId;
        private String title;
        private String content;

        public Board toEntity() {
            Board board = new Board(this.categoryId, this.title, this.content);
            return board;
        }
    }

}
