package com.example.ppoddolog.handler;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.example.ppoddolog.config.CustomApiException;
import com.example.ppoddolog.web.dto.ResponseDto;

@ControllerAdvice
public class CustomExceptionHandler {

    @ExceptionHandler(CustomApiException.class)
    public ResponseEntity<?> basic(CustomApiException e) {
        return new ResponseEntity<>(new ResponseDto<>(-1, e.getMessage(), e.getHttpStatus()), e.getHttpStatus());
    }
}