package com.test.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

//拦截异常
@ControllerAdvice
public class GlobalExceptionHandler {

    //@ExceptionHandler(RuntimeException.class)
    //拦截返回json结果
    //@ResponseBody
    public Map<String,Object> exceptionHandler(){
        Map<String,Object> result = new HashMap<String,Object>();
        result.put("code","500");
        result.put("msg","系统错误请稍后重试");
        return result;
    }

}
