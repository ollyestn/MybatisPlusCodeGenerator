package com.xyzy.fusion.mybatispluscodegenerator;

import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import java.io.File;
import java.util.Map;

/**
 * 代码生成器支持自定义[DTO\VO等]模版
 *
 * @author: csm
 * @since: 2025/8/1 13:00
 */
//@Component
public class EnhanceFreemarkerTemplateEngine extends FreemarkerTemplateEngine {

//    @Override
//    protected void outputCustomFile(Map<String, String> customFile, TableInfo tableInfo, Map<String, Object> objectMap) {
//        String entityName = tableInfo.getEntityName();
//        String otherPath = this.getPathInfo(OutputFile.other);
//        customFile.forEach((key, value) -> {
//            String fileName = String.format(otherPath + File.separator + entityName + "%s", key);
//            this.outputFile(new File(fileName), objectMap, value, true);
//        });
//    }
}
