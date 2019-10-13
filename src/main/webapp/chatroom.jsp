<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>聊天室</title>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/dist/css/bootstrap.css" rel="stylesheet">
    <style>
        .msg-list, .user-list {
            height: 400px;
            overflow-y: auto;
        }
        .msg-list p span {
            border: 1px solid #bce8f1;
            padding: 1px 10px;
            border-radius: 5px;
            background-color: #d9edf7;
        }

        .msg-body {
            padding-left: 0;
        }

        .user-body {
            padding-right: 0;
        }

        .user-total {
            color: fuchsia;
        }

        .total {
            margin: 7px;
        }
    </style>
</head>
<body>
<div class="container">
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">聊天室</a>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"
                       role="button" aria-haspopup="true" aria-expanded="false">
                        ${username} <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="javascript:void(0);" onclick="logout()">
                                <i class="glyphicon glyphicon-log-out"></i> 退出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    <div class="col-md-8 msg-body">
        <div class="panel panel-info">
            <div class="panel-heading">
                <i class="glyphicon glyphicon-th-list"></i> 聊天室
            </div>
            <div class="panel-body">
                <div class="msg-list">

                </div>
            </div>
            <div class="panel-footer">
                <div class="input-group">
                    <input type="text" id="msg" class="form-control" placeholder="请输入">
                    <span class="input-group-btn">
                        <button class="btn btn-info" type="button" onclick="send()">Go!</button>
                    </span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4 user-body">
        <div class="panel panel-info">
            <div class="panel-heading">
                <i class="glyphicon glyphicon-user"></i> 在线列表
            </div>
            <div class="panel-body">
                <div class="user-list">
                    <ul class="list-group" id="user-list">
                    </ul>
                </div>
            </div>
            <div class="panel-footer">
                <div class="total">
                    在线人数: <span class="user-total">ss</span>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/webjars/jquery/3.4.1/dist/jquery.js"></script>
<script src="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/dist/js/bootstrap.js"></script>
<script>
    var websocket = null;
    var host = document.location.host;
    // 判断当前浏览器是否支持websocket
    if ('WebSocket' in window) {
        websocket = new WebSocket('ws://' + host + '/chatroom/${username}');
    } else {
        alert("当前浏览器不支持WebSocket")
    }

    // 连接成功建立的回调方法
    websocket.onopen = function () {
        alert("连接成功")
    };

    // 连接发送错误时的回调方法
    websocket.onerror = function () {
        alert("连接发生未知错误")
    };

    // 关闭连接时的回调方法
    websocket.onclose = function () {
        alert("连接已关闭")
    };

    // 接收到数据时的回调方法
    websocket.onmessage = function (event) {
        // 获取数据
        var result = JSON.parse(event.data);
        // 更新消息
        setMessage(result.message);
        // 更新在线用户列表
        setUserList(result.online);
    };

    // 监听窗口刷新事件,当窗口关闭时,主动关闭websocket连接,防止服务器异常
    window.onbeforeunload = function () {
        websocket.close();
    };
    window.onclose = function (){
        websocket.close();
    };

    // 发送消息
    function send() {
        // 获取消息
        var msg = $("#msg").val();
        if (msg != null && msg.length > 0 && msg != undefined) {
            // 发送数据
            websocket.send(msg);
            // 情况输入输入框
            $("#msg").val("")
        }
    }

    function setMessage(message) {
        var document = '';
        if (message.username == '${username}') {
            document = '<p style="text-align: right">' +
                '<i class="glyphicon glyphicon-user"></i> ' + message.username +':'+ message.times + '</br>' +
                '<span>' + message.data + '</span></p>';
        } else if (message.username == '系统'){
            document = '<p style="text-align: center">' +
                '<span>' + message.data + '</span></p>';
        } else {
            document = '<p><i class="glyphicon glyphicon-user"></i> '+ message.username +':'+ + message.times + '</br>' +
                '<span>' + message.data + '</span></p>';
        }
        $(".msg-list").append(document);
        // 自动滚动到最后行
        $(".msg-list").scrollTop( $(".msg-list")[0].scrollHeight)
    }

    function setUserList(list){
        $("#user-list").html('');
        list.forEach(function(item,index){
            $('#user-list').append('<li class="list-group-item">' +
                '<i class="glyphicon glyphicon-user"></i> ' + item +'</li>');
        });
        $(".user-total").html(list.length);
    }

    function logout(){
        websocket.close();
        location.href = "/";
    }
</script>
</body>
</html>


