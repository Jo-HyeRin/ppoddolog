package com.example.ppoddolog.web.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

public class UsersRespDto {

    @AllArgsConstructor
    @Setter
    @Getter
    public static class SignedDto {
        private Integer usersId;
        private String username;
        private String role;
        private String state;
    }
}
