package com.example.ppoddolog.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.ppoddolog.service.BoardService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class BoardController {

    private final BoardService boardService;

    @GetMapping("/user/{userId}/board/save")
    public String saveForm() {
        return "/board/saveForm";
    }

}
