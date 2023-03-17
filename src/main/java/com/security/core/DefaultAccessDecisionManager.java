package com.security.core;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.access.intercept.DefaultFilterInvocationSecurityMetadataSource;

import java.util.Collection;
import java.util.Iterator;

/**
 * @AUTO 负责权限的控制，如果请求的url在权限集合中有这个url对应的值，则放行
 * @Author AIM
 * @DATE 2018/7/18
 */
public class DefaultAccessDecisionManager implements AccessDecisionManager {

    private final Logger log = LogManager.getLogger(DefaultFilterInvocationSecurityMetadataSource.class);

    //检查用户是否够权限访问资源
    //参数authentication是从spring的全局缓存SecurityContextHolder中拿到的，里面是用户的权限信息
    //参数object是url
    //参数configAttributes所需的权限
    @Override
    public void decide(Authentication auth, Object obj, Collection<ConfigAttribute> configAttributes) throws AccessDeniedException, InsufficientAuthenticationException {
        if (log.isDebugEnabled()) {
            log.info("判断用户是否有访问权限");
        }
        if (configAttributes == null) {
            return;
        }

        Iterator<ConfigAttribute> ite = configAttributes.iterator();
        while (ite.hasNext()) {
            ConfigAttribute ca = ite.next();
            String needRole = ((SecurityConfig) ca).getAttribute();
            for (GrantedAuthority ga : auth.getAuthorities()) {
                if (needRole.equals(ga.getAuthority())) {

                    return;
                }
            }
        }
        //注意：执行这里，后台是会抛异常的，但是界面会跳转到所配的access-denied-page页面
        throw new AccessDeniedException("没有权限访问!");
    }

    @Override
    public boolean supports(ConfigAttribute attribute) {
        return true;
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return true;
    }
}
