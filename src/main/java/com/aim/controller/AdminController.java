package com.aim.controller;

import com.aim.model.SysUser;
import com.aim.service.SysUserService;
import com.common.base.BaseController;
import com.common.base.PatternAndView;
import com.common.utils.MD5Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * @AUTO 用户管理操作
 * @Author AIM
 * @DATE 2018/5/4
 */
@Controller
@RequestMapping("/sysuser")
public class AdminController extends BaseController {

    private static Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private SysUserService adminService;

    @GetMapping(value = "/list")
    public ModelAndView listPage() {
        return new PatternAndView("/admin/user/list");
    }

    /**
     * 用户列表
     */
    @PostMapping(value = "/list")
    @ResponseBody
    public void listPage(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        List<SysUser> listAll = adminService.findList(map);
        writeObjectAsJson(response, listAll);
    }

    @GetMapping(value = "/edit")
    public ModelAndView edit(Long id) {
        ModelAndView pv = new PatternAndView("/admin/user/edit");
        if (isNotNullOrEmpty(id)) {
            SysUser sysUser = this.adminService.get(id);
            pv.addObject("user", sysUser);
        }
        return pv;
    }

    /**
     * 保存&更新
     */
    @PostMapping(value = "/save")
    @ResponseBody
    public void saveOrUpdate(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        SysUser sysUser = converter2Map(map, SysUser.class);
        map.clear();
        try {
            if (isEmpty(sysUser.getId())) {
                sysUser.setPassword(MD5Util.MD5Encode(sysUser.getPassword()));
                sysUser.setIsys(0);
                sysUser.setEnabled(true);
                sysUser.setCreatdate(new Date());
            } else {
                SysUser old = this.adminService.get(sysUser.getId());
                if (!old.getPassword().equals(sysUser.getPassword())) {
                    sysUser.setPassword(MD5Util.MD5Encode(sysUser.getPassword()));
                }
            }
            this.adminService.save(sysUser);

            map.put("code", "200");
            map.put("msg", "保存成功");
        } catch (Exception e) {
            map.put("code", "201");
            map.put("msg", "保存失败");
        }

        writeObjectAsJson(response, map);
    }

    /**
     * 删除
     */
    @PostMapping(value = "/delete")
    @ResponseBody
    public void delete(@RequestParam("id") String[] id, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<>();
        if (isNotEmpty(id)) {
            int delete = this.adminService.batchDelete(id);
            if (delete > 0) {
                map.put("code", "200");
                map.put("msg", "删除成功");
            } else {
                map.put("code", "201");
                map.put("msg", "删除失败");
            }
        } else {
            map.put("code", "202");
            map.put("msg", "参数为空");
        }
        writeObjectAsJson(response, map);
    }
}
