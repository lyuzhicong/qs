package com.qingsong.qs.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class QingsongConfig {
	private static Logger logger = LoggerFactory.getLogger(QingsongConfig.class);
	public static final String IMAGE_PATH = getProperty("image.path", "/a8root/web/qingsong/image");
	
	private QingsongConfig() {
		
	}
	private static String getProperty(String key, String defaultValue) {
		InputStream in = QingsongConfig.class.getClassLoader().getResourceAsStream("config/qs-config.properties");
		String value = null;
		Properties properties = new Properties();
		try {
			if(in != null) {
				properties.load(in);
				value = properties.getProperty(key, defaultValue);
				if (value != null) {
					value = value.trim();
				}
			} else {
				value = defaultValue;
			}
		} catch (Exception e) {
			logger.error("load configFile : qs-config.properties error: " + e.getMessage(), e);
		} finally {
			try {
				if(in != null) {
					in.close();
				}
			} catch (IOException e) {
				logger.error(e.getMessage(), e);
			}
		}
		return value;
	}
}
