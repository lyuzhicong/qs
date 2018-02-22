package com.qingsong.qs.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ArticleVo extends BasePageVo {
	private Long id;
	private String title;
	private String content;
	private Date date;
	private String path;
	private String littleTitle;
	
	private Integer status;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getLittleTitle() {
		return littleTitle;
	}

	public void setLittleTitle(String littleTitle) {
		this.littleTitle = littleTitle;
	}

	public String getDateText() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		if (date != null) {
			return sdf.format(date);
		}
		return null;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}
