package com.hnnd.aop;

import java.lang.reflect.Method;
import java.util.Map;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;
import com.hnnd.annotion.*;


@Aspect
@Component
public class AOP {
	
	@Pointcut(value = "@annotation(com.hnnd.annotion.Mark)")
	private void cut() {

	}
    @Around("cut()")
    public Object recordSysLog(ProceedingJoinPoint point) throws Throwable {

        //��ִ��ҵ��
        Object result = point.proceed();

        try {
            handle(point);
        } catch (Exception e) {
            
        }

        return result;
    }

    private void handle(ProceedingJoinPoint point) throws Exception {

        //��ȡ���صķ�����
        Signature sig = point.getSignature();
        MethodSignature msig = null;
        if (!(sig instanceof MethodSignature)) {
            throw new IllegalArgumentException("��ע��ֻ�����ڷ���");
        }
        msig = (MethodSignature) sig;
        Object target = point.getTarget();
        Method currentMethod = target.getClass().getMethod(msig.getName(), msig.getParameterTypes());
        String methodName = currentMethod.getName();



        //��ȡ���ط����Ĳ���
        String className = point.getTarget().getClass().getName();
        Object[] params = point.getArgs();

        //��ȡ��������
        Mark annotation = currentMethod.getAnnotation(Mark.class);
        String markName = annotation.value();
        String key = annotation.key();
        
      



        
    }
}
