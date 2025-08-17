package com.xyzy.fusion.mybatispluscodegenerator;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.StrategyConfig;
import com.baomidou.mybatisplus.generator.config.builder.CustomFile;
import com.baomidou.mybatisplus.generator.config.rules.DateType;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.baomidou.mybatisplus.generator.engine.VelocityTemplateEngine;
import com.baomidou.mybatisplus.generator.fill.Column;
import com.baomidou.mybatisplus.generator.fill.Property;

import java.io.File;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class MyCodeGenerator {
    String url = "jdbc:mysql://localhost:3316/spdb?serverTimezone=GMT%2B8";
    String username = "root";
    String password = "root";
    //String packageName = "com.xyzy.fusion.spatial.spatialcapsule";
    String packageName = "cn.com.taiji.fusion.spatial.spatialcapsule";
    String outputDir = "D:\\codegen-output\\2"; //System.getProperty("user.dir") + "src/main/java";

    void GenCode(){
        // 使用 FastAutoGenerator 快速配置代码生成器
        createDirs(outputDir + "\\java");
        createDirs(outputDir + "\\resources\\mapper");

        // 数据源配置
        FastAutoGenerator.create(url, username, password)
            .globalConfig(builder -> {
                builder.author("csm")        // 设置作者
                        //.enableSwagger()        // 开启 swagger 模式 默认值:false
                        .enableSpringdoc()        // 开启 springdoc 模式 默认值:false
                        //.disableOpenDir()       // 禁止打开输出目录 默认值:true
                        .commentDate("yyyy-MM-dd") // 注释日期
                        .dateType(DateType.ONLY_DATE)   //定义生成的实体类中日期类型 DateType.ONLY_DATE 默认值: DateType.TIME_PACK
                        .outputDir(outputDir + "/java"); // 指定输出目录
            })

            .packageConfig(builder -> {
                builder.parent(packageName) // 父包模块名
                    .controller("controller")   //Controller 包名 默认值:controller
                    .entity("entity")           //Entity 包名 默认值:entity
                    .service("service")         //Service 包名 默认值:service
                    .serviceImpl("service.impl") // 设置 Service 实现类包名
                    .mapper("mapper")           //Mapper 包名 默认值:mapper
                    .xml("mappers")             // 设置 Mapper XML 文件包名
                    //.other("model")
                    //.moduleName("xxx")        // 设置父包模块名 默认值:无
                    .pathInfo(Collections.singletonMap(OutputFile.xml, outputDir + "/resources/mapper")); // 设置mapperXml生成路径
                                                                                                          //默认存放在mapper的xml下
            })

//            .injectionConfig(consumer -> {
//                Map<String, String> customFile = new HashMap<>();
//                // DTO、VO
//                customFile.put("DTO.java", "/templates/entityDTO.java.ftl");
//                customFile.put("VO.java", "/templates/entityVO.java.ftl");  // templates
//                consumer.customFile(customFile);
//            })

            //entity: 对应数据库表模型，
            //vo: 对应需要返回到前端的数据模型 ， 通常使用于后端返回的数据类
            //dto: 对应后台内部调用的数据模型， 通常使用于前端传入的参数类

            .injectionConfig(injectConfig -> {
                Map<String,Object> customMap = new HashMap<>();
                customMap.put("packageName",packageName);
                injectConfig.customMap(customMap); //注入自定义属性
                injectConfig.customFile(new CustomFile.Builder()
                        .fileName("DTO.java") //文件名称
                        .templatePath("templates/entityDTO.java.ftl") //指定生成模板路径
                        .packageName("model.dto") //包名,自3.5.10开始,可通过在package里面获取自定义包全路径,低版本下无法获取,示例:package.entityDTO
                        .build());
                injectConfig.customFile(new CustomFile.Builder()
                        .fileName("VO.java") //文件名称
                        .templatePath("templates/entityVO.java.ftl") //指定生成模板路径
                        .packageName("model.vo") //包名,自3.5.10开始,可通过在package里面获取自定义包全路径,低版本下无法获取,示例:package.entityVO
                        .build());
            })

            .strategyConfig(builder -> {
                // "spb_unit", "dev_to_spb", "obj_to_spb", "jk_dev_to_spb", "jk_obj_to_spb", "jk_spaceidinfo", "spcode_engineer", "spcode_project", "spcode_unit_info", "spcode_floor_info"
                builder.addInclude("spb_unit", "dev_to_spb", "obj_to_spb", "jk_dev_to_spb", "jk_obj_to_spb", "jk_spaceidinfo", "spcode_engineer", "spcode_project", "spcode_unit_info", "spcode_floor_info") // 设置需要生成的表名 可边长参数“user”, “user1”
                    .addTablePrefix("tb_", "gms_", "t_") // 设置过滤表前缀
                    .serviceBuilder()                    //service策略配置
                    .formatServiceFileName("%sService")
                    .formatServiceImplFileName("%sServiceImpl")
                    .entityBuilder()// 实体类策略配置
                    .idType(IdType.ASSIGN_ID)//主键策略  雪花算法自动生成的id
                    .addTableFills(new Column("create_time", FieldFill.INSERT)) // 自动填充配置
                    .addTableFills(new Property("update_time", FieldFill.INSERT_UPDATE))
                    .enableLombok() //开启lombok
                    .enableTableFieldAnnotation() // 启用字段注解
                    .logicDeleteColumnName("deleted")// 说明逻辑删除是哪个字段
                    .enableTableFieldAnnotation()// 属性加上注解说明
                    .controllerBuilder() //controller 策略配置
                    .formatFileName("%sController")
                    .enableRestStyle() // 开启REST风格 RestController注解，
                    .mapperBuilder()// mapper策略配置
                    .formatMapperFileName("%sMapper")
                    .enableMapperAnnotation()//@mapper注解开启
                    .formatXmlFileName("%sMapper");
            })

            // 使用Freemarker引擎模板，默认的是Velocity引擎模板
            //.templateEngine(new FreemarkerTemplateEngine())
            .templateEngine(new EnhanceFreemarkerTemplateEngine())
            .execute();

        System.out.println("代码生成完成！");
    }

    void createDirs(String dirs){
        //“D:\data111”目录现在不存在
        String dirStr = "D:\\data111\\test";
        File directory = new File(dirs);

        //mkdir
        //boolean hasSucceeded = directory.mkdir();
        //System.out.println("创建文件夹结果（不含父文件夹）：" + hasSucceeded);

        //mkdirs
        boolean hasSucceeded = directory.mkdirs();
        System.out.println("创建文件夹结果（包含父文件夹）：" + hasSucceeded);
    }
}
