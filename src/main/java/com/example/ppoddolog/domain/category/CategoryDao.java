package com.example.ppoddolog.domain.category;

import java.util.List;

public interface CategoryDao {

    public Category findById(Integer categotyId);

    public List<Category> findAll();

    public void insert(Category category);

    public void update(Category category);

    public void delete(Category category);
}