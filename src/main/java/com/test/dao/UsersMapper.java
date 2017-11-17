package com.test.dao;

import com.test.bean.Users;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UsersMapper {

    List<Users> selectByLike(String like);

    List<Users> getAll();

    Integer checkUser(String username);

    void deleteBatch(String uids);

    void saveUser(Users users);

    void deleteUser(Integer uid);

    void updateUser(Users users);

    Users getUser(Integer uid);
}