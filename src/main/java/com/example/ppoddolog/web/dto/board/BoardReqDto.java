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
        private String thumbnail;
        private String content;

        public Board toEntity() {
            Board board = new Board(this.title, this.thumbnail, this.content, this.usersId, this.categoryId);
            return board;
        }
    }

    @Setter
    @Getter
    public static class UpdateDto {
        private String title;
        private String thumbnail;
        private String content;
        private Integer categoryId;
    }

    @Setter
    @Getter
    public static class ListReqDto {
        private Integer categoryId;
    }

}