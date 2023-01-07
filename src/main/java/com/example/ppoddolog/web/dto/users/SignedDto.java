package com.example.ppoddolog.web.dto.users;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Setter
@Getter
public class SignedDto {
    private Integer usersId;
    private String username;
    private String role;
    private String state;
}
