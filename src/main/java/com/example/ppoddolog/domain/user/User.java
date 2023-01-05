package com.example.ppoddolog.domain.user;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class User {
    private Integer userId;
    private String username;
    private String password;
}