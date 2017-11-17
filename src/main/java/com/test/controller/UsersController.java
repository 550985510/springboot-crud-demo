package com.test.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.test.bean.Msg;
import com.test.bean.Users;
import com.test.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class UsersController {

    @Autowired
    UsersService usersService;


    @RequestMapping("/users")
    @ResponseBody
    public Msg getUsers(@RequestParam(value="pn",defaultValue="1")Integer pn){
        PageHelper.startPage(pn,5);
        List<Users> users=usersService.getAll();
        PageInfo page=new PageInfo(users,5);
        return Msg.success().add("pageInfo",page);
    }

    //分页模糊查询用户数据
    @RequestMapping("/selectUsersByLike")
    @ResponseBody
    public Msg getUsersByLike(@RequestParam(value="like")String like,@RequestParam(value="pn",defaultValue="1")Integer pn){
        PageHelper.startPage(pn,5);
        List<Users> users=usersService.selectByLike(like);
        PageInfo page=new PageInfo(users,5);
        return Msg.success().add("pageInfo",page);
    }

    //通过Uid删除用户
    //批量删除uid以-间隔
    @RequestMapping(value="/user/{uids}",method= RequestMethod.DELETE)
    @ResponseBody
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


    //更新用户
    @RequestMapping(value="/user/{uid}",method=RequestMethod.PUT)
    @ResponseBody
    public Msg updateUser(@Valid Users users, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<String,Object>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError : errors){
                //封装错误字段和错误信息
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else{
            usersService.updateUser(users);
            return Msg.success();
        }
    }

    //查询用户信息
    @RequestMapping(value="/user/{uid}",method=RequestMethod.GET)
    @ResponseBody
    public Msg getUser(@PathVariable("uid")Integer uid){

        Users users = usersService.getUser(uid);
        return Msg.success().add("user", users);
    }


    //校验用户名是否可用
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("username")String username){
        //先判断用户名是否是合法的表达式
        String regUserName = "^[\u4e00-\u9fa5_a-zA-Z0-9_]{2,16}$";
        if(!username.matches(regUserName)){
            return Msg.fail().add("va_username_msg","用户名不合法，请输入2-16位英文字母、汉字、数字或下划线");
        };

        //校验数据库用户名是否存在
        boolean checkUser = usersService.checkUser(username);
        if(checkUser){
            return Msg.success();
        }else{
            return Msg.fail().add("va_username_msg","用户名已存在");
        }
    }



    //校验邮箱是否可用
    @RequestMapping("/checkEmail")
    @ResponseBody
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
    //JSR303校验 导入Hibernate-Validator
    @RequestMapping(value="/user",method=RequestMethod.POST)
    @ResponseBody
    public Msg saveUser(@Valid Users users,BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<String,Object>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError : errors){
                //封装错误字段和错误信息
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else{
            usersService.saveUser(users);
            return Msg.success();
        }
    }

}
