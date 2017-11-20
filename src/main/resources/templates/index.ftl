<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <title>学生用户列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/jquery.pagination.css">
    <script type="text/javascript" src="/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="/js/vue.js"></script>
    <script type="text/javascript" src="/js/vue-resource.js"></script>
    <link href="/js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="/js/bootstrap/js/bootstrap.min.js"></script>
    <link href="/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script src="/js/bootstrap-datetimepicker.min.js"></script>
</head>

<body class="dashboard-page">

<div id="userList">
<nav style="background-color:#f5f5f5;padding:0 20px;border-bottom:1px solid #e5e5e5;line-height:41px;height:41px;font-size:14px;">
    <span class="glyphicon glyphicon-home"></span> 首页 <span>&gt;</span> 用户管理 <span>&gt;</span> 用户列表
    <a class="btn btn-success btn-sm" href="javascript:location.replace(location.href);" style="float:right; margin-top:5px" title="刷新" >
        <span class="glyphicon glyphicon-refresh"></span>
    </a>
</nav>

<!-- 添加用户模态框 -->
<div class="modal fade" id="userAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加新用户</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" name="username" class="form-control" id="username_add_input" placeholder="用户名" v-model="searchInfo.username">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="male_add_input" checked="checked" value="男" v-model="searchInfo.sex"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="female_add_input" value="女" v-model="searchInfo.sex"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="Email@163.com" v-model="searchInfo.email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">出生日期</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control form_datetime" id="addtime" name="addtime"  placeholder="请选择您的生日" v-model="searchInfo.birthday">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_save_btn" @click="save">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>用户信息管理</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-3 col-md-offset-4">
            <div class="input-group">
                <input type="text" class="form-control" id="user_select_input" placeholder="请输入字段名" v-model="searchInfo.like">
                <span class="input-group-btn">
               		<button class="btn btn-info btn-search" id="user_select_btn" @click="query(searchInfo)">查找</button>
            	</span>
            </div>
        </div>
        <div class="col-md-5">
            <button class="btn btn-info" id="user_back_btn" @click="queryBack">返回查找</button>
            <button class="btn btn-primary" id="user_add_modal_btn" @click="addModal" >新增用户</button>
            <button class="btn btn-danger" id="user_delete_all_btn">批量删除</button>
        </div>
    </div>
    <!-- 表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="users_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>用户名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>生日</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="users in users">
                        <td>
                            <input type='checkbox' class='check_item'/>
                        </td>
                        <td>{{users.uid}}</td>
                        <td>{{users.username}}</td>
                        <td>{{users.sex}}</td>
                        <td>{{users.email}}</td>
                        <td>{{users.birthday}}</td>
                        <td>
                            <button class="btn btn-primary btn-sm edit_user_btn">
                                <span class="glyphicon glyphicon-pencil">编辑</span>
                            </button>
                            <button class="btn btn-danger btn-sm delete_user_btn">
                                <span class="glyphicon glyphicon-trash">删除</span>
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 分页信息 -->
    <div class="row">
        <!-- 分页条 -->
        <!-- 分页文字信息 -->
        <div class="col-md-6" id="page_info_area">
            <span>当前第{{pageInfo.pageNum}}页, 总共{{pageInfo.pages}}页, 共{{pageInfo.total}}条记录</span>
        </div>
        <!-- 分页条 -->
        <div class="col-md-6" id="page_nav_area">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li :class="{disabled: !pageInfo.hasPreviousPage}"><a href="#" @click="prePage(1)">首页</a></li>
                    <li :class="{disabled: !pageInfo.hasPreviousPage}"><a href="#" @click="prePage(pageInfo.pageNum-1)">&laquo;</a></li>
                    <li v-for="page in page"><a href="#" @click="jump(page)">{{page}}</a></li>
                    <li :class="{disabled: !pageInfo.hasNextPage}"><a href="#" @click="nextPage(pageInfo.pageNum+1)">&raquo;</a></li>
                    <li :class="{disabled: !pageInfo.hasNextPage}"><a href="#" @click="nextPage(pageInfo.pages)">末页</a></li>
                </ul>
            </nav>
        </div>
        <div id="pageMenu"></div>
    </div>
</div>
</div>
<script src="/js/jquery.pagination-1.2.7.js"></script>
<script>

    var app = new Vue({
        el: '#userList',
        data: {
            users: [],//用户信息
            pageInfo:[],//分页信息
            page:[],//页码号
            searchInfo: {//请求参数
                username:'',
                sex:'',
                email:'',
                birthday:'',
                like:'',
                pn: 1
            }
        },
        created: function () {
            this.searchInfo.pn = 1;
            $('#pageMenu').page('destroy');
            this.query(this.searchInfo);
        },
        methods: {
            jump:function (pn) {
                this.searchInfo.pn=pn;
                this.query(this.searchInfo);
            },
            nextPage:function (pn) {
                if (this.pageInfo.hasNextPage){
                    this.searchInfo.pn=pn;
                    this.query(this.searchInfo);
                }else {
                    return null;
                }
            },
            prePage:function (pn) {
                if (this.pageInfo.hasPreviousPage){
                    this.searchInfo.pn=pn;
                    this.query(this.searchInfo);
                }else {
                    return null;
                }
            },
            query: function (searchInfo) {
                var self=this;
                $.ajax({
                    url:"/selectUserByLike",
                    type:"POST",
                    data:searchInfo,
                    success:function (response) {
                        //console.log(response);
                        self.users = response.extend.pageInfo.list;
                        self.pageInfo = response.extend.pageInfo;
                        self.page = response.extend.pageInfo.navigatepageNums;
                    }
                })
            },
            queryBack: function () {
                this.searchInfo.like='';
                this.query(this.searchInfo);
            },
            addModal: function () {
                $('.form_datetime').datetimepicker({
                    minView: "month", //选择日期后，不会再跳转去选择时分秒
                    language:  'zh-CN',
                    format: 'yyyy-mm-dd',
                    todayBtn:  1,
                    autoclose: 1,
                });
                $("#userAddModal").modal({
                    //单击模态框背景不关闭
                    backdrop:"static"
                });
            },
            save: function () {
                var self=this;
                //var data=$("#userAddModal form").serialize()//获取字符串形式数据
                //发送ajax请求保存用户
                $.ajax({
                    url:"/save",
                    type:"POST",
                    contentType:"application/json",
                    //默认添加用户的密码与用户名相同
                    data:JSON.stringify(self.searchInfo),
                    success:function(result){
                        if(result.code == 100){
                            //用户保存成功关闭模态框并来到最后一页显示新增数据
                            $("#userAddModal").modal('hide');
                            alert(result.msg);
                        }
                    }
                });
                self.searchInfo.pn=1000;
                this.query(self.searchInfo);
            }
        }

    });
</script>
</body>
</html>
