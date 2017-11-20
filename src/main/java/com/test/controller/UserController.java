package com.test.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.test.bean.Msg;
import com.test.bean.Users;
import com.test.service.UsersService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;


@RestController
@RequestMapping
public class UserController {

    @Resource
    private UsersService usersService;

    final Logger logger = LoggerFactory.getLogger(getClass());

    //分页模糊查询用户数据
    @PostMapping("/selectUserByLike")
    public Msg getUserByLike(@RequestParam(value="like")String like, @RequestParam(value="pn",defaultValue="1")Integer pn){
        PageHelper.startPage(pn,5);
        List<Users> users=usersService.selectByLike(like);
        PageInfo page=new PageInfo(users,5);
        return Msg.success().add("pageInfo",page);
    }

    //用户保存
    @PostMapping("/save")
    public Msg saveUser(@RequestBody Users users){
            logger.info(""+users);
            usersService.saveUser(users);
            return Msg.success();
    }
    
}
