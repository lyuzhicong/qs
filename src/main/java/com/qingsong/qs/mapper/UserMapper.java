package com.qingsong.qs.mapper;

import java.util.List;

import com.qingsong.qs.dto.UserVo;

public interface UserMapper {
	public List<UserVo> getUserVoList();
	
	public int login(UserVo userVo);
}
