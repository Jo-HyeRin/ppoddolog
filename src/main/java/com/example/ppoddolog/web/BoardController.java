package com.example.ppoddolog.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.ppoddolog.domain.category.Category;
import com.example.ppoddolog.service.BoardService;
import com.example.ppoddolog.service.CategoryService;
import com.example.ppoddolog.web.dto.ResponseDto;
import com.example.ppoddolog.web.dto.board.BoardReqDto.SaveDto;
import com.example.ppoddolog.web.dto.board.DetailDto;
import com.example.ppoddolog.web.dto.board.ListDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class BoardController {

    private final BoardService boardService;
    private final CategoryService categoryService;
    private final HttpSession session;

    @GetMapping("/board/list")
    public String boardList(Model model) {
        List<ListDto> boardList = boardService.게시글목록보기();
        model.addAttribute("boardList", boardList);
        return "/board/list";
    }

    @GetMapping("/board/saveForm")
    public String saveForm(Model model) {
        List<Category> categoryList = categoryService.카테고리목록();
        model.addAttribute("categoryList", categoryList);
        return "/board/saveForm";
    }

    @PostMapping("/board/users/{usersId}/save")
    public @ResponseBody ResponseDto<?> save(@PathVariable Integer usersId, @RequestBody SaveDto saveDto) {
        boardService.게시글등록(usersId, saveDto);
        return new ResponseDto<>(1, "게시글 등록 성공", null);
    }

    @GetMapping("/board/users/{usersId}/detail/{boardId}")
    public String detail(@PathVariable Integer usersId, @PathVariable Integer boardId, Model model) {
        DetailDto boardPS = boardService.상세보기(boardId);
        model.addAttribute("boardPS", boardPS);
        return "/board/detail";
    }
}