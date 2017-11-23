package com.test.service.impl;

import com.test.bean.Users;
import com.test.dao.UsersMapper;
import com.test.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UsersServiceImpl implements UsersService{

    @Resource
    UsersMapper usersMapper;

    @Override
    public List<Users> getAll() {
        List<Users> users = usersMapper.getAll();
        return users;
    }

    @Override
    public List<Users> selectByLike(String like) {
        List<Users> users = usersMapper.selectByLike(like);
        return users;
    }

    //用户保存
    @Override
    public void saveUser(Users users) {
        // TODO Auto-generated method stub
        usersMapper.saveUser(users);
    }

    //检验用户名是否可用
    //返回0为true代表当前用户名可用
    @Override
    public boolean checkUser(String username) {
        // TODO Auto-generated method stub
        if(usersMapper.checkUser(username) != 0){
            return false;
        }else {
            return true;
        }
    }

    //查询用户(通过uid)
    @Override
    public Users getUser(Integer uid) {
        // TODO Auto-generated method stub
        Users users = usersMapper.getUser(uid);
        return users;
    }

    //更新用户
    @Override
    public void updateUser(Users users) {
        // TODO Auto-generated method stub
        usersMapper.updateUser(users);
    }

    //删除用户
    @Override
    public void deleteUser(Integer uid) {
        // TODO Auto-generated method stub
        usersMapper.deleteUser(uid);
    }

    //批量删除用户
    @Override
    public void deleteBatch(String uids) {
        // TODO Auto-generated method stub
        //delete from xxx where uid in(1,2,3)
        usersMapper.deleteBatch(uids);
    }
}
