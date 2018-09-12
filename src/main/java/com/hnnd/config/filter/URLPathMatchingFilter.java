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
        // 如果没有登录，就跳转到登录页面
        if (!subject.isAuthenticated()) {
            WebUtils.issueRedirect(request, response, "/hello");
            return false;
        }
 
        // 看看这个路径权限里有没有维护，如果没有维护，一律放行(也可以改为一律不放行)
        boolean needInterceptor = permissionService.isBlock(requestURI);
        if (!needInterceptor) {
        	System.out.println("没有维护");
            return true;
        } else {
            boolean hasPermission = false;
            User user = (User)subject.getPrincipal();
            String userName = user.getName();
            Set<String> permissionUrls = permissionService.listPermissionURLs(userName);
            for (String url : permissionUrls) {
                // 这就表示当前用户有这个权限
                if (url.equals(requestURI)) {
                    hasPermission = true;
                    break;
                }
            }
            if (hasPermission)
                return true;
            else {
                UnauthorizedException ex = new UnauthorizedException("当前用户没有访问路径 " + requestURI + " 的权限");
 
                subject.getSession().setAttribute("ex", ex);
 
                WebUtils.issueRedirect(request, response, "/unauthorized");
                return false;
            }
 
        }
 
    }
}