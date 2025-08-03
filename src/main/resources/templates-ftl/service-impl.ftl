package ${serviceImplPackage};

import ${entityPackage}.${table.className};
import ${mapperPackage}.${table.className}Mapper;
import ${servicePackage}.${table.className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ${table.comment!table.className}服务实现类
 * 
 * @author ${config.author}
 * @date ${date}
 */
@Service
public class ${table.className}ServiceImpl implements ${table.className}Service {

    @Autowired
    private ${table.className}Mapper ${table.className?uncap_first}Mapper;

    @Override
    public ${table.className} getById(${table.primaryKey.javaType} ${table.primaryKey.fieldName}) {
        return ${table.className?uncap_first}Mapper.selectById(${table.primaryKey.fieldName});
    }

    @Override
    public List<${table.className}> listAll() {
        return ${table.className?uncap_first}Mapper.selectAll();
    }

    @Override
    public List<${table.className}> listByPage(int pageNum, int pageSize) {
        int offset = (pageNum - 1) * pageSize;
        return ${table.className?uncap_first}Mapper.selectByPage(offset, pageSize);
    }

    @Override
    public long count() {
        return ${table.className?uncap_first}Mapper.countAll();
    }

    @Override
    public boolean save(${table.className} ${table.className?uncap_first}) {
        return ${table.className?uncap_first}Mapper.insert(${table.className?uncap_first}) > 0;
    }

    @Override
    public boolean updateById(${table.className} ${table.className?uncap_first}) {
        return ${table.className?uncap_first}Mapper.updateById(${table.className?uncap_first}) > 0;
    }

    @Override
    public boolean removeById(${table.primaryKey.javaType} ${table.primaryKey.fieldName}) {
        return ${table.className?uncap_first}Mapper.deleteById(${table.primaryKey.fieldName}) > 0;
    }

    @Override
    public boolean removeByIds(List<${table.primaryKey.javaType}> ids) {
        return ${table.className?uncap_first}Mapper.deleteByIds(ids) > 0;
    }
}