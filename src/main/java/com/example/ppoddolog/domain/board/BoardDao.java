package com.example.ppoddolog.domain.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.ppoddolog.web.dto.PagingDto;
import com.example.ppoddolog.web.dto.board.BoardListDto;
import com.example.ppoddolog.web.dto.board.DetailBoardDto;

public interface BoardDao {

    public Board findById(Integer boardId);

    public DetailBoardDto findByIdDetail(Integer boardId);

    public List<BoardListDto> findAll(int startNum);

    public List<BoardListDto> findAllSearch(@Param("startNum") int startNum, @Param("keyword") String keyword);

    public void insert(Board board);

    public void update(Board board);

    public void delete(Board board);

    // 페이징
    public PagingDto boardPaging(@Param("page") Integer page, @Param("keyword") String keyword);

    // 게시글목록보기
    public List<BoardListDto> findAllBoard(@Param("startNum") int startNum, @Param("categoryId") Integer categoryId);

    // 검색게시글목록보기
    public List<BoardListDto> findAllBoardSearch(@Param("startNum") int startNum, @Param("keyword") String keyword,
            @Param("categoryId") Integer categoryId);
}
