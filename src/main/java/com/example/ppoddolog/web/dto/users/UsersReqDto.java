package com.example.ppoddolog.web.dto.users;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import com.example.ppoddolog.domain.users.Users;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public class UsersReqDto {

    @Setter
    @Getter
    public static class JoinDto {
        @Size(min = 2, max = 20, message = "username 길이가 부적합합니다.")
        @NotBlank(message = "username 공백일 수 없습니다.")
        private String username;

        @Size(min = 2, max = 20, message = "password 길이가 부적합합니다.")
        @NotBlank(message = "password 공백일 수 없습니다.")
        private String password;

        @Size(min = 2, max = 20, message = "realname 길이가 부적합합니다.")
        @NotBlank(message = "realname 공백일 수 없습니다.")
        private String realname;

        @Size(min = 2, max = 20, message = "nickname 길이가 부적합합니다.")
        @NotBlank(message = "nickname 공백일 수 없습니다.")
        private String nickname;

        @Size(min = 2, max = 50, message = "email 길이가 부적합합니다.")
        @NotBlank(message = "email 공백일 수 없습니다.")
        private String email;

        @Size(min = 2, max = 50, message = "address 길이가 부적합합니다.")
        @NotBlank(message = "address 공백일 수 없습니다.")
        private String address;

        @Size(min = 2, max = 20, message = "phone 길이가 부적합합니다.")
        @NotBlank(message = "phone 공백일 수 없습니다.")
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
        @Size(min = 2, max = 20, message = "username 길이가 부적합합니다.")
        @NotBlank(message = "username 공백일 수 없습니다.")
        private String username;

        @Size(min = 2, max = 20, message = "password 길이가 부적합합니다.")
        @NotBlank(message = "password 공백일 수 없습니다.")
        private String password;

        private boolean remember;
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
        @Size(min = 2, max = 20, message = "현재 password 길이가 부적합합니다.")
        @NotBlank(message = "현재 password 공백일 수 없습니다.")
        private String passwordNow;

        @Size(min = 2, max = 20, message = "새 password 길이가 부적합합니다.")
        @NotBlank(message = "새 password 공백일 수 없습니다.")
        private String password;
    }
}
