package com.example.ppoddolog.web.dto.admin;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class UsersListDto {
    private Integer row;
    private Integer usersId;
    private String username;
    private String realname;
    private String nickname;
    private String date;
}