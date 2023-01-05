package com.example.ppoddolog.domain.users;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class Users {
    private Integer usersId;
    private String username;
    private String password;
    private String realname;
    private String nickname;
    private String email;
    private String address;
    private String phone;
    private String photo;
    private String role;
    private Timestamp updatedAt;
    private Timestamp createdAt;
}