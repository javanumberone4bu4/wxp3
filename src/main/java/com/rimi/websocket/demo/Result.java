package com.rimi.websocket.demo;

import java.util.Collection;
import java.util.Collections;

/**
 * 结果类
 *
 * @author Wang Xiaoping
 * @date 2019/10/13 16:05
 */
public class Result {
    private Message message;
    private Collection online;

    public Message getMessage() {
        return message;
    }

    public void setMessage(Message message) {
        this.message = message;
    }

    public Collection getOnline() {
        return online;
    }

    public void setOnline(Collection online) {
        this.online = online;
    }
}
