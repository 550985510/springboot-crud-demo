<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<!-- 引入标签库 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>用户列表</title>
    <%--服务器端--%>
    <script type="text/javascript" src="/springboot-test/js/jquery-3.2.1.js"></script>
    <link href="/springboot-test/js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="/springboot-test/js/bootstrap/js/bootstrap.min.js"></script>
    <%--本地--%>
    <script type="text/javascript" src="/js/jquery-3.2.1.js"></script>
    <link href="/js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="/js/bootstrap/js/bootstrap.min.js"></script>

</head>
<body>
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
                            <input type="text" name="username" class="form-control" id="username_add_input" placeholder="用户名">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="male_add_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="female_add_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="Email@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>



<!-- 修改用户模态框 -->
<div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改用户</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <p name="username" class="form-control-static" id="username_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="male_update_input" value="男"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="female_update_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="Email@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_update_btn">修改</button>
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
                <input type="text" class="form-control" id="user_select_input" placeholder="请输入字段名">
                <span class="input-group-btn">
               		<button class="btn btn-info btn-search" id="user_select_btn">查找</button>
            	</span>
            </div>
        </div>
        <div class="col-md-5">
            <button class="btn btn-info" id="user_back_btn">返回查找</button>
            <button class="btn btn-primary" id="user_add_modal_btn" >新增用户</button>
            <button class="btn btn-danger" id="user_delete_all_btn" style="margin-left:3px">批量删除</button>
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
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!-- 分页信息 -->
    <div class="row">
        <!-- 分页文字信息 -->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!-- 分页条 -->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord,currentPage,nowNickName;

    //页面加载完成后发送ajax请求要到分页数据
    $(function() {
        //去首页
        to_page(1);
        //清空搜索框
        $("#user_select_input").val("");
    });

    //跳转页面
    function to_page(pn){
        $.ajax({
            url:"/users",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                //console.log(result);
                //解析并显示用户信息
                build_users_table(result);
                //解析并显示分页文字信息
                build_page_info(result);
                //解析并显示分页条信息
                build_page_nav(result,null);

            }
        });
    }


    function build_users_table(result){
        //请求前清空table表格
        $("#users_table tbody").empty();

        var users = result.extend.pageInfo.list;
        $.each(users,function(index,item){
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var uidTd = $("<td></td>").append(item.uid);
            var usernameTd = $("<td></td>").append(item.username);
            var sexTd = $("<td></td>").append(item.sex);
            var emailTd = $("<td></td>").append(item.email);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_user_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");

            //为编辑按钮添加一个自定义属性 来表示当前用户uid
            editBtn.attr("edit_uid",item.uid);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_user_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            //为删除按钮添加一个自定义属性 来表示当前用户uid
            delBtn.attr("delete_uid",item.uid);

            //append方法执行完成后返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(uidTd)
                .append(usernameTd)
                .append(sexTd)
                .append(emailTd)
                .append(btnTd)
                .appendTo("#users_table tbody");
        });
    }
    //解析并显示分页文字信息
    function build_page_info(result){
        //请求前清空分页信息
        $("#page_info_area").empty();

        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum
            +"页, 总共"+result.extend.pageInfo.pages+"页, 共"
            +result.extend.pageInfo.total+"条记录");
        //总记录数
        totalRecord = result.extend.pageInfo.total;
        //当前页
        currentPage = result.extend.pageInfo.pageNum;
    }
    //解析并显示分页条信息
    function build_page_nav(result,like){
        //请求前清空分页区域信息
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");

        //构建首页 前一页元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加点击事件
            firstPageLi.click(function(){
                if(like!=null){
                    showUsers(1,like);
                }else {
                    to_page(1);
                }
            });

            prePageLi.click(function(){
                if (like!=null){
                    showUsers(result.extend.pageInfo.pageNum-1,like);
                }else {
                    to_page(result.extend.pageInfo.pageNum-1);
                }
            });
        }

        //添加首页 前一页提示
        ul.append(firstPageLi).append(prePageLi);

        //1,2,3,4,5遍历给ul中添加页码号提示
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            //页码点击事件
            numLi.click(function(){
                if (like!=null){
                    showUsers(item,like);
                }else {
                    to_page(item);
                }
            });
            ul.append(numLi);
        });

        //构建下一页 末页元素
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            //为元素添加点击事件
            lastPageLi.click(function(){
                if (like!=null){
                    showUsers(result.extend.pageInfo.pages+1,like);
                }else{
                    to_page(result.extend.pageInfo.pages);
                }
            });

            nextPageLi.click(function(){
                if (like!=null){
                    showUsers(result.extend.pageInfo.pageNum+1,like);
                }else {
                    to_page(result.extend.pageInfo.pageNum+1);
                }
            });
        }

        //添加下一页 末页提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav元素
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    //重置表单样式及内容
    function reset_form(ele){
        //内容
        $(ele)[0].reset();
        //样式
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }




    //查找显示
    function showUsers(pn,like){
        $.ajax({
            url:"/selectUsersByLike",
            data:"like="+like+"&pn="+pn,
            type:"POST",
            success:function(result){
                if(result.code == 100){
                    //console.log(result);
                    //解析并显示用户信息
                    build_users_table(result);
                    //解析并显示分页文字信息
                    build_page_info(result);
                    //解析并显示分页条信息
                    build_page_nav(result,like);
                }
            }
        });
    }


    $("#user_back_btn").click(function(){
        to_page(1);
    })



    //点击查找按钮显示查询结果
    $("#user_select_btn").click(function(){
        var like = $("#user_select_input").val();
        showUsers(1,like);
        //清空搜索框
        $("#user_select_input").val("");
    });

    //点击新增按钮弹出添加用户模态框
    $("#user_add_modal_btn").click(function(){
        //清除表单数据
        reset_form("#userAddModal form");
        //弹出模态框
        $("#userAddModal").modal({
            //单击模态框背景不关闭
            backdrop:"static"
        });
    });

    //表单提交数据校验方法
    function validate_add_form(){
        //拿到数据使用正则表达式校验

        //校验用户名
        var username = $("#username_add_input").val();
        var regUserName = /^[\u4e00-\u9fa5_a-zA-Z0-9_]{2,16}$/;
        if(!regUserName.test(username)){
            //alert("用户名不合法，请输入6-16位英文字母、数字或下划线。");
            show_validate_msg("#username_add_input","error","用户名不合法，请输入2-16位英文字母、汉字、数字或下划线");
            return false;
        }else{
            show_validate_msg("#username_add_input","success","当前用户名合法");
        };



        //校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确！");
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_add_input","success","邮箱格式正确");
        };

        return true;
    }

    //显示校验结果提示信息
    function show_validate_msg(ele,status,msg){
        //清除当前元素样式(校验状态)
        $(ele).parent().removeClass("has-success has-error");

        if(status == "success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if(status == "error"){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //文本框change事件校验用户名是否可用
    $("#username_add_input").change(function(){
        //发送ajax请求校验用户名是否可用
        var username = this.value;
        $.ajax({
            url:"/checkUser",
            data:"username="+username,
            type:"POST",
            success:function(result){
                if(result.code == 100){
                    show_validate_msg("#username_add_input","success","当前用户名可用");
                    $("#user_save_btn").attr("ajax_va_username","success");
                }else{
                    show_validate_msg("#username_add_input","error",result.extend.va_username_msg);
                    $("#user_save_btn").attr("ajax_va_username","error");
                }
            }
        });
    });



    //添加模态框中文本框change事件校验邮箱是否合法
    $("#email_add_input").change(function(){
        //发送ajax请求校验邮箱是否合法
        var email = this.value;
        $.ajax({
            url:"/checkEmail",
            data:"email="+email,
            type:"POST",
            success:function(result){
                if(result.code == 100){
                    show_validate_msg("#email_add_input","success","邮箱格式正确");
                    $("#user_save_btn").attr("ajax_va_email","success");
                }else{
                    show_validate_msg("#email_add_input","error",result.extend.va_email_msg);
                    $("#user_save_btn").attr("ajax_va_email","error");
                }
            }
        });
    });

    //保存按钮单击事件
    $("#user_save_btn").click(function(){
        //将模态框中填写的表单数据提交服务器并保存

        //对提交的数据进行校验
        if(!validate_add_form()){
            return false;
        };

        //校验用户名是否可用
        if($(this).attr("ajax_va_username") == "error"){
            return false;
        }


        //发送ajax请求保存用户
        $.ajax({
            url:"/user",
            type:"POST",
            //默认添加用户的密码与用户名相同
            data:$("#userAddModal form").serialize()+"&password="+$("#username_add_input").val(),
            success:function(result){
                if(result.code == 100){
                    //用户保存成功关闭模态框并来到最后一页显示新增数据
                    $("#userAddModal").modal('hide');
                    alert(result.msg);
                    to_page(totalRecord);
                }else{
                    //显示失败信息
                    if(undefined != result.extend.errorFields.email){
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.username){
                        show_validate_msg("#username_add_input","error",result.extend.errorFields.username);
                    }
                }
            }
        });
    });


    //点击修改按钮弹出修改用户模态框
    $(document).on("click",".edit_user_btn",function(){
        //清除当前元素样式(校验状态)
        $("#userUpdateModal form").find("*").removeClass("has-success has-error");
        $("#userUpdateModal form").find(".help-block").text("");
        //查出用户信息并显示
        getUser($(this).attr("edit_uid"));
        //将用户uid传递给更新按钮
        $("#user_update_btn").attr("edit_uid",$(this).attr("edit_uid"));
        //弹出模态框
        $("#userUpdateModal").modal({
            //单击模态框背景不关闭
            backdrop:"static"
        });
    });


    //查询用户信息
    function getUser(uid){
        $.ajax({
            url:"/user/"+uid,
            type:"GET",
            success:function(result){
                var userData = result.extend.user;
                $("#username_update_static").text(userData.username);
                $("#email_update_input").val(userData.email);
                $("#userUpdateModal input[name=sex]").val([userData.sex]);
            }
        });
    }





    //修改模态框中文本框change事件校验邮箱是否合法
    $("#email_update_input").change(function(){
        //发送ajax请求校验邮箱是否合法
        var email = this.value;
        $.ajax({
            url:"/checkEmail",
            data:"email="+email,
            type:"POST",
            success:function(result){
                if(result.code == 100){
                    show_validate_msg("#email_update_input","success","邮箱格式正确");
                    $("#user_update_btn").attr("ajax_va_email","success");
                }else{
                    show_validate_msg("#email_update_input","error",result.extend.va_email_msg);
                    $("#user_update_btn").attr("ajax_va_email","error");
                }
            }
        });
    });



    //点击更新 更新用户信息
    $("#user_update_btn").click(function(){

        //发送ajax请求保存用户更新数据
        $.ajax({
            url:"/user/"+$(this).attr("edit_uid"),
            type:"PUT",
            data:$("#userUpdateModal form").serialize(),
            success:function(result){
                if(result.code == 100){
                    //关闭模态框
                    $("#userUpdateModal").modal("hide");
                    alert("修改成功");
                    //回到本页面
                    to_page(currentPage);
                }else{
                    if(undefined != result.extend.errorFields.email){
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                }
            }
        });
    });


    //点击删除按钮(每行中的)弹出对话框(单个删除)
    $(document).on("click",".delete_user_btn",function(){
        //在第三个<td>中拿到用户名
        var username = $(this).parents("tr").find("td:eq(2)").text();
        //通过自定义属性拿到用户uid
        var uid = $(this).attr("delete_uid");
        if(confirm("确认删除用户:【"+username+"】吗？")){
            //点击确认发送ajax请求删除该用户
            $.ajax({
                url:"/user/"+uid,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });


    //全选、全不选功能
    //check_item同步check_all
    $("#check_all").click(function(){
        //prop获取dom原生属性的值
        //check_item的值与check_all同步
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //check_all同步check_item
    $(document).on("click",".check_item",function(){
        //判断是否全被选中(当前每页五个)
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    });


    //点击删除按钮删除选中用户
    $("#user_delete_all_btn").click(function(){
        var username = "";
        var del_uidstr = "";
        $.each($(".check_item:checked"),function(){
            //组装用户名
            username += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装用户uid
            del_uidstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去掉最后多余的逗号
        username = username.substring(0,username.length-1);
        //去掉最后多余的-
        del_uidstr = del_uidstr.substring(0,del_uidstr.length-1);
        if(username == ""){
            alert("请选择要删除的用户");
        }else if(confirm("确认删除用户:【"+username+"】吗？")){
            //点击确认发送ajax请求删除该用户
            $.ajax({
                url:"/user/"+del_uidstr,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });

</script>




</body>
</html>