<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>login</title>
    <link rel="stylesheet" type="text/css" href="${webpath}/static/css/front/normalize.css" />
    <link rel="stylesheet" type="text/css" href="${webpath}/static/css/front/demo.css" />
    <!--必要样式-->
    <link rel="stylesheet" type="text/css" href="${webpath}/static/css/front/component.css" />
    <!--[if IE]>
    <script src="${webpath}/static/js/front/html5.js"></script>
    <![endif]-->
    <script>
        if (window.top != null && window.top.location != window.location) {
            window.top.location = window.location;
        }
        if (self != top) {
            top.location.href = self.location.href;
        }

        function formSubmit() {
            document.getElementById("loginForm").submit();
        }

        document.onkeydown = function (event) {
            var e = event || window.event;
            if (e && e.keyCode == 13) {
                formSubmit();
            }
        };
    </script>
</head>
<body>
<div class="container demo-1">
    <div class="content">
        <div id="large-header" class="large-header">
            <canvas id="demo-canvas"></canvas>
            <div class="logo_box">
                <h3>欢迎你</h3>
                <form method="post" action="${webpath}/front/login_check" id="loginForm">
                    <div class="input_outer">
                        <span class="u_user"></span>
                        <input name="username" class="text" style="color: #FFFFFF !important" type="text" placeholder="请输入账户">
                    </div>
                    <div class="input_outer">
                        <span class="us_uer"></span>
                        <input name="password" class="text" style="color: #FFFFFF !important; position:absolute; z-index:100;" type="password" placeholder="请输入密码">
                    </div>
                    <div class="mb2"><a class="act-but submit" href="javascript:formSubmit();" style="color: #FFFFFF">登录</a></div>
                </form>
            </div>
        </div>
    </div>
</div><!-- /container -->
<script src="${webpath}/static/js/front/TweenLite.min.js"></script>
<script src="${webpath}/static/js/front/EasePack.min.js"></script>
<script src="${webpath}/static/js/front/rAF.js"></script>
<script src="${webpath}/static/js/front/demo-1.js"></script>
</body>
</html>