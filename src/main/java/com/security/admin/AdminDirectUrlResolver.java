package com.security.admin;

import com.security.core.SpringSecurityDirectUrlResolver;

import javax.servlet.http.HttpServletRequest;

/**
 * @AUTO 后台路径指向解析器实现
 * @Author AIM
 * @DATE 2018/6/15
 */
public class AdminDirectUrlResolver implements SpringSecurityDirectUrlResolver {

    /**
     * 匹配内容
     */
    private String pattern;
    /**
     * 跳转路径
     */
    private String directUrl;

    public AdminDirectUrlResolver() {
    }

    public String directUrl() {
        return this.directUrl;
    }

    public String getPattern() {
        return this.pattern;
    }

    public void setPattern(String patternParm) {
        this.pattern = patternParm;
    }

    public String getDirectUrl() {
        return this.directUrl;
    }

    public void setDirectUrl(String directUrlParm) {
        this.directUrl = directUrlParm;
    }

    public boolean support(HttpServletRequest request) {
        //获取返回除去host（域名或者ip）部分的路径
        String requestURI = request.getRequestURI();
        //判断是否存在包含匹配内容
        return requestURI.contains(this.getPattern());
    }
}
