package com.test.service;

import com.test.bean.Users;

import java.util.List;

public interface UsersService {

     List<Users> getAll();


     List<Users> selectByLike(String like);

    //用户保存
     void saveUser(Users users);

    //检验用户名是否可用
    //返回0为true代表当前用户名可用
     boolean checkUser(String username);

    //查询用户(通过uid)
     Users getUser(Integer uid);

    //更新用户
     void updateUser(Users users);

    //删除用户
     void deleteUser(Integer uid);

    //批量删除用户
     void deleteBatch(String uids);
}
