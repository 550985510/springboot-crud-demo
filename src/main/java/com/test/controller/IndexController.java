package com.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

    @RequestMapping("/index")
    public String index(ModelMap map){
        map.addAttribute("name","tangdou");
        return "index";
    }

    @RequestMapping("/index2")
    public String index(){
        return "index2";
    }
}
