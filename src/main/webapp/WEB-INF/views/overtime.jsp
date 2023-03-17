<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Session超时</title>
    <jsp:include page="_include/head.jsp"/>
</head>
<body class="gray-bg">
    <div class="middle-box text-center animated fadeInDown">
        <h2>Session超时</h2>
        <h3 class="font-bold">错误码：12002</h3>

        <div class="error-desc">
            登陆的用户已超时,请重新登陆...
            <br/>您可以返回主页看看
            <br/><a href="/admin/login" class="btn btn-primary m-t">重新登陆</a>
        </div>
    </div>
</body>
</html>
