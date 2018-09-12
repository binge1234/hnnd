package com.hnnd.dao;

import com.hnnd.entity.Notice;

public interface NoticeMapper {
    public Notice select();
    public void update(Notice notice);
}
