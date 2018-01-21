package com.qingsong.qs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/qsManager")
public class qsController {

	@RequestMapping("/edit/console")
	public String getQsManage() {
		return "qsManager";
	}
}
