package com.example.ppoddolog.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.ppoddolog.config.CustomApiException;
import com.example.ppoddolog.domain.board.Board;
import com.example.ppoddolog.domain.board.BoardDao;
import com.example.ppoddolog.domain.likes.Likes;
import com.example.ppoddolog.domain.likes.LikesDao;
import com.example.ppoddolog.web.dto.PagingDto;
import com.example.ppoddolog.web.dto.board.BoardListDto;
import com.example.ppoddolog.web.dto.board.BoardReqDto.SaveDto;
import com.example.ppoddolog.web.dto.board.BoardReqDto.UpdateDto;
import com.example.ppoddolog.web.dto.board.DetailBoardDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BoardService {

    private final BoardDao boardDao;
    private final LikesDao likesDao;

    // 페이징
    public PagingDto 게시글페이징(Integer page, String keyword) {
        return boardDao.boardPaging(page, keyword);
    }

    // 게시글전체목록보기
    public List<BoardListDto> 게시글전체목록보기(int startNum) {
        return boardDao.findAll(startNum);
    }

    // 게시글전체목록보기
    public List<BoardListDto> 검색게시글전체목록보기(int startNum, String keyword) {
        return boardDao.findAllSearch(startNum, keyword);
    }

    // 게시글목록보기
    public List<BoardListDto> 게시글목록보기(int startNum, Integer id) {
        return boardDao.findAllBoard(startNum, id);
    }

    // 검색게시글목록보기
    public List<BoardListDto> 검색게시글목록보기(int startNum, String keyword, Integer id) {
        return boardDao.findAllBoardSearch(startNum, keyword, id);
    }

    // 게시글쓰기
    @Transactional
    public void 게시글등록(Integer usersId, SaveDto saveDto) {
        boardDao.insert(saveDto.toEntity());
    }

    // 게시글상세보기
    public DetailBoardDto 게시글상세보기(Integer boardId, Integer usersId) {
        return boardDao.findByIdDetail(boardId, usersId);
    }

    // 게시글수정
    @Transactional
    public Board 게시글수정(UpdateDto updateDto, Integer boardId, Integer usersId) {
        Board boardPS = boardDao.findById(boardId);
        if (boardPS == null) {
            throw new CustomApiException("게시글이 없습니다.", HttpStatus.BAD_REQUEST);
        }
        if (usersId != boardPS.getUsersId()) {
            throw new CustomApiException("당신이 작성한 글이 아닙니다.", HttpStatus.BAD_REQUEST);
        }
        boardPS.updateBoard(updateDto);
        boardDao.update(boardPS);
        return boardPS;
    }

    // 게시글삭제
    public void 게시글삭제(Integer boardId) {
        Board boardPS = boardDao.findById(boardId);
        boardDao.delete(boardPS);
    }

    // 좋아요추가
    public Likes 좋아요추가(Likes likes) {
        likesDao.insert(likes);
        return likes;
    }

    // 좋아요삭제
    public void 좋아요삭제(Integer likesId) {
        likesDao.deleteById(likesId);
    }
}
