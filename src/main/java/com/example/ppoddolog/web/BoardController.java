package com.example.ppoddolog.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.ppoddolog.service.BoardService;
import com.example.ppoddolog.web.dto.BoardRespDto.ListDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class BoardController {

    private final BoardService boardService;
    private final HttpSession session;

    @GetMapping("/board/list")
    public String boardList(Model model) {
        List<ListDto> boardList = boardService.게시글목록보기();
        model.addAttribute("boardList", boardList);
        return "/board/list";
    }
}
