package com.rimi.websocket.demo;

import com.alibaba.fastjson.JSONObject;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 聊天室
 *
 * @author Wang Xiaoping
 * @date 2019/10/13 15:47
 */
@ServerEndpoint("/chatroom/{username}")
public class Chatroom {
    /**
     * concurrent该包下的类皆为线程安全,用来存放每个客户端对应的自定义webSocket对象
     */
    private static Map<String, Chatroom> clients = new ConcurrentHashMap<>();
    private static int chatOnlineCount = 0;
    private Session session;
    private String username;

    @OnOpen
    public void onOpen(Session session, @PathParam("username") String username) {
        if (!clients.containsKey(username)) {
            this.session = session;
            this.username = username;
            clients.put(username, this);
            addOnlineCount();
            //发送消息
            sendMessage(getResult("系统", this.username + "上线了"));
        }
    }

    @OnClose
    public void onClose(@PathParam("username") String username) {
        if (clients.containsKey(username)) {
            clients.remove(username);
            removeOnlineCount();
            sendMessage(getResult("系统", this.username + "下线了"));
        }
    }

    @OnError
    public void onError(Throwable error) {

    }

    /**
     * 接收客户端的消息
     *
     * @param message 客户端发送的消息
     */
    @OnMessage
    public void onMessage(String message) {
        sendMessage(getResult(this.username, message));

    }

    private String getResult(String username, String msg) {
        Message message = new Message();
        message.setUsername(username);
        message.setData(msg);
        message.setTimes(System.currentTimeMillis());
        Result result = new Result();
        result.setMessage(message);
        result.setOnline(clients.keySet());
        return JSONObject.toJSONString(result);
    }

    private void sendMessage(String message) {
        for (Chatroom chatroom : clients.values()) {
            chatroom.session.getAsyncRemote().sendText(message);
        }
    }

    private static synchronized void addOnlineCount() {
        chatOnlineCount++;
    }

    private static synchronized void removeOnlineCount() {
        chatOnlineCount--;
    }

    private static synchronized int getOnlineCount() {
        return chatOnlineCount;
    }

}
