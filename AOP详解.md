##### AOP详解

###### 什么叫AOP

​	AOP称为面向切面编程，在程序开发中主要用来解决一些系统层面上的问题，比如日志，事务，权限等待，Struts2的拦截器设计就是基于AOP的思想，是个比较经典的例子。 

###### AOP名词解释

​	(1)**Aspect(切面)**:通常是一个类，里面可以定义切入点和通知

​	(2)JointPoint(连接点):程序执行过程中明确的点，一般是方法的调用(通知时调用的具体方法)

​	(3)**Advice(通知)**:AOP在特定的切入点上执行的增强处理，有before,after,afterReturning,afterThrowing,around

​	(4)**Pointcut(切入点)**:就是带有通知的连接点，在程序中主要体现为书写切入点表达式

​	(5)AOP代理：AOP框架创建的对象，代理就是目标对象的加强。Spring中的AOP代理可以使JDK动态代理，也可以是CGLIB代理，前者基于接口，后者基于子类

###### AOP的使用场景

​	比如**日志**，事务，权限等待，Struts2的拦截器设计就是基于AOP的思想，是个比较经典的例子。 

###### 通知类型介绍

​	(1)Before:在目标方法被调用之前做增强处理,@Before只需要指定切入点表达式即可

​	(2)AfterReturning:在目标方法正常完成后做增强,@AfterReturning除了指定切入点表达式后，还可以指定一个返回值形参名returning,代表目标方法的返回值

​	(3)AfterThrowing:主要用来处理程序中未处理的异常,@AfterThrowing除了指定切入点表达式后，还可以指定一个throwing的返回值形参名,可以通过该形参名来访问目标方法中所抛出的异常对象

​	(4)After:在目标方法完成之后做增强，无论目标方法时候成功完成。@After可以指定一个切入点表达式

​	(5)Around:环绕通知,在目标方法完成前后做增强处理,环绕通知是最重要的通知类型,像事务,日志等都是环绕通知,注意编程中核心是一个ProceedingJoinPoint

##### 通知的执行顺序

```
1.不出现异常的情况
	①环绕通知(Around)--begin
	②前置通知(Before)
	①环绕通知(Around)--end
	③后置通知(after)
	④目标方法正常完成后做增强(AfterReturning)

2.出现异常的情况
	
```

##### 切点表达式详解

*@Pointcut("execution(* com.aijava.springcode.service...(..))")*

*第一个表示匹配任意的方法返回值，..(两个点)表示零个或多个，上面的第一个..表示service包及其子包,第二个表示所有类,第三个*表示所有方法，第二个..表示方法的任意参数个数

##### Example(日志的使用场景)

*日志切面*

```java
package com.example.aop;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * @describe 日志切面
 * @author huliangjun
 * @date 2018年10月22日 上午11:00:44
 */
// 声明一个切面
@Aspect
@Component
public class LogAspect {

	//
	// 配置切点
	@Pointcut(value = "execution(public * com.example.controller.*.*(..))")
	public void webLog() {
	}

	// 配置通知
	// 后置通知
	@Before(value = "webLog()")
	public void deBefore(JoinPoint joinPoint) {
		// 接收到请求，记录请求内容   获取request对象
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = attributes.getRequest();
		// 记录下请求内容
		System.out.println("URL : " + request.getRequestURL().toString());
		System.out.println("HTTP_METHOD : " + request.getMethod());
		System.out.println("IP : " + request.getRemoteAddr());
		System.out.println("CLASS_METHOD : " + joinPoint.getSignature().getDeclaringTypeName() + "."
				+ joinPoint.getSignature().getName());
		System.out.println("ARGS : " + Arrays.toString(joinPoint.getArgs()));
	}

	@AfterReturning(returning = "ret", pointcut = "webLog()")
	public void doAfterReturning(Object ret) throws Throwable {
		// 处理完请求，返回内容
		System.out.println("方法的返回值 : " + ret);
	}

	// 后置异常通知
	@AfterThrowing(value = "webLog()" ,throwing = "ex")
	public void throwss(JoinPoint jp ,Exception ex) {
		System.out.println("方法异常时执行.....");
		String methodName = jp.getSignature().getName();
		System.out.println("The method " + methodName + " occurs excetion:" + ex);
		
	}

	// 后置最终通知,final增强，不管是抛出异常或者正常退出都会执行
	@After("webLog()" )
	public void after(JoinPoint jp) {
		System.out.println("方法最后执行.....");
	}

	// 环绕通知,环绕增强，相当于MethodInterceptor
	@Around("webLog()")
	public Object arround(ProceedingJoinPoint pjp) {
		System.out.println("方法环绕start.....");
		try {
			Object o = pjp.proceed();
			System.out.println("方法环绕proceed，结果是 :" + o);
			return o;
		} catch (Throwable e) {
			e.printStackTrace();
			return null;
		}
	}

}
```

*Controller* 模拟切点

```java
package com.example.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FirstController {
	
	@RequestMapping(value = "/first")
	public Object first(){
		return "First controller";
	}
	
	@RequestMapping(value = "/doError")
	public Object doError() throws Exception{
		return 2/0;
	}

}

```

*返回结果*

```
方法环绕start.....
URL : http://127.0.0.1:8080/first
HTTP_METHOD : GET
IP : 127.0.0.1
CLASS_METHOD : com.example.controller.FirstController.first
ARGS : []
方法环绕proceed，结果是 :First controller
方法最后执行.....
方法的返回值 : First controller

```

> ```
> 参考代码地址  git@github.com:HaniLucky/example.git
> ```

