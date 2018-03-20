package com.test;

import com.test.bean.Users;
import com.test.utils.ExcelUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;

@SpringBootTest
@RunWith(SpringRunner.class)
public class ExportExcelTest {

    @Test
    public void test() throws Exception {
        Date today = new Date();//获取当前日期
        List<Users> list = new ArrayList<Users>();
        list.add(new Users(1,"张三","男",18,"13839256729","550985510@163.com","1996-01-01"));
        list.add(new Users(2,"张三","男",18,"13839256729","550985510@163.com","1996-01-01"));
        list.add(new Users(3,"张三","男",18,"13839256729","550985510@163.com","1996-01-01"));

        Map<String, String> map = new HashMap<String, String>();
        map.put("total", list.size()+" 条");


        ExcelUtil.getInstance().exportObj2ExcelByTemplate(map, "web-info-template.xls", new FileOutputStream("C:/Users/木叶丸/Desktop/out.xls"),
                list, Users.class, true);
    }
}
