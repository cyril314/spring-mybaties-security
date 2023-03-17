package com.common.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * @AUTO 错误验证异常
 * @Author AIM
 * @DATE 2018/6/15
 */
public class CaptchaIncorrectException extends AuthenticationException {
    private static final long serialVersionUID = 1L;

    public CaptchaIncorrectException(String msg) {
        super(msg);
    }
}
