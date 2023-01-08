package com.example.ppoddolog.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.ppoddolog.config.CustomApiException;
import com.example.ppoddolog.config.CustomException;
import com.example.ppoddolog.domain.users.Users;
import com.example.ppoddolog.domain.users.UsersDao;
import com.example.ppoddolog.util.SHA256;
import com.example.ppoddolog.web.dto.admin.UsersListDto;
import com.example.ppoddolog.web.dto.users.AddressDto;
import com.example.ppoddolog.web.dto.users.DetailUsersDto;
import com.example.ppoddolog.web.dto.users.SignedDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.JoinDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.LoginDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.PasswordDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.UpdateDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UsersService {

    private final UsersDao usersDao;
    private final SHA256 sha256;

    // 주소 정보 받기
    public AddressDto 주소정보(Integer usersId) {
        return usersDao.findByAddress(usersId);
    }

    // 아이디 중복체크
    public Integer 유저네임중복체크(String username) {
        Integer checkUsersId = usersDao.findByUsername(username);
        return checkUsersId;
    }

    @Transactional
    public void 회원가입(JoinDto joinDto) {
        String encPassword = sha256.encrypt(joinDto.getPassword());
        joinDto.setPassword(encPassword);
        usersDao.insert(joinDto.toEntity());
    }

    @Transactional
    public SignedDto 로그인(LoginDto loginDto) {
        String username = loginDto.getUsername();
        String password = sha256.encrypt(loginDto.getPassword());
        Users usersPS = usersDao.findByUsernameAndPassword(username, password);
        if (usersPS == null)
            return null;
        SignedDto principal = new SignedDto(usersPS.getUsersId(), usersPS.getUsername(), usersPS.getRole(),
                usersPS.getState());
        return principal;
    }

    public DetailUsersDto 상세보기(Integer usersId) {
        Users usersPS = usersDao.findById(usersId);
        if (usersPS.equals(null)) {
            throw new CustomException("없는 회원의 상세보기를 요청했습니다.", HttpStatus.BAD_REQUEST);
        }
        if (usersPS.getUsersId() != usersId) {
            throw new CustomException("본인 정보가 아닙니다.", HttpStatus.BAD_REQUEST);
        }
        return usersDao.findByIdDetail(usersId);
    }

    @Transactional
    public Users 유저수정(UpdateDto updateDto, Integer usersId) {
        Users usersPS = usersDao.findById(usersId);
        if (usersPS.getUsersId() != usersId) {
            throw new CustomApiException("본인이 아닙니다.", HttpStatus.BAD_REQUEST);
        }
        usersPS.updateUsers(updateDto);
        usersDao.update(usersPS);
        return usersPS;
    }

    @Transactional
    public Users 비밀번호변경(PasswordDto passwordDto, Integer usersId) {
        Users usersPS = usersDao.findById(usersId);
        if (usersPS.getUsersId() != usersId) {
            throw new CustomApiException("본인이 아니므로 비밀번호를 바꿀 수 없습니다.", HttpStatus.BAD_REQUEST);
        }
        if (sha256.encrypt(usersPS.getPassword()) != passwordDto.getPasswordNow()) {
            throw new CustomApiException("현재 비밀번호와 같지 않습니다", HttpStatus.BAD_REQUEST);
        }
        // 새 비밀번호로 변경
        passwordDto.setPassword(sha256.encrypt(passwordDto.getPassword()));
        usersPS.updatePassword(passwordDto);
        usersDao.updatePassword(usersPS);
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
    public List<UsersListDto> 활동회원목록(Integer adminId) {
        return usersDao.findAllActive();
    }

    public List<UsersListDto> 정지회원목록(Integer adminId) {
        return usersDao.findAllStop();
    }

    public List<UsersListDto> 탈퇴회원목록(Integer adminId) {
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