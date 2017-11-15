package com.test.dao;

import com.test.bean.Users;
import com.test.bean.UsersExample;
import java.util.List;
import org.apache.ibatis.annotations.Arg;
import org.apache.ibatis.annotations.ConstructorArgs;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.DeleteProvider;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.UpdateProvider;
import org.apache.ibatis.type.JdbcType;

public interface UsersMapper {
    @SelectProvider(type=UsersSqlProvider.class, method="countByExample")
    int countByExample(UsersExample example);

    @DeleteProvider(type=UsersSqlProvider.class, method="deleteByExample")
    int deleteByExample(UsersExample example);

    @Delete({
        "delete from users",
        "where uid = #{uid,jdbcType=INTEGER}"
    })
    int deleteByPrimaryKey(Integer uid);

    @Insert({
        "insert into users (uid, username, ",
        "sex, age, phone, ",
        "email)",
        "values (#{uid,jdbcType=INTEGER}, #{username,jdbcType=VARCHAR}, ",
        "#{sex,jdbcType=VARCHAR}, #{age,jdbcType=INTEGER}, #{phone,jdbcType=VARCHAR}, ",
        "#{email,jdbcType=VARCHAR})"
    })
    int insert(Users record);

    @InsertProvider(type=UsersSqlProvider.class, method="insertSelective")
    int insertSelective(Users record);

    @SelectProvider(type=UsersSqlProvider.class, method="selectByExample")
    @ConstructorArgs({
        @Arg(column="uid", javaType=Integer.class, jdbcType=JdbcType.INTEGER, id=true),
        @Arg(column="username", javaType=String.class, jdbcType=JdbcType.VARCHAR),
        @Arg(column="sex", javaType=String.class, jdbcType=JdbcType.VARCHAR),
        @Arg(column="age", javaType=Integer.class, jdbcType=JdbcType.INTEGER),
        @Arg(column="phone", javaType=String.class, jdbcType=JdbcType.VARCHAR),
        @Arg(column="email", javaType=String.class, jdbcType=JdbcType.VARCHAR)
    })
    List<Users> selectByExample(UsersExample example);

    @Select({
        "select",
        "uid, username, sex, age, phone, email",
        "from users",
        "where uid = #{uid,jdbcType=INTEGER}"
    })
    @ConstructorArgs({
        @Arg(column="uid", javaType=Integer.class, jdbcType=JdbcType.INTEGER, id=true),
        @Arg(column="username", javaType=String.class, jdbcType=JdbcType.VARCHAR),
        @Arg(column="sex", javaType=String.class, jdbcType=JdbcType.VARCHAR),
        @Arg(column="age", javaType=Integer.class, jdbcType=JdbcType.INTEGER),
        @Arg(column="phone", javaType=String.class, jdbcType=JdbcType.VARCHAR),
        @Arg(column="email", javaType=String.class, jdbcType=JdbcType.VARCHAR)
    })
    Users selectByPrimaryKey(Integer uid);

    @UpdateProvider(type=UsersSqlProvider.class, method="updateByExampleSelective")
    int updateByExampleSelective(@Param("record") Users record, @Param("example") UsersExample example);

    @UpdateProvider(type=UsersSqlProvider.class, method="updateByExample")
    int updateByExample(@Param("record") Users record, @Param("example") UsersExample example);

    @UpdateProvider(type=UsersSqlProvider.class, method="updateByPrimaryKeySelective")
    int updateByPrimaryKeySelective(Users record);

    @Update({
        "update users",
        "set username = #{username,jdbcType=VARCHAR},",
          "sex = #{sex,jdbcType=VARCHAR},",
          "age = #{age,jdbcType=INTEGER},",
          "phone = #{phone,jdbcType=VARCHAR},",
          "email = #{email,jdbcType=VARCHAR}",
        "where uid = #{uid,jdbcType=INTEGER}"
    })
    int updateByPrimaryKey(Users record);

    @Select({
            "select",
            "uid, username, sex, age, phone, email",
            "from users",
            "where 1=1 ",
            "and username LIKE CONCAT(CONCAT('%', #{_parameter}), '%')",
            "or email LIKE CONCAT(CONCAT('%', #{_parameter}), '%')",
            "or sex LIKE CONCAT(CONCAT('%', #{_parameter}), '%')",
            "or uid LIKE CONCAT(CONCAT('%', #{_parameter}), '%')"

    })
    List<Users> selectByLike(String like);
}