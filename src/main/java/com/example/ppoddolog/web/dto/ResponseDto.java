package com.example.ppoddolog.web.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ResponseDto<T> {
    private Integer code; // 성공 : 1, 실패 : -1
    private String msg;
    private T data;
}
