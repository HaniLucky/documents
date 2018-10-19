##### springboot整合swagger

##### 1.导入jar包

```
	<!-- swagger需要依赖 -->
		<dependency>
			<groupId>com.didispace</groupId>
			<artifactId>spring-boot-starter-swagger</artifactId>
			<version>1.3.0.RELEASE</version>
		</dependency>
```

##### 2.添加配置文件

```
swagger.title=测试标题
swagger.description="测试描述"
(可省略,使用默认配置)
配置文件参考路径
spring-boot-starter-swagger-1.3.0.RELEASE.jar[jar]
com.didispace.swagger.SwaggerProperties[配置类]
```

##### 3.启动类添加配置

 	springboot启动类添加@EnableSwagger2注解

​	`@EnableSwagger2`

##### 4.Controller添加注解

​	接口添加`@Api`注解

​	`@Api(value = "用户Controller", description = "对用户的相关参数")`

​	Controller类方法上添加注解`@ApiOperation`

​	`	@ApiOperation(value="测试接口", notes="测试Hello World")`