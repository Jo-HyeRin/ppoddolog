package com.example.ppoddolog.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.ppoddolog.domain.board.BoardDao;
import com.example.ppoddolog.web.dto.BoardRespDto.ListDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BoardService {

    private final BoardDao boardDao;

    public List<ListDto> 게시글목록보기() {
        return boardDao.findAll();
    }

}
