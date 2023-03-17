<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>405 页面</title>
    <jsp:include page="../views/_include/head.jsp"/>
</head>
<body class="gray-bg">
<div class="middle-box text-center animated fadeInDown">
    <h1>405</h1>
    <h3 class="font-bold">用来访问本页面的 HTTP 方法不被允许！</h3>

    <div class="error-desc">
        抱歉，页面好像去火星了~
        <form class="form-inline m-t" role="form">
            <div class="form-group">
                <input type="email" class="form-control" placeholder="请输入您需要查找的内容 …">
            </div>
            <button type="submit" class="btn btn-primary">搜索</button>
        </form>
    </div>
</div>

</body>
</html>
