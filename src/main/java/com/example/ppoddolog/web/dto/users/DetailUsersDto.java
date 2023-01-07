package com.example.ppoddolog.web.dto.users;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class DetailUsersDto {
    private Integer usersId;
    private String username;
    private String realname;
    private String nickname;
    private String email;
    private String address;
    private String phone;
    private String photo;
    private String state;
}
