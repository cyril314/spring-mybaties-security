package com.security.admin;

import com.security.core.SecurityAbstractLogoutSuccessUrlResolver;

import javax.servlet.http.HttpServletRequest;

/**
 * @AUTO
 * @Author AIM
 * @DATE 2018/6/15
 */
public class AdminSecurityLogoutSuccessUrlResolver extends SecurityAbstractLogoutSuccessUrlResolver {

    private final String pattern = "/admin";

    @Override
    public boolean support(HttpServletRequest request) {
        //获取返回除去host（域名或者ip）部分的路径
        String requestURI = request.getRequestURI();
        //判断是否存在包含匹配内容
        return requestURI.contains(pattern);
    }

}
