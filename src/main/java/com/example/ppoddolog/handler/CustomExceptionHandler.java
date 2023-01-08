package com.example.ppoddolog.handler;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.ppoddolog.config.CustomApiException;
import com.example.ppoddolog.config.CustomException;
import com.example.ppoddolog.util.Script;

@ControllerAdvice
public class CustomExceptionHandler {

    @ExceptionHandler(CustomApiException.class)
    public @ResponseBody ResponseEntity<?> CustomApiException(CustomApiException e) {
        return new ResponseEntity<>(e.getMessage(), e.getHttpStatus());
    }

    @ExceptionHandler(CustomException.class)
    public @ResponseBody String CustomException(Exception e) {
        return Script.back(e.getMessage());
    }
}