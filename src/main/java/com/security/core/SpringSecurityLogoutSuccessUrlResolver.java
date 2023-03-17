package com.security.core;

import javax.servlet.http.HttpServletRequest;

/**
 * @AUTO
 * @Author AIM
 * @DATE 2018/6/15
 */
public interface SpringSecurityLogoutSuccessUrlResolver {

    /**
     * 是否支持接口
     *
     * @param req
     */
    boolean support(HttpServletRequest req);

    String resolve();
}
