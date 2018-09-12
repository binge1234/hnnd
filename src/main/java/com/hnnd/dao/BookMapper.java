package com.hnnd.dao;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.Book;

public interface BookMapper extends BaseMapper<Book>{
    int deleteByPrimaryKey(Integer id);

    int insert(Book record);

    int insertSelective(Book record);

    Book selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Book record);

    int updateByPrimaryKey(Book record);
}