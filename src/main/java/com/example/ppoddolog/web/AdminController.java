package com.example.ppoddolog.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.ppoddolog.domain.users.Users;
import com.example.ppoddolog.service.BoardService;
import com.example.ppoddolog.service.UsersService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AdminController {

    private final UsersService usersService;
    private final BoardService boardService;
    private final HttpSession session;

    @GetMapping("/admin/usersList")
    public String boardList(Model model) {
        List<Users> usersList = usersService.활동회원목록();
        model.addAttribute("usersList", usersList);
        return "/admin/usersList";
    }

}
