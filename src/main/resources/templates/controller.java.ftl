package ${package.Controller};

import ${package.Entity}.${table.entityName};
import ${package.Service}.${table.entityName}Service;
import ${package.Parent}.<#if package.ModuleName?? && package.ModuleName != "">${package.ModuleName}.</#if>model.vo.${table.entityName}VO;
import ${package.Parent}.<#if package.ModuleName?? && package.ModuleName != "">${package.ModuleName}.</#if>model.dto.${table.entityName}DTO;
import ${package.Parent}.common.ApiResponse;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.RequestMapping;
<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>


/**
 * <p>
 * ${table.comment!table.entityName}控制器
 * </p>
 * 
 * @author ${author}
 * @since ${date}
 */
@Tag(name = "${table.comment}")
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("<#if package.ModuleName?? && package.ModuleName != "">/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle>${controllerMappingHyphen}<#else>${table.entityName?uncap_first}</#if>")
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
<#else>
public class ${table.controllerName} {
</#if>

    @Autowired
    private ${table.entityName}Service ${table.entityName?uncap_first}Service;

    /**
     * 根据ID查询:
	 * table.primaryKey.javaType
	 * table.primaryKey.fieldName,
     */
    @GetMapping("/{${table.indexList[0].columnName}}")
    public ApiResponse<${table.entityName}VO> getById(@PathVariable Long ${table.indexList[0].columnName}) {
        try {
            ${table.entityName} ${table.entityName?uncap_first} = ${table.entityName?uncap_first}Service.getById(${table.indexList[0].columnName});
            if (${table.entityName?uncap_first} != null) {
                ${table.entityName}VO ${table.entityName?uncap_first}VO = new ${table.entityName}VO();
                BeanUtils.copyProperties(${table.entityName?uncap_first}, ${table.entityName?uncap_first}VO);

                return ApiResponse.success(${table.entityName?uncap_first}VO);
            } else {
                return new ApiResponse<${table.entityName}VO>(404, "数据不存在", null);
            }
        } catch (Exception e) {
            return ApiResponse.error(500, "查询失败: " + e.getMessage());
        }
    }

    /**
     * 查询所有
     */
    @GetMapping
    public ApiResponse<List<${table.entityName}VO>> listAll() {
        try {
            List<${table.entityName}VO> list = ${table.entityName?uncap_first}Service.list().stream()
                .map(${table.entityName?uncap_first} -> {
                    ${table.entityName}VO vo = new ${table.entityName}VO();
                    BeanUtils.copyProperties(${table.entityName?uncap_first}, vo); // Spring 的 BeanUtils 不抛受检异常
                    return vo;
                })
                .collect(Collectors.toList());
            return ApiResponse.success(list);
        } catch (Exception e) {
            return ApiResponse.error(500, "查询失败: " + e.getMessage());
        }

        //ApiResponse<List<${table.entityName}VO>> result = null;
        //return ResponseEntity.ok(result);
    }

    /**
     * 分页查询
     */
    @GetMapping("/page")
    public ApiResponse<Map<String, Object>> listByPage(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        try {
            //List<${table.entityName}VO> list = ${table.entityName?uncap_first}Service.listByPage(pageNum, pageSize);
            Page<${table.entityName}> page = new Page<>(pageNum, pageSize);
            List<${table.entityName}> list = ${table.entityName?uncap_first}Service.list(page);
            long total = ${table.entityName?uncap_first}Service.count();
            
            Map<String, Object> pageInfo = new HashMap<>();
            pageInfo.put("list", list);
            pageInfo.put("total", total);
            pageInfo.put("pageNum", pageNum);
            pageInfo.put("pageSize", pageSize);
            pageInfo.put("pages", (total + pageSize - 1) / pageSize);

            return ApiResponse.success(pageInfo);
        } catch (Exception e) {
            return ApiResponse.error(500, "查询失败: " + e.getMessage());
        }
    }

    /**
     * 新增
     */
    @PostMapping
    public ApiResponse<${table.entityName}> save(@RequestBody ${table.entityName} ${table.entityName?uncap_first}) {
        try {
            boolean success = ${table.entityName?uncap_first}Service.save(${table.entityName?uncap_first});
            if (success) {
                return ApiResponse.success(${table.entityName?uncap_first});
            } else {
                return new ApiResponse<${table.entityName}>(500, "保存失败" , null);
            }
        } catch (Exception e) {
            return ApiResponse.error(500, "保存失败: " + e.getMessage());
        }
    }

    /**
     * 更新
	 * table.primaryKey.javaType
	 * table.primaryKey.fieldName
     * Map<String, Object>
     */
    @PutMapping("/{${table.indexList[0].columnName}}")
    public ApiResponse<${table.entityName}> updateById(
            @PathVariable Long ${table.indexList[0].columnName},
            @RequestBody ${table.entityName} ${table.entityName?uncap_first}) {
        try {
            ${table.entityName?uncap_first}.set${table.indexList[0].columnName?cap_first}(${table.indexList[0].columnName});
            boolean success = ${table.entityName?uncap_first}Service.updateById(${table.entityName?uncap_first});
            if (success) {
               return ApiResponse.success(${table.entityName?uncap_first});
            } else {
               return new ApiResponse<${table.entityName}>(500, "更新失败" , null);
            }
        } catch (Exception e) {
            return ApiResponse.error(500, "更新失败: " + e.getMessage());
        }
    }

    /**
     * 根据ID删除
	 * table.primaryKey.javaType
	 * table.primaryKey.fieldName
     */
    @DeleteMapping("/{${table.indexList[0].columnName}}")
    public ApiResponse<${table.entityName}> removeById(@PathVariable Long ${table.indexList[0].columnName}) {
        try {
            boolean success = ${table.entityName?uncap_first}Service.removeById(${table.indexList[0].columnName});
            if (success) {
                return new ApiResponse<${table.entityName}>(200, "删除成功" , null);
            } else {
                return new ApiResponse<${table.entityName}>(500, "删除失败" , null);
            }
        } catch (Exception e) {
            return ApiResponse.error(500, "删除失败: " + e.getMessage());
        }
    }

    /**
     * 批量删除
	 * table.primaryKey.javaType
     */
    @DeleteMapping("/batch")
    public ApiResponse<List<${table.entityName}>> removeByIds(@RequestBody List<Long> ids) {
        try {
            boolean success = ${table.entityName?uncap_first}Service.removeByIds(ids);
            if (success) {
               return new ApiResponse<List<${table.entityName}>>(200, "批量删除成功" , null);
            } else {
               return new ApiResponse<List<${table.entityName}>>(500, "批量删除失败" , null);
            }
        } catch (Exception e) {
            return ApiResponse.error(500, "批量删除失败: " + e.getMessage());
        }
    }
}
</#if>