#### application.properties

##### 全局配置(项目基础配置)

```
#应用端口
server.port=8080
#活动的配置文件 (与application.properties在同一层级文件夹.application-dev.properties(dev动态))
spring.profiles.active= dev(xxx)
#分文件管理配置文件(包含配置文件  文件路径为resoure/config/application-xxx.properties.xxx变量)
spring.profiles.include=mybatis,swagger,xxx
##数据源配置(基本配置)
#数据库驱动
spring.datasource.driverClassName=com.mysql.jdbc.Driver
#数据库地址
spring.datasource.url=jdbc:mysql://144.34.172.160:3306/crm
#数据库账号密码
spring.datasource.username=root
spring.datasource.password=root

#文件上传相关
#maxFileSize 单个数据大小
spring.http.multipart.maxFileSize = 10Mb
#maxRequestSize 是总数据大小
spring.http.multipart.maxRequestSize=100Mb
```

##### 日志相关配置(日志配置只能满足基本的日志需求,如果要自定义需整合日志框架.如log4j等)

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

##### Mybatis相关配置

```
#配置mybatis日志(com.covet.crmapp.mapper为mapper接口的全限定名) 打印sql信息
logging.level.com.covet.crmapp.mapper=debug
```

##### Swargger相关配置

```
#Swargger页面title
swagger.title=springboot
#Swargger应用描述
swagger.description=springboot描述
```

