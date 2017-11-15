package com.test;

import com.github.pagehelper.PageHelper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;

import java.util.Properties;

@ComponentScan(basePackages = {"com.test.controller","com.test.service"})
@MapperScan(basePackages = "com.test.dao")
@EnableAutoConfiguration
public class App extends SpringBootServletInitializer {

    //war包发布到tomcat需要增加SpringBootServletInitializer子类，并覆盖configure方法或直接继承后覆写
    @Override
    protected SpringApplicationBuilder configure(
            SpringApplicationBuilder application) {
        return application.sources(App.class);
    }

    //配置mybatis的分页插件pageHelper
      @Bean
      public PageHelper pageHelper(){
                 PageHelper pageHelper = new PageHelper();
                 Properties properties = new Properties();
                 properties.setProperty("offsetAsPageNum","true");
                 properties.setProperty("rowBoundsWithCount","true");
                 properties.setProperty("reasonable","false");
                 properties.setProperty("dialect","mysql");    //配置mysql数据库的方言
                 pageHelper.setProperties(properties);
                 return pageHelper;
             }

    public static void main(String[] args){
        SpringApplication.run(com.test.App.class,args);
    }
}