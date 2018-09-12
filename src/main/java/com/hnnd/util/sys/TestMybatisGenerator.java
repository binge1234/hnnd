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

  
        
        	System.out.println("������ȷ������֮��ı��Ƿ���֮ǰ���ɵı��ظ����߸���");
        	System.out.println("1 ��  �� 2 ��");
        	int flag1 = scanner.nextInt();
        	if(flag1 == 1) {
        Configuration config = cp.parseConfiguration(is);
        is.close();
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
        System.out.println("���ɴ���ɹ���ˢ����Ŀ���鿴��Ŀ");
        	}else {
        		System.exit(0);
        	}
        }
    
}