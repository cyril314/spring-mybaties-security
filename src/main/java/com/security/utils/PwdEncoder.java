package com.security.utils;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.DigestUtils;

import java.io.UnsupportedEncodingException;

/**
 * @AUTO 安全框架密码加密算法
 * @Author AIM
 * @DATE 2017/11/10
 */
public class PwdEncoder implements PasswordEncoder {

    @Override
    public String encode(CharSequence rawPassword) {
        try {
            // MD5加密密码
            return DigestUtils.md5DigestAsHex(rawPassword.toString().getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        return encode(rawPassword).equals(encodedPassword);
    }
}
