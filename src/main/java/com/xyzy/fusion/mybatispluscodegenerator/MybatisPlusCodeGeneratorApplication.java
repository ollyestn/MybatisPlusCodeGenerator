package com.xyzy.fusion.mybatispluscodegenerator;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MybatisPlusCodeGeneratorApplication {

    public static void main(String[] args) {

//        SpringApplication.run(MybatisPlusCodeGeneratorApplication.class, args);

        MyCodeGenerator myCodeGenerator = new MyCodeGenerator();
        myCodeGenerator.GenCode();
    }

}
