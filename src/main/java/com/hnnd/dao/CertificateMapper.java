package com.hnnd.dao;

import com.hnnd.entity.Certificate;

public interface CertificateMapper {
    int deleteByPrimaryKey(String certificate_id);

    int insert(Certificate record);

    int insertSelective(Certificate record);

    Certificate selectByPrimaryKey(String certificate_id);

    int updateByPrimaryKeySelective(Certificate record);

    int updateByPrimaryKey(Certificate record);
}