package com.test.bean;

public class Users {
    private Integer uid;

    private String username;

    private String sex;

    private Integer age;

    private String phone;

    private String email;

    public Users(Integer uid, String username, String sex, Integer age, String phone, String email) {
        this.uid = uid;
        this.username = username;
        this.sex = sex;
        this.age = age;
        this.phone = phone;
        this.email = email;
    }

    public Users() {
        super();
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }
}