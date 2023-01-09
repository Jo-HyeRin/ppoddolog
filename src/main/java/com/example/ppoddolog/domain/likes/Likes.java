package com.example.ppoddolog.domain.likes;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class Likes {
    private Integer likesId;
    private Integer usersId;
    private Integer boardId;
    private Timestamp createdAt;

    public Likes(Integer usersId, Integer boardId) {
        this.usersId = usersId;
        this.boardId = boardId;
    }
}
