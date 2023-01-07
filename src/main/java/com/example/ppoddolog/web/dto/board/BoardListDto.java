package com.example.ppoddolog.web.dto.board;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BoardListDto {
    private Integer row;
    private String title;
    private String nickname;
    private String date;

    private Integer boardId;
    private Integer usersId;
}
