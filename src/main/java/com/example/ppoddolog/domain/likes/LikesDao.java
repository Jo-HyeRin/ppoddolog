package com.example.ppoddolog.domain.likes;

import java.util.List;

public interface LikesDao {
    public Likes findById(Integer likesId);

    public List<Likes> findAll();

    public void insert(Likes likes);

    public void deleteById(Integer likesId);
}
