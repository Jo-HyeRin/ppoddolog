package com.example.ppoddolog.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.ppoddolog.domain.users.Users;
import com.example.ppoddolog.service.BoardService;
import com.example.ppoddolog.service.UsersService;
import com.example.ppoddolog.web.dto.ResponseDto;
import com.example.ppoddolog.web.dto.admin.ListDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AdminController {

    private final UsersService usersService;
    private final BoardService boardService;
    private final HttpSession session;

    @GetMapping("/admin/activeUsersList")
    public String activeUsersList(Model model) {
        List<ListDto> usersList = usersService.활동회원목록();
        model.addAttribute("usersList", usersList);
        return "/admin/activeUsersList";
    }

    @GetMapping("/admin/leaveUsersList")
    public String leaveUsersList(Model model) {
        List<ListDto> usersList = usersService.탈퇴회원목록();
        model.addAttribute("usersList", usersList);
        return "/admin/leaveUsersList";
    }

    @GetMapping("/admin/usersDetail/{usersId}")
    public String detailUsers(@PathVariable Integer usersId, Model model) {
        Users usersPS = usersService.상세보기(usersId);
        model.addAttribute("usersPS", usersPS);
        return "/admin/usersDetail";
    }

    @DeleteMapping("/admin/deleteUsers/{usersId}")
    public @ResponseBody ResponseDto<?> deleteBoard(@PathVariable Integer usersId) {
        usersService.회원영구삭제(usersId);
        return new ResponseDto<>(1, "회원 영구 삭제 성공", null);
    }

}
