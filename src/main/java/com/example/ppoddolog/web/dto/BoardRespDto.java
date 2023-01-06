package com.example.ppoddolog.web.dto;

import lombok.Getter;
import lombok.Setter;

public class BoardRespDto {

    @Setter
    @Getter
    public static class ListDto {
        private Integer row;
        private String title;
        private String nickname;
        private String date;
    }
}
