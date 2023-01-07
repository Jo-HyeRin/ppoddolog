package com.example.ppoddolog.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.ppoddolog.domain.users.Users;
import com.example.ppoddolog.domain.users.UsersDao;
import com.example.ppoddolog.web.dto.UsersReqDto.JoinDto;
import com.example.ppoddolog.web.dto.UsersReqDto.LoginDto;
import com.example.ppoddolog.web.dto.UsersReqDto.UpdateDto;
import com.example.ppoddolog.web.dto.UsersRespDto.SignedDto;

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
    public SignedDto 로그인(LoginDto loginDto) {
        String username = loginDto.getUsername();
        String password = loginDto.getPassword();
        Users usersPS = usersDao.findByUsernameAndPassword(username, password);
        if (usersPS == null)
            return null;
        SignedDto principal = new SignedDto(usersPS.getUsersId(), usersPS.getUsername());
        return principal;
    }

    public Users 상세보기(Integer usersId) {
        return usersDao.findById(usersId);
    }

    @Transactional
    public Users 유저수정(UpdateDto updateDto, Integer usersId) {
        Users usersPS = usersDao.findById(usersId);
        usersPS.updateUsers(updateDto);
        usersDao.update(usersPS);
        return usersPS;
    }

    @Transactional
    public Users 유저탈퇴(Integer usersId) {
        Users usersPS = usersDao.findById(usersId);
        usersPS.leaveUsers();
        usersDao.leave(usersPS);
        return usersPS;
    }
}