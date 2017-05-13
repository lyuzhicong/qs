package com.qingsong.qs.util;

public class Toolkit {
	public static int getPageCount(int rownum, int pageSize) {
		int pageCount = rownum / pageSize + (rownum % pageSize > 0 ? 1 : 0);
		return pageCount;
	}
}
