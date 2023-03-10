package com.example.ppoddolog.domain.users;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface UsersDao {

    public Users findById(Integer usersId);

    public Users login(@Param("username") String username, @Param("password") String password);

    public List<Users> findAll();

    public void insert(Users users);

    public void update(Users users);

    public void delete(Users users);
}
