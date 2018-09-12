package com.hnnd.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class ResponseUtil {
    /**
     * ��response����д������
     * @param response
     * @param obj
     * @throws Exception
     */
    public static void write(HttpServletResponse response, Object obj)throws Exception{
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println(obj.toString());
        out.flush();
        out.close();
    }
}
