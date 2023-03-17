<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>管理登陆页</title>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="/favicon.ico">
    <script type="text/javascript" src="${webpath}/static/js/jquery.min.js?v=2.1.4"></script>
    <script type="text/javascript" src="${webpath}/static/js/plugins/layer/layer.min.js"></script>
    <script type="text/javascript">
        if (window.top != null && window.top.location != window.location) {
            window.top.location = window.location;
        }
        if (self != top) {
            top.location.href = self.location.href;
        }

        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            console.log(r);
            if (r != null) return unescape(r[2]);
            return null;
        }

        window.onload = function () {
            var config = {
                vx: 4,
                vy: 4,
                height: 2,
                width: 2,
                count: 100,
                color: "121, 162, 185",
                stroke: "100, 200, 180",
                dist: 6000,
                e_dist: 20000,
                max_conn: 10
            }
            CanvasParticle(config);

            var myurl = GetQueryString("error");
            if (myurl != null && myurl.toString().length > 0) {
                layer.msg("登陆失败,用户或密码错误", {time: 1500, icon: 2});
            }

        }
    </script>
    <script type="text/javascript" src="${webpath}/static/js/canvas-particle.js"></script>
    <style>
        body {
            background: url('${webpath}/static/img/login.jpg') no-repeat fixed;
        }

        #win10-login {
            width: 100%;
            height: 100%;
            background-size: 100% 100%;
            position: fixed;
            z-index: -0;
            top: 0;
            left: 0;
        }

        #win10-login-box {
            width: 300px;
            overflow: hidden;
            margin: 0 auto;
        }

        .win10-login-box-square {
            width: 105px;
            margin: 0 auto;
            border-radius: 50%;
            background-color: darkgray;
            position: relative;
            overflow: hidden;
        }

        .win10-login-box-square::after {
            content: "";
            display: block;
            padding-bottom: 100%;
        }

        .win10-login-box-square .content {
            position: absolute;
            width: 100%;
            height: 100%;
        }

        input {
            width: 90%;
            display: block;
            border: 0;
            margin: 0 auto;
            line-height: 36px;
            font-size: 20px;
            padding: 0 1em;
            border-radius: 5px;
            margin-bottom: 11px;
            outline: none;
        }

        .login-username, .login-password {
            width: 91%;
            font-size: 13px;
            color: #999;
        }

        .login-password {
            width: calc(91% - 54px);
            -webkit-border-radius: 2px 0 0 2px;
            -moz-border-radius: 2px 0 0 2px;
            border-radius: 5px 0 0 5px;
            margin: 0px;
            float: left;
        }

        .login-submit {
            margin: 0px;
            float: left;
            -webkit-border-radius: 0 5px 5px 0;
            -moz-border-radius: 0 5px 5px 0;
            border-radius: 0 5px 5px 0;
            background-color: #009688;
            width: 54px;
            display: inline-block;
            height: 36px;
            line-height: 36px;
            padding: 0 auto;
            color: #fff;
            white-space: nowrap;
            text-align: center;
            font-size: 14px;
            border: none;
            cursor: pointer;
            opacity: .9;
            filter: alpha(opacity=90);
        }
    </style>
</head>
<body>
<div id="win10-login">
    <div style="height: 10%;min-height: 120px"></div>
    <div id="win10-login-box">
        <div class="win10-login-box-square">
            <img src="${webpath}/static/img/avatar.jpg" class="content"/>
        </div>
        <p style="font-size: 24px;color: white;text-align: center"></p>
        <form method="post" action="${webpath}/admin/login_check">
            <!--用户名-->
            <input type="text" placeholder="请输入登录名" name="username" class="login-username">
            <!--密码-->
            <input type="password" placeholder="请输入密码" name="password" class="login-password">
            <!--登陆按钮-->
            <input type="submit" value="登录" id="btn-login" class="login-submit"/>
        </form>
    </div>
</div>
</body>
</html>