package com.example.ppoddolog.web.dto.board;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class DetailDto {
    private String title;
    private String content;
    private String categoryName;
    private String nickname;
    private String date;
    private Integer boardId;
}
