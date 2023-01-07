package com.example.ppoddolog.domain.board;

import java.util.List;

import com.example.ppoddolog.web.dto.board.DetailBoardDto;
import com.example.ppoddolog.web.dto.board.BoardListDto;

public interface BoardDao {

    public Board findById(Integer boardId);

    public DetailBoardDto findByIdDetail(Integer boardId);

    public List<BoardListDto> findAll();

    public void insert(Board board);

    public void update(Board board);

    public void delete(Board board);
}
