##### springboot过滤器配置

######1.新建一个自定义Filter 实现Filter 重写方法

```java
@Order(value=1) // filter的执行顺序  值越小越先执行
@WebFilter(filterName = "myFilter" ,urlPatterns = "/*")    // urlPatterns 进行过滤的url
public class MyFilter implements Filter{
// 销毁操作
@Override
public void destroy() {
	System.err.println("Filter销毁了");
}

@Override
public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
		throws IOException, ServletException {
	System.err.println("请求进来了"+request.getServletContext().toString());
	filterChain.doFilter(request, response);
}

// 初始化操作
@Override
public void init(FilterConfig arg0) throws ServletException {
	System.err.println("filter初始化");
}
```
######2.启动类配置  (springboot启动类中添加该注解)

​    添加注解扫描过滤器

​		@ServletComponentScan   // 扫描filter