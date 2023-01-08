package com.example.ppoddolog.web.dto.users;

import lombok.Getter;

@Getter
public class AddressDto {
    private Integer usersId;

    private String zipCode;
    private String roadName;
    private String detailAddress;
}
