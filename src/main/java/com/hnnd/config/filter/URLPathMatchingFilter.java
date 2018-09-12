package com.hnnd.config.filter;

import java.util.Set;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.hnnd.entity.User;
import com.hnnd.service.UserService;
import com.hnnd.service.shiro.PermissionService;
import com.hnnd.service.shiro.RoleService;
 

 
public class URLPathMatchingFilter extends PathMatchingFilter {
    @Autowired
    PermissionService permissionService;
    
    @Autowired
    RoleService roleService;
    @Autowired
    UserService userService;
 
    @Override
    protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue)
            throws Exception {
        String requestURI = getPathWithinApplication(request);
 
        System.out.println("requestURI:" + requestURI);
 
        Subject subject = SecurityUtils.getSubject();
        System.out.println("--------------------------------");
        // ���û�е�¼������ת����¼ҳ��
        if (!subject.isAuthenticated()) {
            WebUtils.issueRedirect(request, response, "/hello");
            return false;
        }
 
        // �������·��Ȩ������û��ά�������û��ά����һ�ɷ���(Ҳ���Ը�Ϊһ�ɲ�����)
        boolean needInterceptor = permissionService.isBlock(requestURI);
        if (!needInterceptor) {
        	System.out.println("û��ά��");
            return true;
        } else {
            boolean hasPermission = false;
            User user = (User)subject.getPrincipal();
            String userName = user.getName();
            Set<String> permissionUrls = permissionService.listPermissionURLs(userName);
            for (String url : permissionUrls) {
                // ��ͱ�ʾ��ǰ�û������Ȩ��
                if (url.equals(requestURI)) {
                    hasPermission = true;
                    break;
                }
            }
            if (hasPermission)
                return true;
            else {
                UnauthorizedException ex = new UnauthorizedException("��ǰ�û�û�з���·�� " + requestURI + " ��Ȩ��");
 
                subject.getSession().setAttribute("ex", ex);
 
                WebUtils.issueRedirect(request, response, "/unauthorized");
                return false;
            }
 
        }
 
    }
}