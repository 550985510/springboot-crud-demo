package com.test.bean;

import com.test.utils.ExcelResources;
import lombok.Data;

@Data
public class Users {


    private Integer uid;

    private String username;

    private String sex;

    private Integer age;

    private String phone;

    private String email;

    private String birthday;

    @ExcelResources(title="用户id",order=1)
    public Integer getUid() {
        return uid;
    }

    @ExcelResources(title="姓名",order=2)
    public String getUsername() {
        return username;
    }

    @ExcelResources(title="性别",order=3)
    public String getSex() {
        return sex;
    }

    @ExcelResources(title="年龄",order=4)
    public Integer getAge() {
        return age;
    }

    @ExcelResources(title="电话",order=5)
    public String getPhone() {
        return phone;
    }

    @ExcelResources(title="邮箱",order=6)
    public String getEmail() {
        return email;
    }

    @ExcelResources(title="生日",order=7)
    public String getBirthday() {
        return birthday;
    }

    public Users(Integer uid, String username, String sex, Integer age, String phone, String email, String birthday) {
        this.uid = uid;
        this.username = username;
        this.sex = sex;
        this.age = age;
        this.phone = phone;
        this.email = email;
        this.birthday = birthday;
    }
}