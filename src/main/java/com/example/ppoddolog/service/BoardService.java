package com.example.ppoddolog.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.ppoddolog.domain.board.Board;
import com.example.ppoddolog.domain.board.BoardDao;
import com.example.ppoddolog.web.dto.board.BoardReqDto.SaveDto;
import com.example.ppoddolog.web.dto.board.BoardReqDto.UpdateDto;
import com.example.ppoddolog.web.dto.board.DetailDto;
import com.example.ppoddolog.web.dto.board.ListDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BoardService {

    private final BoardDao boardDao;

    public List<ListDto> 게시글목록보기() {
        return boardDao.findAll();
    }

    @Transactional
    public void 게시글등록(Integer usersId, SaveDto saveDto) {
        boardDao.insert(saveDto.toEntity());
    }

    public DetailDto 상세보기(Integer boardId) {
        return boardDao.findByIdDetail(boardId);
    }

    @Transactional
    public Board 게시글수정(UpdateDto updateDto, Integer boardId) {
        Board boardPS = boardDao.findById(boardId);
        boardPS.updateBoard(updateDto);
        boardDao.update(boardPS);
        return boardPS;
    }
}
