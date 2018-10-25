##### 1.springboot默认log框架

​	默认logback,同时支持 JDKLogging , Log4j2,Log4j 

##### 2.Logger的日志级别

​	**日志级别**: TRACE , DEBUG , INFO , WARN , ERROR , FATAL , OFF（关闭日志）

​	**级别大小 :** trace<debug<info<warn<error<fatal

 	**级别说明:**  级别之间是包含的关系，意思是如果你设置日志级别是trace，则大于等于这个级别的日志都会输出。

​	**例:** 设置为Debug,会将 DEBUG , INFO , WARN , ERROR , FATAL所有日志打印出来

##### 3.springboot常用配置(properties配置,默认配置,如不满足系统要求,需导入对象的日志系统单独配置) 参考官网配置

```
#设置日志级别
logging.level.root=DEBUG
#配置mybaits日志  com.covet.crmapp.mapper 为mapper接口的全限定名
logging.level.com.covet.crmapp.mapper=debug
#配置日志配置不同的日志级别(com.xxx.xxx为单独配置日志的包名)
logging.level.com.xxx.xxx=info
logging.level.org.springfromework.web: info
#配置日志存储到本地(项目下log文件夹)
logging.file=log/image-service.log
logging.path=log/image-service.log
logging.config= 
#自定义日志输出格式
#控制台格式  在控制台(stdout)上使用的日志模式。(只支持默认的Logback设置。)
logging.pattern.console=%date{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n
#输出到文件的格式 在文件中使用的日志模式(如果启用了LOG_FILE)。(只支持默认的Logback设置。
logging.pattern.file=%date{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n
#呈现日志级别时使用的格式(默认%5p)。(只支持默认的Logback设置。)
logging.pattern.level=
logging.register-shutdown-hook= false
#记录异常时使用的转换词
logging.exception-conversion-word= 
```

###### 	logging.path和logging.file区别

​	*在默认情况下，SpringBoot 是仅仅在控制台打印log信息的，如果我们需要将log信息记录到文件，那么就需要在 application.properties 中配置 logging.file 或者 logging.path （注意啊，是或者，不是并且！）*
	 而且官方文档有明确说明，配置 logging.file 的话是可以定位到自定义的文件的，使用 logging.path 的话，日志文件将使用 spring.log来命名。
 	*而且日志文件会在10Mb大小的时候被截断，产生新的日志文件，默认级别为：ERROR、WARN、INFO*

##### 4.配置文件加载的问题

spring boot 默认会在reasource文件夹下加载一下xml文件:(没有配置文件会读取applicaiton.properties中的配置)	

|     Logging System      |                        Customization                         |
| :---------------------: | :----------------------------------------------------------: |
|         Logback         | logback-spring.xml, logback-spring.groovy, logback.xml, or logback.groovy |
|         Log4j2          |               log4j2-spring.xml or log4j2.xml                |
| JDK (Java Util Logging) |                      logging.properties                      |

即使如果使用的是Logback的话 会默认的去找 logback-spring.xml, logback-spring.groovy, logback.xml, or logback.groovy

##### 5.单独配置log4j举例

###### 	剔除默认日志系统并添加相关依赖

```
 <!-- spring boot start -->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter</artifactId>
	<exclusions> <!-- 排除自带的logback依赖 -->
		<exclusion>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-logging</artifactId>
		</exclusion>
	</exclusions>
</dependency> <!-- springboot-log4j -->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-log4j</artifactId>
	<version>1.3.8.RELEASE</version>
</dependency>
```

###### 	添加配置(所有都支持xml配置.log4j支持properties配置,其他框架不清楚) 参考https://www.jianshu.com/p/969e47cefa78各个日志框架整合

```
# Log4j配置
log4j.rootCategory=INFO,stdout
# Log4j配置 log4j.rootCategory=INFO,stdout # 控制台输出 log4j.appender.stdout=org.apache.log4j.ConsoleAppender log4j.appender.stdout.layout=org.apache.log4j.PatternLayout log4j.appender.stdout.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss,SSS} %5p %c{1}:%L - %m%n
```

##### 参考

​	**参考[1.]:**(官网)https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-logging.html

​	**参考[2.]:**(文档)https://www.jianshu.com/p/969e47cefa78

​	**参考[3]:**(springboot整合log4j):https://blog.csdn.net/saytime/article/details/78962999