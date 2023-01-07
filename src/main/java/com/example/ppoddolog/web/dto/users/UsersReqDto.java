package com.example.ppoddolog.web.dto.users;

import com.example.ppoddolog.domain.users.Users;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public class UsersReqDto {

    @Setter
    @Getter
    public static class JoinDto {
        private String username;
        private String password;
        private String realname;
        private String nickname;
        private String email;
        private String address;
        private String phone;
        private String photo;

        public Users toEntity() {
            Users users = new Users(this.username, this.password, this.realname, this.nickname, this.email,
                    this.address, this.phone, this.photo);
            return users;
        }
    }

    @NoArgsConstructor
    @Setter
    @Getter
    public static class LoginDto {
        private String username;
        private String password;
    }

    @Setter
    @Getter
    public static class UpdateDto {
        private String nickname;
        private String email;
        private String address;
        private String phone;
        private String photo;
    }

    @Setter
    @Getter
    public static class PasswordDto {
        private String passwordNow;
        private String password;
    }
}
