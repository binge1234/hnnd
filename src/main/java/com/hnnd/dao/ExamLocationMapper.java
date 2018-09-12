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

    //�����㿪��רҵ����Ϊ��
    void updateWithMajorNull(ExamLocation record);
    
    //���ÿ������
    void updateWithCode(ExamLocation record);
    
    //��ѯ���²����һ������,��max(id)
    ExamLocation selectNewestId(); 
    
    //�����ڵ��뿼���󣩸��¿���������������
    void updateTotalCapacity(Integer id);
    
    int selectForApply(@Param("citycode")int citycode,@Param("districtcode")int districtcode,@Param("majorid")int majorid);
}