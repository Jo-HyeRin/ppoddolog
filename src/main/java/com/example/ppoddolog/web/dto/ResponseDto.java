package com.example.ppoddolog.web.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ResponseDto<T> {
    private String msg;
    private T data;
}
