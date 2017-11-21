<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script type="text/javascript" src="/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="/js/vue.js"></script>
    <script type="text/javascript" src="/js/vue-resource.js"></script>
    <link href="/js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="/js/bootstrap/js/bootstrap.min.js"></script>
    <link href="/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script src="/js/bootstrap-datetimepicker.min.js"></script>
    <title></title>
</head>
<body>
    <div id="main">
        <div class="container">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-1 control-label">邮箱</label>
                    <div class="col-sm-10">
                        <input type="text" name="username" class="form-control" placeholder="用户名" v-model="userInfo.username" disabled>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">性别</label>
                    <div class="col-sm-10">
                        <label class="radio-inline">
                            <input type="radio" name="sex" value="男" v-model="userInfo.sex" :checked="userInfo.sex === '男'"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="sex" value="女" v-model="userInfo.sex" :checked="userInfo.sex === '女'"> 女
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">邮箱</label>
                    <div class="col-sm-10">
                        <input type="text" name="email" class="form-control" placeholder="邮箱" v-model="userInfo.email" id="email_add_input">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">出生日期</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control form_datetime" id="addtime" name="addtime"  placeholder="请选择您的生日" v-model="userInfo.birthday">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                <label class="col-sm-1 control-label">操作</label>
                    <div class="col-sm-10">
                        <input type="button" name="button" id="button1" value="返回" onclick="history.go(-1)" class="btn">
                        <input type="button" class="btn" id="user_save_btn" value="提交" @click="updateUser(uid)">
                    </div>
                </div>
            </form>
        </div>
    </div>
    <script>
        var app = new Vue({
            el: '#main',
            data: {
                userInfo:{
                    username:'',
                    sex:'',
                    email:'',
                    birthday:''
                },
                uid:${uid},
                user:[]
            },
            created: function () {
                this.query(this.uid);
                console.log(1);
                console.log(this.uid);
            },
            watch:{
                "userInfo.birthday":function () {
                    //console.log(this.userInfo.birthday);
                    $('.form_datetime').datetimepicker({
                        minView: "month", //选择日期后，不会再跳转去选择时分秒
                        language:  'zh-CN',
                        format: 'yyyy-mm-dd',
                        todayBtn:  1,
                        autoclose: 1
                    });
                },
                "userInfo.email":function () {
                    console.log(this.userInfo.email);
                    this.checkEmail();
                }
            },
            methods: {
                query: function (uid) {
                    var self = this;
                    $.ajax({
                        url:"/getUser/"+uid,
                        type:"GET",
                        data:uid,
                        success:function (response) {
                            console.log(response);
                            self.userInfo=response.extend.user;
                        }
                    });
                },
                updateUser: function (uid) {
                    var self = this;
                    self.userInfo.birthday=$("#addtime").val();
                    //将双向绑定的生日付给userInfo
                    $.ajax({
                        url:"/updateUser/"+uid,
                        type:"PUT",
                        contentType:"application/json",
                        data:JSON.stringify(self.userInfo),
                        success:function (response) {
                            if(response.code == 100){
                                alert("更新成功");
                                history.go(-1)
                            }else {
                                alert("操作失败");
                            }
                        }
                    })
                },
                showDatePicker: function () {
                    $('.form_datetime').datetimepicker({
                        minView: "month", //选择日期后，不会再跳转去选择时分秒
                        language:  'zh-CN',
                        format: 'yyyy-mm-dd',
                        todayBtn:  1,
                        autoclose: 1,
                    });
                },
                //显示校验结果提示信息
                show_validate_msg:function (ele,status,msg) {
                    //清除当前元素样式(校验状态)
                    $(ele).parent().removeClass("has-success has-error");

                    if(status == "success"){
                        $(ele).parent().addClass("has-success");
                        $(ele).next("span").text(msg);
                    }else if(status == "error"){
                        $(ele).parent().addClass("has-error");
                        $(ele).next("span").text(msg);
                    }
                },
                checkEmail: function () {
                    var email = $("#email_add_input").val();
                    if (email==""){email="email@qq.com";}//绑定之前数据为空，为其付个默认值
                    var self = this;
                    $.ajax({
                        url: "/checkUserEmail",
                        data: "email=" + email,
                        type: "POST",
                        success: function (response) {
                            console.log(response);
                            if (response.code == 100) {
                                self.show_validate_msg("#email_add_input", "success", "邮箱格式正确");
                                $("#user_save_btn").attr("ajax_va_email", "success");
                            } else {
                                self.show_validate_msg("#email_add_input", "error", response.extend.va_email_msg);
                                $("#user_save_btn").attr("ajax_va_email", "error");
                            }
                        }
                    });
                }
            }
        });
    </script>
</body>
</html>