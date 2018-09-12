package com.hnnd.base;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.hnnd.entity.Major;
import com.hnnd.util.PageBean;
public class BaseService<T extends BaseEntity> {
	
	@Autowired
    BaseMapper<T> mapper;
    

    public List<T> listAll() {
        return mapper.selectAll();
    }

    public void delete(Integer id) {
     mapper.deleteByPrimaryKey(id);
    }																								
    public void insert(T record) {
       mapper.insert(record); 
    }

    public void update(T record) {
        mapper.update(record);
        
    }
    
    @SuppressWarnings("unchecked")
    public T queryById(Integer id) {
        T record = mapper.selectByPrimaryKey(id);
        return record;
    }
    
    public PageBean<T> queryByPage(PageBean<T> pageBean){
    	int total = mapper.getTotal();
    	pageBean.setTotal(total);
		List<T> result = mapper.selectByPage(pageBean.getStart(), pageBean.getPageSize());
		pageBean.setResult(result);
		return pageBean;
    }
}
