package ${servicePackage};

import ${entityPackage}.${table.className};

import java.util.List;

/**
 * ${table.comment!table.className}服务接口
 * 
 * @author ${config.author}
 * @date ${date}
 */
public interface ${table.className}Service {

    /**
     * 根据ID查询
     */
    ${table.className} getById(${table.primaryKey.javaType} ${table.primaryKey.fieldName});

    /**
     * 查询所有
     */
    List<${table.className}> listAll();

    /**
     * 分页查询
     */
    List<${table.className}> listByPage(int pageNum, int pageSize);

    /**
     * 统计总数
     */
    long count();

    /**
     * 保存
     */
    boolean save(${table.className} ${table.className?uncap_first});

    /**
     * 更新
     */
    boolean updateById(${table.className} ${table.className?uncap_first});

    /**
     * 根据ID删除
     */
    boolean removeById(${table.primaryKey.javaType} ${table.primaryKey.fieldName});

    /**
     * 批量删除
     */
    boolean removeByIds(List<${table.primaryKey.javaType}> ids);
}