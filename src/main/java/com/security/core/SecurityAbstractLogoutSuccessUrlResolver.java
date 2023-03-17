package com.security.core;

import javax.servlet.http.HttpServletRequest;

/**
 * @AUTO
 * @Author AIM
 * @DATE 2018/6/15
 */
public abstract class SecurityAbstractLogoutSuccessUrlResolver implements SpringSecurityLogoutSuccessUrlResolver {

    private String url;

    public SecurityAbstractLogoutSuccessUrlResolver() {
    }

    public abstract boolean support(HttpServletRequest request);

    public String resolve() {
        return this.url;
    }

    public void setUrl(String urlParm) {
        this.url = urlParm;
    }
}
