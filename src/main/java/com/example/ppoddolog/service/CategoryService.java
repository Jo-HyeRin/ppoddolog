package com.example.ppoddolog.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.ppoddolog.domain.category.Category;
import com.example.ppoddolog.domain.category.CategoryDao;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CategoryService {

    private final CategoryDao categoryDao;

    public List<Category> 카테고리목록() {
        return categoryDao.findAll();
    }
}
