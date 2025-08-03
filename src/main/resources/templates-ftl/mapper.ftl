package ${mapperPackage};

import ${entityPackage}.${table.className};
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * ${table.comment!table.className}数据访问层
 * 
 * @author ${config.author}
 * @date ${date}
 */
@Mapper
public interface ${table.className}Mapper {

    /**
     * 根据ID查询
     */
    ${table.className} selectById(@Param("${table.primaryKey.fieldName}") ${table.primaryKey.javaType} ${table.primaryKey.fieldName});

    /**
     * 查询所有
     */
    List<${table.className}> selectAll();

    /**
     * 分页查询
     */
    List<${table.className}> selectByPage(@Param("offset") int offset, @Param("limit") int limit);

    /**
     * 统计总数
     */
    long countAll();

    /**
     * 插入
     */
    int insert(${table.className} ${table.className?uncap_first});

    /**
     * 更新
     */
    int updateById(${table.className} ${table.className?uncap_first});

    /**
     * 根据ID删除
     */
    int deleteById(@Param("${table.primaryKey.fieldName}") ${table.primaryKey.javaType} ${table.primaryKey.fieldName});

    /**
     * 批量删除
     */
    int deleteByIds(@Param("ids") List<${table.primaryKey.javaType}> ids);
}