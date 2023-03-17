package com.security.core;

import javax.servlet.http.HttpServletRequest;

/**
 * @AUTO Spring安全URL指向解析器接口
 * @Author AIM
 * @DATE 2018/6/15
 */
public interface SpringSecurityDirectUrlResolver {

    /**
     * 是否支持接口
     *
     * @param req
     */
    boolean support(HttpServletRequest req);

    /**
     * 获取指向URL
     */
    String directUrl();
}
