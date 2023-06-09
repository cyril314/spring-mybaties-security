package com.aim.action;

import com.common.base.BaseController;
import com.common.base.PatternAndView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @AUTO 后台管理登陆页
 * @Author AIM
 * @DATE 2018/4/18
 */
@Controller
public class LoginController extends BaseController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * @return 返回登陆页
     */
    @RequestMapping(value = {"/login", "/login.html"})
    public ModelAndView login() {
        return new PatternAndView("/front/login");
    }

    /**
     * @return 退出, 跳转到登陆页面
     */
    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/login";
    }

}
