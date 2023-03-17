package com.common.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * @AUTO 验证码必填异常
 * @Author AIM
 * @DATE 2018/6/15
 */
public class CaptchaRequiredException extends AuthenticationException {
    private static final long serialVersionUID = 1L;

    public CaptchaRequiredException(String msg) {
        super(msg);
    }
}
