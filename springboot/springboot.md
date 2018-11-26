一个工程必选模块
	Thymeleaf Web MySQL JDBC MyBatis

可选模块
		

		<!-- 逆向工程生成 -->
			<dependency>
			<groupId>org.mybatis.generator</groupId>
			<artifactId>mybatis-generator-core</artifactId>
			<version>1.3.6</version>
		</dependency>
		<!-- swagger需要依赖 -->
		<dependency>
			<groupId>com.didispace</groupId>
			<artifactId>spring-boot-starter-swagger</artifactId>
			<version>1.3.0.RELEASE</version>
		</dependency>
	
		<!-- 通用mapper和分页插件配置 导入jar包直接使用 无需额外配置 -->
		<!-- 通用mapper -->
		<dependency>
			<groupId>tk.mybatis</groupId>
			<artifactId>mapper-spring-boot-starter</artifactId>
			<version>RELEASE</version>
		</dependency>
		<!-- 分页助手 -->
		<dependency>
			<groupId>com.github.pagehelper</groupId>
			<artifactId>pagehelper-spring-boot-starter</artifactId>
			<version>RELEASE</version>
		</dependency>

以上所有模块只需要配置数据库相关配置(只需数据配置就可正常启动)
	spring.datasource.driverClassName=com.mysql.jdbc.Driver
	spring.datasource.url=jdbc:mysql://127.0.0.1:3306/hanilucky
	spring.datasource.username=root
	spring.datasource.password=root
	
​	
/resources目录下  (在选择web模块是才起作用)
	|
	--static
	--templates
	
​	
​	
Maven插件配置
Spring配置文件的三种配置方式
	Java配置  注解配置  XML配置
	
​	
maven插件
	maven-compiler-plugin

	Mvaen插件说明
		https://blog.csdn.net/liupeifeng3514/article/details/80236077




springboot yml配置注意

​	最后一个层级是:号后面要跟一个空格