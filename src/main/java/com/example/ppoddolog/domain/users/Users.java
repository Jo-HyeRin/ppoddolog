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

    // 회원가입
    public Users(String username, String password, String realname, String nickname, String email, String address,
            String phone, String photo) {
        this.username = username;
        this.password = password;
        this.realname = realname;
        this.nickname = nickname;
        this.email = email;
        this.address = address;
        this.phone = phone;
        this.photo = photo;
        this.role = "user";
    }
}