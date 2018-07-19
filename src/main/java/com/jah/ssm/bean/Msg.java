package com.jah.ssm.bean;

import java.util.HashMap;
import java.util.Map;

import com.github.pagehelper.PageInfo;

/**通用的返回类
 * @author hzf
 *
 */
public class Msg {
	//返回码：200成功，500失败
	private String code;
	//提示信息
	private String message;
	//返回给用户的数据
	private Map<String, Object> map = new HashMap<String, Object>();

	private static Msg result;
	
	public static Msg success(){
		result=new Msg();
		result.setCode("200");
		result.setMessage("处理成功!");
		return result;
	}
	
	public static Msg fail(){
		result=new Msg();
		result.setCode("500");
		result.setMessage("处理失败!");
		return result;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	
	//可以链式操作：Msg.success().add("pageInfo",pageInfo).add(...).add(...)
	public Msg add(String key, Object value) {
		this.getMap().put(key, value);
		return this;
	}
}
