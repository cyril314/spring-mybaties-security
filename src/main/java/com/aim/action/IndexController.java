package com.aim.action;

import com.common.base.BaseController;
import com.common.base.PatternAndView;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @AUTO 首页
 * @Author AIM
 * @DATE 2018/4/19
 */
@Controller
public class IndexController extends BaseController {

    /**
     * @return 返回主页
     */
    @RequestMapping(value = {"/index", "/index.html"})
    public ModelAndView index() {
        return new PatternAndView("/front/index");
    }

}
