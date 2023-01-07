package com.example.ppoddolog.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.ppoddolog.service.BoardService;
import com.example.ppoddolog.service.UsersService;
import com.example.ppoddolog.web.dto.ResponseDto;
import com.example.ppoddolog.web.dto.admin.UsersListDto;
import com.example.ppoddolog.web.dto.users.DetailUsersDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AdminController {

    private final UsersService usersService;
    private final BoardService boardService;
    private final HttpSession session;

    @GetMapping("/admin/activeUsersList")
    public String activeUsersList(Model model) {
        List<UsersListDto> usersList = usersService.활동회원목록();
        model.addAttribute("usersList", usersList);
        return "/admin/activeUsersList";
    }

    @GetMapping("/admin/stopUsersList")
    public String stopUsersList(Model model) {
        List<UsersListDto> usersList = usersService.정지회원목록();
        model.addAttribute("usersList", usersList);
        return "/admin/stopUsersList";
    }

    @GetMapping("/admin/leaveUsersList")
    public String leaveUsersList(Model model) {
        List<UsersListDto> usersList = usersService.탈퇴회원목록();
        model.addAttribute("usersList", usersList);
        return "/admin/leaveUsersList";
    }

    @GetMapping("/admin/detailUsers/{usersId}")
    public String detailUsers(@PathVariable Integer usersId, Model model) {
        DetailUsersDto usersPS = usersService.상세보기(usersId);
        model.addAttribute("usersPS", usersPS);
        return "/admin/detailUsers";
    }

    @PutMapping("/admin/stopUsers/{usersId}")
    public @ResponseBody ResponseDto<?> stopUsers(@PathVariable Integer usersId) {
        usersService.회원정지(usersId);
        return new ResponseDto<>(1, "회원 정지 성공", null);
    }

    @PutMapping("/admin/activeUsers/{usersId}")
    public @ResponseBody ResponseDto<?> activeUsers(@PathVariable Integer usersId) {
        usersService.회원정지해제(usersId);
        return new ResponseDto<>(1, "회원 정지 해제 성공", null);
    }

    @DeleteMapping("/admin/deleteUsers/{usersId}")
    public @ResponseBody ResponseDto<?> deleteUsers(@PathVariable Integer usersId) {
        usersService.회원영구삭제(usersId);
        return new ResponseDto<>(1, "회원 영구 삭제 성공", null);
    }

}
