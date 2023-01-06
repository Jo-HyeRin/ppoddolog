package com.example.ppoddolog.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.ppoddolog.domain.board.BoardDao;
import com.example.ppoddolog.web.dto.board.BoardReqDto.SaveDto;
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
        return boardDao.findById(boardId);
    }

}
