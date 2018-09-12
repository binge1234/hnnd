package com.hnnd.util;

import java.util.ArrayList;
import java.util.List;

public class StringUtil {
	   /**
     * @Description �ж��Ƿ��ǿ�
     * @param str
     * @return
     */
    public static boolean isEmpty(String str) {
        if(str == null || "".equals(str.trim())) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * @Description �ж��Ƿ��ǿ�
     * @param str
     * @return
     */
    public static boolean isNotEmpty(String str) {
        if((str != null) && !"".equals(str.trim())) {
            return true;
        } else {
            return false;
        }
    }



    /**
     * @Description ���˵�������Ŀո�
     * @param list
     * @return
     */
    public static List<String> filterWhite(List<String> list) {
        List<String> resultList = new ArrayList<String>();
        for(String l : list) {
            if(isNotEmpty(l)) {
                resultList.add(l);
            }
        }
        return resultList;
    }
}
