<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>登陆页面</title>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/dist/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet">
</head>
<body>

<div class="container">
    <form class="form-login" id="form" action="/login" method="post">
        <h2 class="form-login-heading">聊天室</h2>
        <label for="username" class="sr-only">用户名</label>
        <input type="text" name="username" id="username" class="form-control" placeholder="请输入昵称" required autfocus/>
        <button class="btn btn-primary btn-block" type="submit">登录</button>
    </form>
</div>
<script src="${pageContext.request.contextPath}/webjars/jquery/3.4.1/dist/jquery.js"></script>
<script src="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/dist/js/bootstrap.js"></script>
</body>
</html>
