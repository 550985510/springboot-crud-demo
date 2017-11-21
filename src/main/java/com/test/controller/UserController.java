package com.test.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.test.bean.Msg;
import com.test.bean.Users;
import com.test.service.UsersService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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

    //校验邮箱是否可用
    @PostMapping("/checkUserEmail")
    public Msg checkEmail(@RequestParam("email")String email){
        //判断邮箱是否是合法的表达式
        String regEmail = "^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
        if(!email.matches(regEmail)){
            return Msg.fail().add("va_email_msg","邮箱格式不正确");
        }else{
            return Msg.success();
        }
    }

    //用户保存
    @PostMapping("/save")
    public Msg saveUser(@RequestBody Users users){
            logger.info(""+users);
            usersService.saveUser(users);
            return Msg.success();
    }

    //查询用户信息
    @GetMapping("/getUser/{uid}")
    public Msg getUser(@PathVariable("uid")Integer uid){
        Users users = usersService.getUser(uid);
        return Msg.success().add("user", users);
    }

    //更新用户
    @PutMapping("/updateUser/{uid}")
    public Msg updateUser(@RequestBody Users users){
            usersService.updateUser(users);
            return Msg.success();
    }

    //通过Uid删除用户
    //批量删除uid以-间隔
    @DeleteMapping("/userDelete/{uids}")
    public Msg deleteUserByUid(@PathVariable("uids")String uids){
        //批量删除
        if(uids.contains(",")){
            List<Integer> del_uids = new ArrayList<Integer>();
            String[] str_uids = uids.split(",");
            //组装uid的集合
            for(String string:str_uids){
                usersService.deleteUser(Integer.parseInt(string));
            }
        }else{
            Integer uid = Integer.parseInt(uids);
            usersService.deleteUser(uid);
        }
        return Msg.success();
    }
}
