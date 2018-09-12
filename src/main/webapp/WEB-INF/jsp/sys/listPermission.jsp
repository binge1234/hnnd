<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
	    <c:forEach items="${permissions}" var="p" varStatus="step" begin="0">
		        	<c:set var="hasPermission" value="false" />
		              <c:forEach items="${currPermissions}" var="cP" varStatus="cstep" begin="0">
                        <c:if test="${p.id==cP.id}">
                            <c:set var="hasPermission" value="true" />
                        </c:if>              
		               </c:forEach>
		               <c:if test="${(step.index+1)%3==0}">
                          <input type="checkbox" class="box" ${hasPermission?"checked='checked'":"" } 
                               name="pid" value="${p.id}"> ${p.remark}<br>
                        </c:if>
		                <c:if test="${(step.index+1)%3!=0}">
                          <input type="checkbox" class="box" ${hasPermission?"checked='checked'":"" } 
                               name="pid" value="${p.id}"> ${p.remark}
		                 </c:if>
		                <!-- 
		              <input type="checkbox" value=${p.id}>${(step.index+1)%4 ==1} &nbsp;
		               -->
		              
		 </c:forEach>