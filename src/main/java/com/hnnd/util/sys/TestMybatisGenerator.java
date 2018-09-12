package com.hnnd.util.sys;



import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

public class TestMybatisGenerator {

	
    public static void main(String[] args) throws Exception {
        List<String> warnings = new ArrayList<String>();
        Scanner scanner = new Scanner(System.in);
        boolean overwrite = true;
        InputStream is= TestMybatisGenerator.class.getClassLoader().getResource("generatorConfig1.xml").openStream();
        ConfigurationParser cp = new ConfigurationParser(warnings);

  
        
        	System.out.println("请再三确认生成之后的表是否与之前生成的表重复或者覆盖");
        	System.out.println("1 是  ， 2 否");
        	int flag1 = scanner.nextInt();
        	if(flag1 == 1) {
        Configuration config = cp.parseConfiguration(is);
        is.close();
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
        System.out.println("生成代码成功，刷新项目，查看项目");
        	}else {
        		System.exit(0);
        	}
        }
    
}