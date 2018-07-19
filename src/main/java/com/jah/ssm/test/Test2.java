package com.jah.ssm.test;

import org.testng.annotations.Test;

import java.util.UUID;




public class Test2 {
	@Test
	public void testUUID(){
		for(int i=0;i<10;i++){
			String name=UUID.randomUUID().toString().substring(0, 3);
			System.out.println(name);
		}
	}
}
