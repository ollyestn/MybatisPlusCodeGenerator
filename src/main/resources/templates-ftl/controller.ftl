package ${controllerPackage};

import ${entityPackage}.${table.className};
import ${servicePackage}.${table.className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ${table.comment!table.className}控制器
 * 
 * @author ${config.author}
 * @date ${date}
 */
@RestController
@RequestMapping("/${table.className?uncap_first}")
public class ${table.className}Controller {

    @Autowired
    private ${table.className}Service ${table.className?uncap_first}Service;

    /**
     * 根据ID查询
     */
    @GetMapping("/{${table.primaryKey.fieldName}}")
    public ResponseEntity<Map<String, Object>> getById(@PathVariable ${table.primaryKey.javaType} ${table.primaryKey.fieldName}) {
        Map<String, Object> result = new HashMap<>();
        try {
            ${table.className} ${table.className?uncap_first} = ${table.className?uncap_first}Service.getById(${table.primaryKey.fieldName});
            if (${table.className?uncap_first} != null) {
                result.put("code", 200);
                result.put("message", "查询成功");
                result.put("data", ${table.className?uncap_first});
            } else {
                result.put("code", 404);
                result.put("message", "数据不存在");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "查询失败: " + e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 查询所有
     */
    @GetMapping
    public ResponseEntity<Map<String, Object>> listAll() {
        Map<String, Object> result = new HashMap<>();
        try {
            List<${table.className}> list = ${table.className?uncap_first}Service.listAll();
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", list);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "查询失败: " + e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 分页查询
     */
    @GetMapping("/page")
    public ResponseEntity<Map<String, Object>> listByPage(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<${table.className}> list = ${table.className?uncap_first}Service.listByPage(pageNum, pageSize);
            long total = ${table.className?uncap_first}Service.count();
            
            Map<String, Object> pageInfo = new HashMap<>();
            pageInfo.put("list", list);
            pageInfo.put("total", total);
            pageInfo.put("pageNum", pageNum);
            pageInfo.put("pageSize", pageSize);
            pageInfo.put("pages", (total + pageSize - 1) / pageSize);
            
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", pageInfo);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "查询失败: " + e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 新增
     */
    @PostMapping
    public ResponseEntity<Map<String, Object>> save(@RequestBody ${table.className} ${table.className?uncap_first}) {
        Map<String, Object> result = new HashMap<>();
        try {
            boolean success = ${table.className?uncap_first}Service.save(${table.className?uncap_first});
            if (success) {
                result.put("code", 200);
                result.put("message", "保存成功");
            } else {
                result.put("code", 500);
                result.put("message", "保存失败");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "保存失败: " + e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 更新
     */
    @PutMapping("/{${table.primaryKey.fieldName}}")
    public ResponseEntity<Map<String, Object>> updateById(
            @PathVariable ${table.primaryKey.javaType} ${table.primaryKey.fieldName},
            @RequestBody ${table.className} ${table.className?uncap_first}) {
        Map<String, Object> result = new HashMap<>();
        try {
            ${table.className?uncap_first}.set${table.primaryKey.fieldName?cap_first}(${table.primaryKey.fieldName});
            boolean success = ${table.className?uncap_first}Service.updateById(${table.className?uncap_first});
            if (success) {
                result.put("code", 200);
                result.put("message", "更新成功");
            } else {
                result.put("code", 500);
                result.put("message", "更新失败");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "更新失败: " + e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 根据ID删除
     */
    @DeleteMapping("/{${table.primaryKey.fieldName}}")
    public ResponseEntity<Map<String, Object>> removeById(@PathVariable ${table.primaryKey.javaType} ${table.primaryKey.fieldName}) {
        Map<String, Object> result = new HashMap<>();
        try {
            boolean success = ${table.className?uncap_first}Service.removeById(${table.primaryKey.fieldName});
            if (success) {
                result.put("code", 200);
                result.put("message", "删除成功");
            } else {
                result.put("code", 500);
                result.put("message", "删除失败");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "删除失败: " + e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/batch")
    public ResponseEntity<Map<String, Object>> removeByIds(@RequestBody List<${table.primaryKey.javaType}> ids) {
        Map<String, Object> result = new HashMap<>();
        try {
            boolean success = ${table.className?uncap_first}Service.removeByIds(ids);
            if (success) {
                result.put("code", 200);
                result.put("message", "批量删除成功");
            } else {
                result.put("code", 500);
                result.put("message", "批量删除失败");
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "批量删除失败: " + e.getMessage());
        }
        return ResponseEntity.ok(result);
    }
}