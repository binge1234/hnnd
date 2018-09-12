package com.hnnd.dao;

import org.apache.ibatis.annotations.Param;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.ExamLocation;

public interface ExamLocationMapper extends BaseMapper<ExamLocation>{
    //int deleteByPrimaryKey(Integer id);

    int insert(ExamLocation record);

    int insertSelective(ExamLocation record);

    ExamLocation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ExamLocation record);

    //将考点开考专业设置为空
    void updateWithMajorNull(ExamLocation record);
    
    //设置考点代号
    void updateWithCode(ExamLocation record);
    
    //查询最新插入的一个考点,即max(id)
    ExamLocation selectNewestId(); 
    
    //（用于导入考场后）更新考点的最大容纳人数
    void updateTotalCapacity(Integer id);
    
    int selectForApply(@Param("citycode")int citycode,@Param("districtcode")int districtcode,@Param("majorid")int majorid);
}