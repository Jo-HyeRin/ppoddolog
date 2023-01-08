package com.example.ppoddolog.domain.users;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.ppoddolog.web.dto.admin.UsersListDto;
import com.example.ppoddolog.web.dto.users.AddressDto;
import com.example.ppoddolog.web.dto.users.DetailUsersDto;

public interface UsersDao {

    // 주소 정보 받기
    public AddressDto findByAddress(Integer usersId);

    public Users findById(Integer usersId);

    // 유저상세보기
    public DetailUsersDto findByIdDetail(Integer usersId);

    // 로그인 - username, password로 select
    public Users findByUsernameAndPassword(@Param("username") String username, @Param("password") String password);

    public List<Users> findAll();

    public void insert(Users users);

    public void update(Users users);

    // 비밀번호변경
    public void updatePassword(Users users);

    // 회원탈퇴
    public void leave(Users users);

    public void delete(Users users);

    // 관리자 ----------------------------------------------//
    public List<UsersListDto> findAllActive();

    public List<UsersListDto> findAllStop();

    public List<UsersListDto> findAllInactive();

    public void stop(Users users);

    public void active(Users users);
}
