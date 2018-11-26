##### springboot拦截器配置

######1.创建一个自定义拦截器

	public class MyInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.err.println("############已经进入拦截器###############");
		//return false表示不进入controller
	    //return true表示进入controller
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
	}

##### 2.声明一个配置类,将拦截器添加到配置中

​	继承  **WebMvcConfigurationSupport**

​	重写方法 **addInterceptors**

	@Configuration   // 相当于声明一个xml配置文件
	public class WebConfig extends WebMvcConfigurationSupport {
	@Override
	protected void addInterceptors(InterceptorRegistry registry) {
		// 需要拦截的路径
		String[] addPathPatterns = { "/page/**" };
		// 不需要拦截的路径
		String[] excludePathPatterns = { "/user/**", "/person/**" };
	
		// addPathPatterns()添加拦截路径
		// excludePathPatterns() 添加不拦截的路径
		// 添加知定义拦截器
		registry.addInterceptor(new MyInterceptor()).addPathPatterns(addPathPatterns)
				.excludePathPatterns(excludePathPatterns);
	
		// 如果有多个拦截器可以注册多个...
	}
	}