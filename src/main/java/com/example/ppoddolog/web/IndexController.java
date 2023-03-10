package com.example.ppoddolog.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class IndexController {

    @GetMapping("/index")
    public String index() {
        return "index";
    }
}
