package com.tbe.dao;

import com.tbe.beans.PUID;
import com.tbe.beans.PUIDExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PUIDMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table puid_check
     *
     * @mbg.generated Fri Apr 26 14:39:19 CST 2019
     */
    long countByExample(PUIDExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table puid_check
     *
     * @mbg.generated Fri Apr 26 14:39:19 CST 2019
     */
    int deleteByExample(PUIDExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table puid_check
     *
     * @mbg.generated Fri Apr 26 14:39:19 CST 2019
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table puid_check
     *
     * @mbg.generated Fri Apr 26 14:39:19 CST 2019
     */
    int insert(PUID record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table puid_check
     *
     * @mbg.generated Fri Apr 26 14:39:19 CST 2019
     */
    int insertSelective(PUID record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table puid_check
     *
     * @mbg.generated Fri Apr 26 14:39:19 CST 2019
     */
    List<PUID> selectByExample(PUIDExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table puid_check
     *
     * @mbg.generated Fri Apr 26 14:39:19 CST 2019
     */
    PUID selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table puid_check
     *
     * @mbg.generated Fri Apr 26 14:39:19 CST 2019
     */
    int updateByExampleSelective(@Param("record") PUID record, @Param("example") PUIDExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table puid_check
     *
     * @mbg.generated Fri Apr 26 14:39:19 CST 2019
     */
    int updateByExample(@Param("record") PUID record, @Param("example") PUIDExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table puid_check
     *
     * @mbg.generated Fri Apr 26 14:39:19 CST 2019
     */
    int updateByPrimaryKeySelective(PUID record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table puid_check
     *
     * @mbg.generated Fri Apr 26 14:39:19 CST 2019
     */
    int updateByPrimaryKey(PUID record);
}