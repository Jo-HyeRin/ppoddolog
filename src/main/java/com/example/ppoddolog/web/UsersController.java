package com.example.ppoddolog.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.ppoddolog.domain.users.Users;
import com.example.ppoddolog.service.UsersService;
import com.example.ppoddolog.web.dto.ResponseDto;
import com.example.ppoddolog.web.dto.UsersReqDto.JoinDto;
import com.example.ppoddolog.web.dto.UsersReqDto.LoginDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class UsersController {

    private final UsersService usersService;
    private final HttpSession session;

    @GetMapping("/main")
    public String main() {
        return "main";
    }

    @GetMapping("/joinForm")
    public String joinForm() {
        return "/users/joinForm";
    }

    @PostMapping("/join")
    public @ResponseBody ResponseDto<?> join(@RequestBody JoinDto joinDto) {
        usersService.회원가입(joinDto);
        return new ResponseDto<>(1, "회원가입 성공", null);
    }

    @GetMapping("/loginForm")
    public String loginForm() {
        return "/users/loginForm";
    }

    @PostMapping("/login")
    public @ResponseBody ResponseDto<?> login(@RequestBody LoginDto loginDto) {
        Users usersPS = usersService.로그인(loginDto);
        if (usersPS != null) {
            session.setAttribute("principal", usersPS);
            return new ResponseDto<>(1, "로그인 성공", null);
        } else {
            return new ResponseDto<>(-1, "로그인 실패", null);
        }
    }

    @GetMapping("/logout")
    public @ResponseBody ResponseDto<?> logout() {
        session.invalidate();
        return new ResponseDto<>(1, "로그아웃 성공", null);
    }
}
