package com.example.ppoddolog.domain.users;

import java.sql.Timestamp;

import com.example.ppoddolog.web.dto.users.UsersReqDto.UpdateDto;

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
    private String state;
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
        this.state = "active";
    }

    // 유저수정
    public void updateUsers(UpdateDto updateDto) {
        this.password = updateDto.getPassword();
        this.nickname = updateDto.getNickname();
        this.email = updateDto.getEmail();
        this.address = updateDto.getAddress();
        this.phone = updateDto.getPhone();
        this.photo = updateDto.getPhoto();
    }

    // 유저탈퇴
    public void leaveUsers() {
        this.state = "inactive";
    }

    // 회원정지
    public void stopUsers() {
        this.state = "stop";
    }

    // 회원정지해제
    public void activeUsers() {
        this.state = "active";
    }
}