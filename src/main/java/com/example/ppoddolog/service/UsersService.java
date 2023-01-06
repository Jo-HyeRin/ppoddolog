package com.example.ppoddolog.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.ppoddolog.domain.users.Users;
import com.example.ppoddolog.domain.users.UsersDao;
import com.example.ppoddolog.web.dto.UsersReqDto.JoinDto;
import com.example.ppoddolog.web.dto.UsersReqDto.LoginDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UsersService {

    private final UsersDao usersDao;

    @Transactional
    public void 회원가입(JoinDto joinDto) {
        usersDao.insert(joinDto.toEntity());
    }

    @Transactional
    public Users 로그인(LoginDto loginDto) {
        Users users = usersDao.login(loginDto.getUsername(), loginDto.getPassword());
        return users;
    }
}
