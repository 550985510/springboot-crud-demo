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
                        <input type="text" name="email" class="form-control" placeholder="邮箱" v-model="userInfo.email">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">出生日期</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control form_datetime" id="addtime" name="addtime"  placeholder="请选择您的生日" v-model="userInfo.birthday" value="user.birthday">
                    </div>
                </div>
                <div class="form-group">
                <label class="col-sm-1 control-label">操作</label>
                    <div class="col-sm-10">
                        <input type="button" name="button" id="button1" value="返回" onclick="history.go(-1)" class="btn">
                        <input type="button" class="btn" value="提交" @click="updateUser(uid)">
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
                    $('.form_datetime').datetimepicker({
                        minView: "month", //选择日期后，不会再跳转去选择时分秒
                        language:  'zh-CN',
                        format: 'yyyy-mm-dd',
                        todayBtn:  1,
                        autoclose: 1,
                    });
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
                }
            }
        });
    </script>
</body>
</html>