package com.example.ppoddolog.web.dto.board;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class DetailBoardDto {
    private Integer boardId;
    private String title;
    private String thumbnail;
    private String content;
    private String categoryName;
    private String nickname;
    private String date;
}
