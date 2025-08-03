<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${mapperPackage}.${table.className}Mapper">

    <!-- 结果映射 -->
    <resultMap id="BaseResultMap" type="${entityPackage}.${table.className}">
<#list table.columns as column>
        <#if column.primaryKey>
        <id column="${column.columnName}" property="${column.fieldName}" />
        <#else>
        <result column="${column.columnName}" property="${column.fieldName}" />
        </#if>
</#list>
    </resultMap>

    <!-- 基础字段 -->
    <sql id="Base_Column_List">
        <#list table.columns as column>${column.columnName}<#if column_has_next>, </#if></#list>
    </sql>

    <!-- 根据ID查询 -->
    <select id="selectById" resultMap="BaseResultMap">
        SELECT <include refid="Base_Column_List" />
        FROM ${table.tableName}
        WHERE ${table.primaryKey.columnName} = ${r"#{"}${table.primaryKey.fieldName}${r"}"}
    </select>

    <!-- 查询所有 -->
    <select id="selectAll" resultMap="BaseResultMap">
        SELECT <include refid="Base_Column_List" />
        FROM ${table.tableName}
        ORDER BY ${table.primaryKey.columnName} DESC
    </select>

    <!-- 分页查询 -->
    <select id="selectByPage" resultMap="BaseResultMap">
        SELECT <include refid="Base_Column_List" />
        FROM ${table.tableName}
        ORDER BY ${table.primaryKey.columnName} DESC
        LIMIT ${r"#{offset}"}, ${r"#{limit}"}
    </select>

    <!-- 统计总数 -->
    <select id="countAll" resultType="long">
        SELECT COUNT(1) FROM ${table.tableName}
    </select>

    <!-- 插入 -->
    <insert id="insert"<#if table.primaryKey.autoIncrement> useGeneratedKeys="true" keyProperty="${table.primaryKey.fieldName}"</#if>>
        INSERT INTO ${table.tableName}
        <trim prefix="(" suffix=")" suffixOverrides=",">
<#list table.columns as column>
    <#if !column.autoIncrement>
            <if test="${column.fieldName} != null">
                ${column.columnName},
            </if>
    </#if>
</#list>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
<#list table.columns as column>
    <#if !column.autoIncrement>
            <if test="${column.fieldName} != null">
                ${r"#{"}${column.fieldName}${r"}"},
            </if>
    </#if>
</#list>
        </trim>
    </insert>

    <!-- 更新 -->
    <update id="updateById">
        UPDATE ${table.tableName}
        <set>
<#list table.columns as column>
    <#if !column.primaryKey && !column.autoIncrement>
            <if test="${column.fieldName} != null">
                ${column.columnName} = ${r"#{"}${column.fieldName}${r"}"},
            </if>
    </#if>
</#list>
        </set>
        WHERE ${table.primaryKey.columnName} = ${r"#{"}${table.primaryKey.fieldName}${r"}"}
    </update>

    <!-- 根据ID删除 -->
    <delete id="deleteById">
        DELETE FROM ${table.tableName}
        WHERE ${table.primaryKey.columnName} = ${r"#{"}${table.primaryKey.fieldName}${r"}"}
    </delete>

    <!-- 批量删除 -->
    <delete id="deleteByIds">
        DELETE FROM ${table.tableName}
        WHERE ${table.primaryKey.columnName} IN
        <foreach collection="ids" item="id" open="(" separator="," close=")">
            ${r"#{id}"}
        </foreach>
    </delete>

</mapper>