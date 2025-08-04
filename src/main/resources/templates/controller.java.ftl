package ${package.Controller};

import ${package.Entity}.${table.entityName};
import ${package.Service}.${table.entityName}Service;
import ${package.Parent}.<#if package.ModuleName?? && package.ModuleName != "">${package.ModuleName}.</#if>model.vo.${table.entityName}VO;
import ${package.Parent}.<#if package.ModuleName?? && package.ModuleName != "">${package.ModuleName}.</#if>model.dto.${table.entityName}DTO;
import ${package.Parent}.common.ApiResponse;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
//@RequestMapping("/${table.entityName?uncap_first}")
//public class ${table.entityName}Controller {
@RequestMapping("<#if package.ModuleName?? && package.ModuleName != "">/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
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
    public ResponseEntity<ApiResponse<${table.entityName}VO>> getById(@PathVariable Long ${table.indexList[0].columnName}) {
        //Map<String, Object> result = new HashMap<>();
        ApiResponse<${entity}VO> result = null;
        try {
            ${table.entityName}VO ${table.entityName?uncap_first}VO = ${table.entityName?uncap_first}Service.getById(${table.indexList[0].columnName});
            if (${table.entityName?uncap_first}VO != null) {
                //result.put("code", 200);
                //result.put("message", "查询成功");
                //result.put("data", ${table.entityName?uncap_first}VO);
                result = new ApiResponse<${entity}VO>(true, "200, 查询成功", userVO);
            } else {
                //result.put("code", 404);
                //result.put("message", "数据不存在");
                result = new ApiResponse<${entity}VO>(false, "404, 数据不存在", null);
            }
        } catch (Exception e) {
            //result.put("code", 500);
            //result.put("message", "查询失败: " + e.getMessage());
            result = new ApiResponse<${entity}VO>(false, "500, 查询失败", null);
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 查询所有
     */
    @GetMapping
    public ResponseEntity<ApiResponse<List<${table.entityName}VO>>> listAll() {
        //Map<String, Object> result = new HashMap<>();
        ApiResponse<List<${table.entityName}VO>> result = null;
        try {
            List<${table.entityName}VO> list = ${table.entityName?uncap_first}Service.listObjs();
            //result.put("code", 200);
            //result.put("message", "查询成功");
            //result.put("data", list);
            result = new ApiResponse<List<${table.entityName}VO>>(true, "200, 查询成功", list);
        } catch (Exception e) {
            //result.put("code", 500);
            //result.put("message", "查询失败: " + e.getMessage());
            result = new ApiResponse<List<${table.entityName}VO>>(false, "500, 查询失败", null);
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 分页查询
     */
    @GetMapping("/page")
    public ResponseEntity<ApiResponse<Map<String, Object>>> listByPage(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        //Map<String, Object> result = new HashMap<>();
        ApiResponse<Map<String, Object>> result = null;
        try {
            List<${table.entityName}VO> list = ${table.entityName?uncap_first}Service.listByPage(pageNum, pageSize);
            long total = ${table.entityName?uncap_first}Service.count();
            
            Map<String, Object> pageInfo = new HashMap<>();
            pageInfo.put("list", list);
            pageInfo.put("total", total);
            pageInfo.put("pageNum", pageNum);
            pageInfo.put("pageSize", pageSize);
            pageInfo.put("pages", (total + pageSize - 1) / pageSize);
            
            //result.put("code", 200);
            //result.put("message", "查询成功");
            //result.put("data", pageInfo);
            result = new ApiResponse<Map<String, Object>>(false, "200, 查询成功", pageInfo);
        } catch (Exception e) {
            //result.put("code", 500);
            //result.put("message", "查询失败: " + e.getMessage());
            result = new ApiResponse<Map<String, Object>>(false, "500, 查询失败", null);
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 新增
     */
    @PostMapping
    public ResponseEntity<ApiResponse<String>> save(@RequestBody ${table.entityName} ${table.entityName?uncap_first}) {
        //Map<String, Object> result = new HashMap<>();
        ApiResponse<String> result = null;
        try {
            boolean success = ${table.entityName?uncap_first}Service.save(${table.entityName?uncap_first});
            if (success) {
                //result.put("code", 200);
                //result.put("message", "保存成功");
                result = new ApiResponse<String>(false, "200, 保存成功" , null);
            } else {
                //result.put("code", 500);
                //result.put("message", "保存失败");
                result = new ApiResponse<String>(false, "500, 保存失败" , null);
            }
        } catch (Exception e) {
            //result.put("code", 500);
            //result.put("message", "保存失败: " + e.getMessage());
            result = new ApiResponse<String>(false, "500, 保存失败: " + e.getMessage(), null);
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 更新
	 * table.primaryKey.javaType
	 * table.primaryKey.fieldName
     * Map<String, Object>
     */
    @PutMapping("/{${table.indexList[0].columnName}}")
    public ResponseEntity<ApiResponse<String>> updateById(
            @PathVariable Long ${table.indexList[0].columnName},
            @RequestBody ${table.entityName} ${table.entityName?uncap_first}) {
        //Map<String, Object> result = new HashMap<>();
        ApiResponse<String> result = null;
        try {
            ${table.entityName?uncap_first}.set${table.indexList[0].columnName?cap_first}(${table.indexList[0].columnName});
            boolean success = ${table.entityName?uncap_first}Service.updateById(${table.entityName?uncap_first});
            if (success) {
                //result.put("code", 200);
                //result.put("message", "更新成功");
                result = new ApiResponse<String>(true, "200, 更新成功", null);
            } else {
                //result.put("code", 500);
                //result.put("message", "更新失败");
                result = new ApiResponse<String>(false, "500, 更新失败", null);
            }
        } catch (Exception e) {
            //result.put("code", 500);
            //result.put("message", "更新失败: " + e.getMessage());
            result = new ApiResponse<String>(false, "500, 更新失败: " + e.getMessage(), null);
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 根据ID删除
	 * table.primaryKey.javaType
	 * table.primaryKey.fieldName
     */
    @DeleteMapping("/{${table.indexList[0].columnName}}")
    public ResponseEntity<ApiResponse<Boolean>> removeById(@PathVariable Long ${table.indexList[0].columnName}) {
        //Map<String, Object> result = new HashMap<>();
        ApiResponse<Boolean> result = null;
        try {
            boolean success = ${table.entityName?uncap_first}Service.removeById(${table.indexList[0].columnName});
            if (success) {
                //result.put("code", 200);
                //result.put("message", "删除成功");
                result = new ApiResponse<Boolean>(true, "200, 删除成功", true);
            } else {
                //result.put("code", 500);
                //result.put("message", "删除失败");
                result = new ApiResponse<Boolean>(false, "500, 删除失败", false);
            }
        } catch (Exception e) {
            //result.put("code", 500);
            //result.put("message", "删除失败: " + e.getMessage());
            result = new ApiResponse<Boolean>(false, "500, 删除失败: " + e.getMessage(), false);
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 批量删除
	 * table.primaryKey.javaType
     */
    @DeleteMapping("/batch")
    public ResponseEntity<ApiResponse<Boolean>> removeByIds(@RequestBody List<Long> ids) {
        //Map<String, Object> result = new HashMap<>();
        ApiResponse<Boolean> result = null;
        try {
            boolean success = ${table.entityName?uncap_first}Service.removeByIds(ids);
            if (success) {
                //result.put("code", 200);
                //result.put("message", "批量删除成功");
                result = new ApiResponse<Boolean>(true, "200, 批量删除成功", true);
            } else {
                //result.put("code", 500);
                //result.put("message", "批量删除失败");
                result = new ApiResponse<Boolean>(false, "500, 批量删除失败", true);
            }
        } catch (Exception e) {
            //result.put("code", 500);
            //result.put("message", "批量删除失败: " + e.getMessage());
            result = new ApiResponse<Boolean>(false, "500, 批量删除失败: " + e.getMessage(), false);
        }
        return ResponseEntity.ok(result);
    }
}
</#if>