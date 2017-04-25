package com.qingsong.qs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingsong.qs.dto.UserVo;
import com.qingsong.qs.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	public UserMapper userMapper;

	@Override
	public List<UserVo> getUserVoList() {
		return userMapper.getUserVoList();
	}
}
