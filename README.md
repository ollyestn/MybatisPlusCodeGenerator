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


# 手工修改代码
## 1. 实体生成setter、getter、toString方法
将光标移动到需要插入代码的地方，通常为文件末尾，然后按Alt+Insert, 选择setter、getter、toString方法

## 2. 修改created_at、updated_at字段
    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX", timezone = "GMT+8")
    @TableField(value="created_at", fill = FieldFill.INSERT)
    @Schema(description = "创建时间")
    private Date createdAt;

    /**
     * 更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX", timezone = "GMT+8")
    @TableField(value="updated_at", fill = FieldFill.UPDATE)
    @Schema(description = "更新时间")
    private Date updatedAt;

## 3. 注释掉dto、vo类中的@Schema、@TableName、@TableField注解  
时间字段：@JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX", timezone = "GMT+8")
前端以string类型接收，并转化为date类型，再进行格式化：
~~~
// 使用ISO格式时
const formatDate = (isoString:string) => {
  const date = new Date(isoString);
  return new Intl.DateTimeFormat('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    timeZone: 'Asia/Shanghai' // 指定时区
  }).format(date);
};
~~~

