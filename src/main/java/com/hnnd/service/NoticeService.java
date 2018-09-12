package com.hnnd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.dao.NoticeMapper;
import com.hnnd.entity.Notice;

@Service
public class NoticeService {
   @Autowired
   NoticeMapper noticeMapper;
   
   public Notice getState() {
	   return noticeMapper.select();
   }
   public void updateState(Notice notice) {
	   
   }
}
