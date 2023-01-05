package com.example.ppoddolog.domain.category;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class Category {
    private Integer categoryId;
    private String categoryName;
    private Timestamp updatedAt;
    private Timestamp createdAt;
}
