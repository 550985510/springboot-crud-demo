package com.test.mapper;

import com.test.bean.Users;

import java.util.List;

public interface UsersMapper {

    List<Users> selectByLike(String like);

    List<Users> getAll();

    Integer checkUser(String username);

    void saveUser(Users users);

    void deleteUser(Integer uid);

    void updateUser(Users users);

    Users getUser(Integer uid);
}