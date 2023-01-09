package com.example.ppoddolog.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.ppoddolog.config.CustomApiException;
import com.example.ppoddolog.config.CustomException;
import com.example.ppoddolog.domain.category.Category;
import com.example.ppoddolog.domain.likes.Likes;
import com.example.ppoddolog.domain.users.Users;
import com.example.ppoddolog.service.BoardService;
import com.example.ppoddolog.service.CategoryService;
import com.example.ppoddolog.web.dto.PagingDto;
import com.example.ppoddolog.web.dto.ResponseDto;
import com.example.ppoddolog.web.dto.board.BoardListDto;
import com.example.ppoddolog.web.dto.board.BoardReqDto.SaveDto;
import com.example.ppoddolog.web.dto.board.BoardReqDto.UpdateDto;
import com.example.ppoddolog.web.dto.board.DetailBoardDto;
import com.example.ppoddolog.web.dto.users.SignedDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class BoardController {

    private final BoardService boardService;
    private final CategoryService categoryService;
    private final HttpSession session;

    // 게시글 목록보기
    @GetMapping("/board/users/{usersId}/list")
    public String boardAll(@PathVariable Integer usersId, Integer page, String keyword, Model model) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }

        // 선택할 카테고리 목록 뷰 전달
        List<Category> categoryList = categoryService.카테고리목록();
        model.addAttribute("categoryList", categoryList);

        if (page == null)
            page = 0;
        int startNum = page * 5;

        if (keyword == null || keyword.isEmpty()) {
            List<BoardListDto> boardList = boardService.게시글전체목록보기(startNum);
            PagingDto paging = boardService.게시글페이징(page, null);
            paging.makeBlockInfo(keyword);
            model.addAttribute("boardList", boardList);
            model.addAttribute("paging", paging);
        } else {
            List<BoardListDto> boardList = boardService.검색게시글전체목록보기(startNum, keyword);
            PagingDto paging = boardService.게시글페이징(page, keyword);
            paging.makeBlockInfo(keyword);
            model.addAttribute("boardList", boardList);
            model.addAttribute("paging", paging);
        }
        return "/board/list";
    }

    @GetMapping("/board/list/{categoryId}")
    public @ResponseBody ResponseEntity<?> boardList(@PathVariable Integer categoryId, Integer page, String keyword,
            Model model) {
        // 선택할 카테고리 목록 뷰 전달
        List<Category> categoryList = categoryService.카테고리목록();
        model.addAttribute("categoryList", categoryList);

        if (page == null)
            page = 0;
        int startNum = page * 5;

        if (keyword == null || keyword.isEmpty()) {
            List<BoardListDto> boardList = boardService.게시글목록보기(startNum, categoryId);
            PagingDto paging = boardService.게시글페이징(page, null);
            paging.makeBlockInfo(keyword);
            model.addAttribute("boardList", boardList);
            model.addAttribute("paging", paging);
        } else {
            List<BoardListDto> boardList = boardService.검색게시글목록보기(startNum, keyword, categoryId);
            PagingDto paging = boardService.게시글페이징(page, keyword);
            paging.makeBlockInfo(keyword);
            model.addAttribute("boardList", boardList);
            model.addAttribute("paging", paging);
        }

        return new ResponseEntity<>(new ResponseDto<>(1, "게시글목록 카테고리별 보기 성공", HttpStatus.OK), HttpStatus.OK);

    }

    // 게시글 등록
    @GetMapping("/board/users/{usersId}/saveForm")
    public String saveForm(@PathVariable Integer usersId, Model model) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 뷰 응답
        List<Category> categoryList = categoryService.카테고리목록();
        model.addAttribute("categoryList", categoryList);
        return "/board/saveForm";
    }

    @PostMapping("/board/users/{usersId}/save")
    public @ResponseBody ResponseEntity<?> saveBoard(@RequestPart("file") MultipartFile file,
            @RequestPart("saveDto") SaveDto saveDto, @PathVariable Integer usersId) throws Exception {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomApiException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 이미지 저장
        int pos = file.getOriginalFilename().lastIndexOf('.');
        String extension = file.getOriginalFilename().substring(pos + 1);
        String filePath = "C:\\Users\\1\\Desktop\\workplace\\ppoddolog\\src\\main\\resources\\static\\img";
        String imgSaveName = UUID.randomUUID().toString();
        String imgName = imgSaveName + "." + extension;
        File makeFileFolder = new File(filePath);
        if (!makeFileFolder.exists()) {
            if (!makeFileFolder.mkdir()) {
                throw new Exception("File.mkdir():Fail.");
            }
        }
        File dest = new File(filePath, imgName);
        try {
            Files.copy(file.getInputStream(), dest.toPath());
        } catch (IOException e) {
            e.printStackTrace();
        }
        saveDto.setThumbnail(imgName);
        // 게시글등록
        boardService.게시글등록(usersId, saveDto);
        return new ResponseEntity<>(new ResponseDto<>(1, "게시글등록 성공", HttpStatus.CREATED), HttpStatus.CREATED);
    }

    // 게시글 상세보기
    @GetMapping("/board/users/{usersId}/detail/{boardId}")
    public String detailBoard(@PathVariable Integer usersId, @PathVariable Integer boardId, Model model) {
        DetailBoardDto boardPS = boardService.게시글상세보기(boardId, usersId);
        model.addAttribute("boardPS", boardPS);
        return "/board/detail";
    }

    // 게시글 수정
    @GetMapping("/board/users/{usersId}/updateForm/{boardId}")
    public String updateForm(@PathVariable Integer boardId, @PathVariable Integer usersId, Model model) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 게시글 상세보기
        DetailBoardDto boardPS = boardService.게시글상세보기(boardId, usersId);
        model.addAttribute("boardPS", boardPS);
        List<Category> categoryList = categoryService.카테고리목록();
        model.addAttribute("categoryList", categoryList);
        return "/board/updateForm";
    }

    @PutMapping("/board/users/{usersId}/update/{boardId}")
    public @ResponseBody ResponseEntity<?> updateBoard(@RequestPart("file") MultipartFile file,
            @RequestPart("updateDto") UpdateDto updateDto, @PathVariable Integer usersId,
            @PathVariable Integer boardId) throws Exception {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomApiException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 이미지 저장
        int pos = file.getOriginalFilename().lastIndexOf('.');
        String extension = file.getOriginalFilename().substring(pos + 1);
        String filePath = "C:\\Users\\1\\Desktop\\workplace\\ppoddolog\\src\\main\\resources\\static\\img";
        String imgSaveName = UUID.randomUUID().toString();
        String imgName = imgSaveName + "." + extension;
        File makeFileFolder = new File(filePath);
        if (!makeFileFolder.exists()) {
            if (!makeFileFolder.mkdir()) {
                throw new Exception("File.mkdir():Fail.");
            }
        }
        File dest = new File(filePath, imgName);
        try {
            Files.copy(file.getInputStream(), dest.toPath());
        } catch (IOException e) {
            e.printStackTrace();
        }
        updateDto.setThumbnail(imgName);
        // 게시글수정
        boardService.게시글수정(updateDto, boardId, usersId);
        return new ResponseEntity<>(new ResponseDto<>(1, "게시글수정 성공", HttpStatus.OK), HttpStatus.OK);
    }

    @DeleteMapping("/board/users/{usersId}/delete/{boardId}")
    public @ResponseBody ResponseEntity<?> deleteBoard(@PathVariable Integer usersId,
            @PathVariable Integer boardId) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomApiException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 게시글삭제
        boardService.게시글삭제(boardId);
        return new ResponseEntity<>(new ResponseDto<>(1, "게시글삭제 성공", HttpStatus.OK), HttpStatus.OK);
    }

    // 좋아요 추가
    @PostMapping("/board/{boardId}/likes")
    public @ResponseBody ResponseDto<?> insertLikes(@PathVariable Integer boardId) {
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        Likes likes = new Likes(principal.getUsersId(), boardId);
        boardService.좋아요추가(likes);
        return new ResponseDto<>(1, "좋아요 추가 성공", likes);
    }

    // 좋아요 삭제
    @DeleteMapping("/board/{boardId}/unlikes/{likesId}")
    public @ResponseBody ResponseDto<?> deleteLikes(@PathVariable Integer boardId, @PathVariable Integer likesId) {
        boardService.좋아요삭제(likesId);
        return new ResponseDto<>(1, "좋아요 삭제 성공", null);
    }
}