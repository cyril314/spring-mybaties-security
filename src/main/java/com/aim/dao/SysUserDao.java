package com.aim.dao;

import com.aim.model.SysUser;
import com.common.base.BaseCrudDao;
import org.apache.ibatis.annotations.Mapper;

/**
 * @AUTO 用户操控接口
 * @Author AIM
 * @DATE 2018/05/15
 */
@Mapper
public interface SysUserDao extends BaseCrudDao<SysUser> {

}