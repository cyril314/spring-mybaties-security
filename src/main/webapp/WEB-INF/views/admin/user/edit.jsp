<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户编辑</title>
    <jsp:include page="../../_include/head.jsp"/>
</head>
<body class="gray-bg" style="height: 100%">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="ibox float-e-margins">
            <div class="ibox-content">
                <form class="form-horizontal m-t" id="userForm" action="/admin/save">
                    <input type="hidden" id="id" name="id" value="${user.id}"/>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">昵称：</label>
                        <div class="col-sm-8">
                            <input id="name" name="name" class="form-control" type="text" value="${user.name}"/>
                            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 为你的账户添加个昵称把!</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户名：</label>
                        <div class="col-sm-8">
                            <input id="username" name="username" class="form-control" type="text" aria-required="true"
                                   aria-invalid="true" class="error" value="${user.username}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密码：</label>
                        <div class="col-sm-8">
                            <input id="password" name="password" class="form-control" type="password"
                                   value="${user.password}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">确认密码：</label>
                        <div class="col-sm-8">
                            <input id="confirm_password" name="confirm_password" class="form-control" type="password"
                                   value="${user.password}"/>
                            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 请再次输入您的密码</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">备注：</label>
                        <div class="col-sm-8">
                            <textarea id="desc" name="desc" class="form-control" type="email">${user.desc}</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-8 col-sm-offset-3">
                            <button class="btn btn-primary" type="submit">提交</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../../_include/foot.jsp"/>
<script type="text/javascript">
    $.validator.setDefaults({
        highlight: function (element) {
            $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
        },
        success: function (element) {
            element.closest('.form-group').removeClass('has-error').addClass('has-success');
        },
        errorElement: "span",
        errorPlacement: function (error, element) {
            if (element.is(":radio") || element.is(":checkbox")) {
                error.appendTo(element.parent().parent().parent());
            } else {
                error.appendTo(element.parent());
            }
        },
        errorClass: "help-block m-b-none",
        validClass: "help-block m-b-none"
    });

    //以下为官方示例
    $().ready(function () {
        // validate the comment form when it is submitted
        $("#commentForm").validate();

        // validate signup form on keyup and submit
        var icon = "<i class='fa fa-times-circle'></i> ";
        $("#signupForm").validate({
            rules: {
                username: {
                    required: true,
                    minlength: 2
                },
                password: {
                    required: true,
                    minlength: 5
                },
                confirm_password: {
                    required: true,
                    minlength: 5,
                    equalTo: "#password"
                },
                topic: {
                    required: "#newsletter:checked",
                    minlength: 2
                },
            },
            messages: {
                username: {
                    required: icon + "请输入您的用户名",
                    minlength: icon + "用户名必须两个字符以上"
                },
                password: {
                    required: icon + "请输入您的密码",
                    minlength: icon + "密码必须5个字符以上"
                },
                confirm_password: {
                    required: icon + "请再次输入密码",
                    minlength: icon + "密码必须5个字符以上",
                    equalTo: icon + "两次输入的密码不一致"
                }
            }
        });

        $('#userForm').submit(function () {
            $(this).ajaxSubmit({
                type: 'post',
                dataType: 'json',
                resetForm: "true",
                success: function (data) {
                    if (data.code == "200") {
                        layer.msg(data.msg);
                        setTimeout(function () {
                            parent.userTableRefresh();
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                        }, 1000);
                    } else {
                        layer.msg(data.msg, {time: 1500, icon: 2});
                    }
                }
            });
            return false; //阻止表单默认提交
        });
    });
</script>
</body>
</html>