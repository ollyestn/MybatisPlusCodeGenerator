# MybatisPlusCodeGenerator
Mybatis-plus code generator

# 下载代码
https://github.com/ollyestn/MybatisPlusCodeGenerator.git

# 运行：
cd MybatisPlusCodeGenerator
mvn clean install
mvn spring-boot:run

# 访问：
http://localhost:8080

# 配置：
## com.xyzy.fusion.mybatispluscodegenerator.MyCodeGenerator  
1. 数据源
mysql: ***连接、用户名、密码***

2. 数据库表
add_include(***"user"***) 添加表

3. 生成包名
packageName = ***"com.example.demo"***

4 输出路径
outputDir = ***"d:\\outputDir"***

5. 运行
com.xyzy.fusion.mybatispluscodegenerator.MybatisPlusCodeGeneratorApplication: run/debug




