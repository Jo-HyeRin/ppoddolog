package com.example.ppoddolog.domain.users;

import java.util.List;

public interface UsersDao {

    public Users findById(Integer usersId);

    public List<Users> findAll();

    public void insert(Users users);

    public void update(Users users);

    public void delete(Users users);
}
