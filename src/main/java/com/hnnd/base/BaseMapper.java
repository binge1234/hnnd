package com.hnnd.base;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BaseMapper<T extends BaseEntity> {

	    List<T> selectAll();

	    int deleteByPrimaryKey(Integer id);

	    T selectByPrimaryKey(Integer id);

	    int insert(T t);

	    int update(T t);

        List<T> selectByPage(@Param("start")int start,@Param("pageSize")int pageSize);
	    
        int getTotal();
	
}
