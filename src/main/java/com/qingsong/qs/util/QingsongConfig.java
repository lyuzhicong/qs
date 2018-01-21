package com.qingsong.qs.util;

import java.io.InputStream;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class QingsongConfig {
	private static Logger logger = LoggerFactory.getLogger(QingsongConfig.class);
	public static String IMAGE_PATH;
	private static Properties properties;
	static {
		try {
			properties = new Properties();
			InputStream in = QingsongConfig.class.getClassLoader().getResourceAsStream("qs-config.properties");

			properties.load(in);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}

		IMAGE_PATH = getProperty("image.path", "/usr/local/qingsong/image");
	}

	public static String getProperty(String key, String defaultValue) {
		String value = properties.getProperty(key, defaultValue);
		if (value != null) {
			value = value.trim();
		}
		return value;
	}
}
