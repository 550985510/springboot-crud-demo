package com.test.service;

import com.test.bean.Users;
import com.test.bean.UsersExample;
import com.test.dao.UsersMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UsersService {

    @Autowired
    UsersMapper usersMapper;

    @Transactional
    public List<Users> getAll() {
        List<Users> users = usersMapper.selectByExample(null);
        return users;
    }

    @Transactional
    public List<Users> selectByLike(String like) {
        List<Users> users = usersMapper.selectByLike(like);
        return users;
    }

    //用户保存
    @Transactional
    public void saveUser(Users users) {
        // TODO Auto-generated method stub
        usersMapper.insertSelective(users);
    }

    //检验用户名是否可用
    //返回0为true代表当前用户名可用
    @Transactional
    public boolean checkUser(String username) {
        // TODO Auto-generated method stub
        UsersExample example = new UsersExample();
        UsersExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(username);
        long count = usersMapper.countByExample(example);
        return count == 0;
    }



    //查询用户(通过uid)
    @Transactional
    public Users getUser(Integer uid) {
        // TODO Auto-generated method stub
        Users users = usersMapper.selectByPrimaryKey(uid);
        return users;
    }

    //更新用户
    @Transactional
    public void updateUser(Users users) {
        // TODO Auto-generated method stub
        usersMapper.updateByPrimaryKeySelective(users);
    }

    //删除用户
    @Transactional
    public void deleteUser(Integer uid) {
        // TODO Auto-generated method stub
        usersMapper.deleteByPrimaryKey(uid);
    }

    //批量删除用户
    @Transactional
    public void deleteBatch(List<Integer> uids) {
        // TODO Auto-generated method stub
        UsersExample example = new UsersExample();
        UsersExample.Criteria criteria = example.createCriteria();
        //delete from xxx where uid in(1,2,3)
        criteria.andUidIn(uids);
        usersMapper.deleteByExample(example);
    }
}
