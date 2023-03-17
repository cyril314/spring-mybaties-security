package com.security.core;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @AUTO
 * @Author AIM
 * @DATE 2018/6/15
 */
public class SecurityLogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler implements LogoutSuccessHandler {

    private final Logger log = LogManager.getLogger(SecurityLogoutSuccessHandler.class);

    private String successUrl = "/login"; // 退出成功url
    private List<SpringSecurityLogoutSuccessUrlResolver> resolvers = new ArrayList<SpringSecurityLogoutSuccessUrlResolver>();

    public void setResolvers(final List<SpringSecurityLogoutSuccessUrlResolver> resolversParm) {
        this.resolvers = resolversParm;
    }

    public SecurityLogoutSuccessHandler(final String defaultTargetUrl) {
        successUrl = defaultTargetUrl;
        setDefaultTargetUrl(defaultTargetUrl);
    }

    @Override
    public void onLogoutSuccess(final HttpServletRequest request, final HttpServletResponse response, final Authentication authentication) throws IOException, ServletException {
        String targetUrl = successUrl;
        setDefaultTargetUrl(targetUrl);
        for (SpringSecurityLogoutSuccessUrlResolver resolver : resolvers) {
            if (authentication != null && resolver.support(request)) {
                targetUrl = resolver.resolve();
                setDefaultTargetUrl(targetUrl);
            }
        }
        log.info("=============================> 访问退出登陆处理程序,跳转路径为:" + targetUrl);
        super.onLogoutSuccess(request, response, authentication);
    }

}
