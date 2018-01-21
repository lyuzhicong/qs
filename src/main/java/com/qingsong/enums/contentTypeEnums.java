package com.qingsong.enums;

public enum contentTypeEnums {
	json("application/json;charset=UTF-8");

	private String contentType;

	contentTypeEnums(String contentType) {
		this.contentType = contentType;
	}

	public String getContentType() {
		return contentType;
	}
}
