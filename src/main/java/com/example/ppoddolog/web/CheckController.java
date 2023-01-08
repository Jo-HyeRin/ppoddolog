package com.example.ppoddolog.web;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.ppoddolog.config.CustomApiException;
import com.example.ppoddolog.service.UsersService;
import com.example.ppoddolog.web.dto.ResponseDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class CheckController {

    private final UsersService usersService;

    // 아이디 중복체크
    @GetMapping("/checkUsername/{username}")
    public @ResponseBody ResponseDto<Boolean> usernameSameCheck(@PathVariable String username) {
        if (username == null || username == "") {
            throw new CustomApiException("아이디를 입력하세요", HttpStatus.BAD_REQUEST);
        }
        boolean checkUsername = usersService.유저네임중복체크(username);
        if (checkUsername == true) {
            throw new CustomApiException("중복입니다. 다른 아이디 입력하세요.", HttpStatus.FORBIDDEN);
        } else {
            return new ResponseDto<>(1, "중복 없음 사용하셔도 좋습니다.", checkUsername);
        }
    }

    // 닉네임 중복체크
    @GetMapping("/checkNickname/{nickname}")
    public @ResponseBody ResponseDto<Boolean> nicknameSameCheck(@PathVariable String nickname) {
        if (nickname == null || nickname == "") {
            throw new CustomApiException("닉네임을 입력하세요", HttpStatus.BAD_REQUEST);
        }
        boolean checkNickname = usersService.닉네임중복체크(nickname);
        if (checkNickname == true) {
            throw new CustomApiException("중복입니다. 다른 닉네임 입력하세요.", HttpStatus.FORBIDDEN);
        } else {
            return new ResponseDto<>(1, "중복 없음 사용하셔도 좋습니다.", checkNickname);
        }
    }

    // 이메일 중복체크
    @GetMapping("/checkEmail/{email}")
    public @ResponseBody ResponseDto<Boolean> emailSameCheck(@PathVariable String email) {
        if (email == null || email == "") {
            throw new CustomApiException("이메일을 입력하세요", HttpStatus.BAD_REQUEST);
        }
        boolean checkEmail = usersService.이메일중복체크(email);
        if (checkEmail == true) {
            throw new CustomApiException("중복입니다. 다른 이메일 입력하세요.", HttpStatus.FORBIDDEN);
        } else {
            return new ResponseDto<>(1, "중복 없음 사용하셔도 좋습니다.", checkEmail);
        }
    }

    // 연락처 중복체크
    @GetMapping("/checkPhone/{phone}")
    public @ResponseBody ResponseDto<Boolean> phoneSameCheck(@PathVariable String phone) {
        if (phone == null || phone == "") {
            throw new CustomApiException("연락처를 입력하세요", HttpStatus.BAD_REQUEST);
        }
        boolean checkPhone = usersService.연락처중복체크(phone);
        if (checkPhone == true) {
            throw new CustomApiException("중복입니다. 다른 연락처 입력하세요.", HttpStatus.FORBIDDEN);
        } else {
            return new ResponseDto<>(1, "중복 없음 사용하셔도 좋습니다.", checkPhone);
        }
    }

}
