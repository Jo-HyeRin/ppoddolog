package com.example.ppoddolog.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.ppoddolog.domain.users.Users;
import com.example.ppoddolog.domain.users.UsersDao;
import com.example.ppoddolog.web.dto.admin.UsersListDto;
import com.example.ppoddolog.web.dto.users.DetailUsersDto;
import com.example.ppoddolog.web.dto.users.SignedDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.JoinDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.LoginDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.UpdateDto;

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
        SignedDto principal = new SignedDto(usersPS.getUsersId(), usersPS.getUsername(), usersPS.getRole(),
                usersPS.getState());
        return principal;
    }

    public DetailUsersDto 상세보기(Integer usersId) {
        return usersDao.findByIdDetail(usersId);
    }

    @Transactional
    public Users 유저수정(UpdateDto updateDto, Integer usersId) {
        Users usersPS = usersDao.findById(usersId);
        usersPS.updateUsers(updateDto);
        usersDao.update(usersPS);
        return usersPS;
    }

    @Transactional
    public Users 유저비활성화(Integer usersId) {
        Users usersPS = usersDao.findById(usersId);
        usersPS.leaveUsers();
        usersDao.leave(usersPS);
        return usersPS;
    }

    // 관리자페이지---------------------------------------------------//
    public List<UsersListDto> 활동회원목록() {
        return usersDao.findAllActive();
    }

    public List<UsersListDto> 정지회원목록() {
        return usersDao.findAllStop();
    }

    public List<UsersListDto> 탈퇴회원목록() {
        return usersDao.findAllInactive();
    }

    @Transactional
    public Users 회원정지(Integer usersId) {
        Users usersPS = usersDao.findById(usersId);
        usersPS.stopUsers();
        usersDao.stop(usersPS);
        return usersPS;
    }

    @Transactional
    public Users 회원정지해제(Integer usersId) {
        Users usersPS = usersDao.findById(usersId);
        usersPS.activeUsers();
        usersDao.active(usersPS);
        return usersPS;
    }

    public void 회원영구삭제(Integer usersId) {
        Users usersPS = usersDao.findById(usersId);
        usersDao.delete(usersPS);
    }
}