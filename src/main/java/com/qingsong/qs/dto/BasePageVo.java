package com.qingsong.qs.dto;

public class BasePageVo {
	private Integer pageSize = 10;
	private Integer currentPage = 1;
	private Integer startNum;
	private Integer pageCount = 0;

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setStartNum(Integer startNum) {
		this.startNum = startNum;
	}

	public void setCurrentPage(Integer currentPage) {
		if (currentPage == null) {
			this.currentPage = 1;
		} else {
			this.currentPage = currentPage;
		}
	}

	public Integer getStartNum() {
		if (startNum == null) {
			startNum = (currentPage - 1) * pageSize;
		}
		return startNum;
	}

	public Integer getPageCount() {
		return pageCount;
	}

	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}

}
