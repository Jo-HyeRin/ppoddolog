package com.example.ppoddolog.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.ppoddolog.domain.users.Users;
import com.example.ppoddolog.service.UsersService;
import com.example.ppoddolog.web.dto.ResponseDto;
import com.example.ppoddolog.web.dto.users.DetailUsersDto;
import com.example.ppoddolog.web.dto.users.SignedDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.JoinDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.LoginDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.PasswordDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.UpdateDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class UsersController {

    private final UsersService usersService;
    private final HttpSession session;

    @GetMapping({ "/", "/main" })
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
        SignedDto principal = usersService.로그인(loginDto);
        if (principal == null) {
            return new ResponseDto<>(-1, "로그인 실패", null);
        }
        session.setAttribute("principal", principal);
        return new ResponseDto<>(1, "로그인 성공", null);
    }

    @GetMapping("/logout")
    public String logout() {
        session.invalidate();
        return "redirect:/main";
    }

    @GetMapping("/users/{usersId}/detail")
    public String detailUsers(@PathVariable Integer usersId, Model model) {
        DetailUsersDto usersPS = usersService.상세보기(usersId);
        model.addAttribute("usersPS", usersPS);
        return "/users/detail";
    }

    @GetMapping("/users/{usersId}/update")
    public String updateForm(@PathVariable Integer usersId, Model model) {
        DetailUsersDto usersPS = usersService.상세보기(usersId);
        model.addAttribute("usersPS", usersPS);
        return "/users/update";
    }

    @PutMapping("/users/{usersId}/update")
    public @ResponseBody ResponseDto<?> updateUsers(@RequestBody UpdateDto updateDto, @PathVariable Integer usersId) {
        usersService.유저수정(updateDto, usersId);
        return new ResponseDto<>(1, "내 정보 수정 성공", null);
    }

    @GetMapping("/users/{usersId}/updatePassword")
    public String updatePasswordForm(@PathVariable Integer usersId, Model model) {
        return "/users/updatePassword";
    }

    @PutMapping("/users/{usersId}/updatePassword")
    public @ResponseBody ResponseDto<?> updatePassword(@RequestBody PasswordDto passwordDto,
            @PathVariable Integer usersId) {
        usersService.비밀번호변경(passwordDto, usersId);
        return new ResponseDto<>(1, "비밀번호 변경 성공", null);
    }

    @PutMapping("/users/{usersId}/leave")
    public @ResponseBody ResponseDto<?> leaveUsers(@PathVariable Integer usersId) {
        usersService.유저비활성화(usersId);
        session.invalidate();
        return new ResponseDto<>(1, "유저탈퇴 성공", null);
    }

}
