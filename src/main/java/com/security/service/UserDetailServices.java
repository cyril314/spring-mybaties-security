package com.security.service;

import com.aim.model.SysUser;
import com.aim.service.SysUserService;
import com.security.entity.UserDetail;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @AUTO 从数据库中读入用户的密码，角色信息，是否锁定，账号是否过期
 * @Author AIM
 * @DATE 2018/7/17
 */
@Component
public class UserDetailServices implements UserDetailsService {

    private final Logger log = LogManager.getLogger(this.getClass());

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private SysUserService userService;

    private final String sql = "SELECT a.name FROM `sys_authorities` a, `sys_role_auth` b, `sys_user_role` c, `sys_user` d "
            + "WHERE a.id = b.auth_id AND b.role_id = c.role_id AND c.user_id = d.id AND d.id = ?";

    @Override
    public UserDetail loadUserByUsername(String username) throws UsernameNotFoundException {
        boolean isDebug = log.isDebugEnabled();
        if (isDebug) {
            log.debug("===================================> 登陆访问第二步");
        }
        if (StringUtils.isEmpty(username)) {
            throw new UsernameNotFoundException("用户名不能为空！");
        }
        SysUser user = userService.get(new SysUser(username));
        if (user == null) {
            throw new UsernameNotFoundException("用户名或密码错误！");
        }
        List<Map<String, Object>> mapList = jdbcTemplate.queryForList(sql, user.getId());
        List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
        for (Map<String, Object> map : mapList) {
            if (map != null && map.get("name") != null) {
                GrantedAuthority grantedAuthority = new SimpleGrantedAuthority(map.get("name").toString());
                // 1：此处将权限信息添加到 GrantedAuthority
                // 对象中，在后面进行全权限验证时会使用GrantedAuthority 对象。
                grantedAuthorities.add(grantedAuthority);
            }
        }
        if (isDebug) {
            log.debug("得到其权限：" + grantedAuthorities);
        }
        return new UserDetail(user.getId(), user.getUsername(), user.getPassword(), user.getEnabled(), grantedAuthorities);
    }
}
