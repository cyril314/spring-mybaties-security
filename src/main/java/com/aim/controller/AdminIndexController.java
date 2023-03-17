package com.aim.controller;

import com.common.base.BaseController;
import com.common.base.PatternAndView;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @AUTO 后台管理首页
 * @Author AIM
 * @DATE 2018/4/19
 */
@Controller
@RequestMapping("/admin")
public class AdminIndexController extends BaseController {

    /**
     * @return 返回后台主页
     */
    @RequestMapping(value = {"/", "/index", "/index.html"})
    public ModelAndView index() {
        return new PatternAndView("/admin/index");
    }

    /**
     * @return 返回后台首页
     */
    @GetMapping(value = "/main")
    public ModelAndView main() {
        return new PatternAndView("/admin/main");
    }
}
