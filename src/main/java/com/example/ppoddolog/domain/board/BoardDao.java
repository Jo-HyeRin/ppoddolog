package com.example.ppoddolog.domain.board;

import java.util.List;

public interface BoardDao {

    public Board findById(Integer boardId);

    public List<Board> findAll();

    public void insert(Board board);

    public void update(Board board);

    public void delete(Board board);
}
