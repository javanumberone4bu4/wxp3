package com.rimi.websocket.demo;

/**
 * 信息类
 *
 * @author Wang Xiaoping
 * @date 2019/10/13 15:59
 */
public class Message {
    private String username;
    private String data;
    private long times;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public long getTimes() {
        return times;
    }

    public void setTimes(long times) {
        this.times = times;
    }
}
