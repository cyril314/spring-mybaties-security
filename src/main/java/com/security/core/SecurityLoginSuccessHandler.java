package com.security.core;

import com.common.utils.RequestUtil;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @AUTO 登录后的处理
 * @Author AIM
 * @DATE 2018/6/15
 */
public class SecurityLoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler implements InitializingBean {

    private final Logger log = LogManager.getLogger(SecurityLoginSuccessHandler.class);

    private String successUrl = "/"; // 登录成功url
    private boolean forwardToDestination = false; // forward方式跳转
    private List<SpringSecurityDirectUrlResolver> directUrlResolvers = new ArrayList<SpringSecurityDirectUrlResolver>(); // 多登录页面处理

    public SecurityLoginSuccessHandler() {
        super();
    }

    public SecurityLoginSuccessHandler(final String defaultTargetUrl) {
        successUrl = defaultTargetUrl;
        setDefaultTargetUrl(defaultTargetUrl);
    }

    @Override
    public void onAuthenticationSuccess(final HttpServletRequest httpServletRequest, final HttpServletResponse httpServletResponse, final Authentication authentication) throws IOException, ServletException {
        // 多登录页面处理
        String targetUrl = successUrl; // 每次恢复为默认的
        setDefaultTargetUrl(targetUrl);
        for (SpringSecurityDirectUrlResolver resolver : directUrlResolvers) {
            if (resolver.support(httpServletRequest)) {
                targetUrl = resolver.directUrl();
                setDefaultTargetUrl(targetUrl);
            }
        }
        targetUrl = determineTargetUrl(httpServletRequest, httpServletResponse);

        log.info("=============================> 访问登陆成功处理程序,跳转路径为:" + targetUrl);
        if (this.forwardToDestination) {
            log.debug("登录成功，Forwarding 到页面 " + targetUrl);
            httpServletRequest.getRequestDispatcher(targetUrl).forward(httpServletRequest, httpServletResponse);
        } else {
            log.debug("登录成功，Redirecting 到页面 " + targetUrl);
            // 在redirectStrategy中，'/'代表的是项目根目录而不是服务器根目录。
            super.onAuthenticationSuccess(httpServletRequest, httpServletResponse, authentication);
        }
    }

    public void setForwardToDestination(final boolean forwardToDestinationParm) {
        this.forwardToDestination = forwardToDestinationParm;
    }

    public void setDirectUrlResolvers(final List<SpringSecurityDirectUrlResolver> directUrlResolversParm) {
        this.directUrlResolvers = directUrlResolversParm;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        if (RequestUtil.isNullOrBlank(getDefaultTargetUrl())) {
            throw new Exception("没有配置defaultTargetUrl");
        }
    }
}
