package ${entityPackage};

<#list table.columns as column>
<#if column.javaType == "LocalDate" || column.javaType == "LocalTime" || column.javaType == "LocalDateTime">
import java.time.${column.javaType};
<#break>
</#if>
</#list>
<#list table.columns as column>
<#if column.javaType == "BigDecimal">
import java.math.BigDecimal;
<#break>
</#if>
</#list>

/**
 * ${table.comment!table.className}实体类
 * 
 * @author ${config.author}
 * @date ${date}
 */
public class ${table.className} {

<#list table.columns as column>
    /**
     * ${column.comment!column.fieldName}
     */
    private ${column.javaType} ${column.fieldName};

</#list>
    public ${table.className}() {}

<#list table.columns as column>
    public ${column.javaType} get${column.fieldName?cap_first}() {
        return ${column.fieldName};
    }

    public void set${column.fieldName?cap_first}(${column.javaType} ${column.fieldName}) {
        this.${column.fieldName} = ${column.fieldName};
    }

</#list>
    @Override
    public String toString() {
        return "${table.className}{" +
<#list table.columns as column>
                "${column.fieldName}=" + ${column.fieldName} +
<#if column_has_next>
                ", " +
</#if>
</#list>
                '}';
    }
}