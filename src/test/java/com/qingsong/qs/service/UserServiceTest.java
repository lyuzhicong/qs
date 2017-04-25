package com.qingsong.qs.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.qingsong.qs.baseTest.SpringTestCase;
import com.qingsong.qs.dto.UserVo;

/**
 * 功能概要：UserService单元测试
 */
public class UserServiceTest extends SpringTestCase {
	
	Logger logger = Logger.getLogger(UserServiceTest.class);
	
	@Autowired
	private UserService userService;

	@Test
	public void selectUserByIdTest() {
		List<UserVo> userVoList = userService.getUserVoList();
		UserVo userVo = userVoList.get(0);
		System.out.println("查找结果" + userVo.getId() + ":" + userVo.getName() + "：" + userVo.getPassword());
	}

}