#### 服务消费(Feign)

**和ribbon不同**

​	Feign是一个声明式的伪Http客户端，它使得写Http客户端变得更简单。使用Feign，只需要创建一个接口并			注解。它具有可插拔的注解特性，可使用Feign   注解和JAX-RS注解。Feign支持可插拔的编码器和解码器。Feign默认集成了Ribbon，并和Eureka结合，默认实现了负载均衡的效果。

简而言之：

- Feign 采用的是基于接口的注解
- Feign 整合了ribbon

1. pom配置

   ```
   <?xml version="1.0" encoding="UTF-8"?>
   <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
      <modelVersion>4.0.0</modelVersion>
   
      <groupId>com.covet.springboot</groupId>
      <artifactId>serice-feign</artifactId>
      <version>0.0.1-SNAPSHOT</version>
      <packaging>jar</packaging>
   
      <name>serice-feign</name>
      <description>Demo project for Spring Boot</description>
   
      <parent>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-parent</artifactId>
         <version>1.5.15.RELEASE</version>
         <relativePath/> <!-- lookup parent from repository -->
      </parent>
   
      <properties>
         <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
         <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
         <java.version>1.8</java.version>
         <spring-cloud.version>Edgware.SR4</spring-cloud.version>
      </properties>
   
      <dependencies>
         <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
         </dependency>
         <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-eureka-server</artifactId>
         </dependency>
         <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-feign</artifactId>
         </dependency>
   
         <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
         </dependency>
      </dependencies>
   
      <dependencyManagement>
         <dependencies>
            <dependency>
               <groupId>org.springframework.cloud</groupId>
               <artifactId>spring-cloud-dependencies</artifactId>
               <version>${spring-cloud.version}</version>
               <type>pom</type>
               <scope>import</scope>
            </dependency>
         </dependencies>
      </dependencyManagement>
   
      <build>
         <plugins>
            <plugin>
               <groupId>org.springframework.boot</groupId>
               <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
         </plugins>
      </build>
   
   
   </project>
   ```

2. 配置文件配置

   ```
   eureka:
     client:
       serviceUrl:
         defaultZone: http://localhost:8761/eureka/
   server:
     port: 8765
   spring:
     application:
       name: service-feign
   ```

3. 启动类配置

   ```
   @EnableDiscoveryClient
   @EnableFeignClients
   @SpringBootApplication
   public class SericeFeignApplication {
   
      public static void main(String[] args) {
         SpringApplication.run(SericeFeignApplication.class, args);
      }
   }
   ```

4. FeignService

   ```
   /**
    * Created by Administrator on 2018/8/23.
    * 定义一个feign接口，通过@ FeignClient（“服务名”），来指定调用哪个服务。比如在代码中调用了service-hi服务的“/hi”接口
    */
   @FeignClient(value = "service-hi")
   public interface FeignServiceHi {
       @RequestMapping(value = "/hi",method = RequestMethod.GET)
       String sayHiFromClientOne(@RequestParam(value = "name") String name);
   }
   ```

5. Controller

   ```
   @RestController
   public class FeignController {
   
       @Autowired
       FeignServiceHi feignServiceHi;
       @RequestMapping(value = "/hi",method = RequestMethod.GET)
       public String sayHi(@RequestParam String name){
           return feignServiceHi.sayHiFromClientOne(name);
       }
   }
   ```



服务调用

http://localhost:8764/hi?name=covet

返回 **Hello World covet,我的端口是:8762 ** or **Hello World covet,我的端口是:8763**  (Fiegn自动进行负载均衡)

