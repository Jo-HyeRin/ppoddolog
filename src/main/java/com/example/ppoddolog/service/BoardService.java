package com.example.ppoddolog.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.ppoddolog.domain.board.BoardDao;
import com.example.ppoddolog.web.dto.BoardReqDto.SaveDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BoardService {

    private final BoardDao boardDao;

    @Transactional
    public void 게시글등록(SaveDto saveDto) {
        boardDao.insert(saveDto.toEntity());
    }

}
