package com.example.ppoddolog.domain.board;

import java.util.List;

import com.example.ppoddolog.web.dto.BoardRespDto.ListDto;

public interface BoardDao {

    public Board findById(Integer boardId);

    public List<ListDto> findAll();

    public void insert(Board board);

    public void update(Board board);

    public void delete(Board board);
}
