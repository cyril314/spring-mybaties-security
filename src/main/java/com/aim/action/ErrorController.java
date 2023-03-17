package com.aim.action;

import com.common.base.BaseController;
import com.common.base.PatternAndView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @AUTO 错误页面控制器
 * @Author AIM
 * @DATE 2018/7/12
 */
@Controller
public class ErrorController extends BaseController {

    private static Logger logger = LoggerFactory.getLogger(ErrorController.class);

    /**
     * 无权限错误页面
     */
    @RequestMapping(value = "/denied")
    public ModelAndView denied(HttpServletRequest request, HttpServletResponse response) {
        logger.debug("================ 无权限错误页面 ================");
        return new PatternAndView("denied", request, response);
    }

    /**
     * 超时页面
     */
    @RequestMapping(value = "/overtime")
    public void sessionOvertime(HttpServletRequest request, HttpServletResponse response) {
        logger.debug("================ 超时页面 ================");
        try {
            if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) { // ajax 超时处理
                Map<String, String> map = new HashMap<>();
                map.put("code", "401");
                map.put("msg", "session失效");
                String json = getJsonObject(map);
                writeJson(response, json);
            } else {
                response.sendRedirect("/views/overtime.jsp");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
