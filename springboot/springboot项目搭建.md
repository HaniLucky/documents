##### 添加依赖  pom文件

		<dependencies>
			<dependency>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-starter-jdbc</artifactId>
			</dependency>
			<dependency>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-starter-web</artifactId>
			</dependency>
		<dependency>
			  <groupId>org.mybatis.spring.boot</groupId>
			  <artifactId>mybatis-spring-boot-starter</artifactId>
		      <version>1.3.2</version>
		</dependency>
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
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
	</dependencies>
Mapper.xml文件头声明

```
<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
```

#####SQL

```
`SET FOREIGN_KEY_CHECKS=0;

---

-- Table structure for test

---

DROP TABLE IF EXISTS test;

CREATE TABLE test (

  id int(32) NOT NULL AUTO_INCREMENT,

  test_key varchar(32) DEFAULT NULL,

  test_value varchar(32) DEFAULT NULL,

  PRIMARY KEY (id)

) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

---

-- Records of test

---

INSERT INTO test VALUES ('1', '11', '22');`

```

##### vo



	@Table(name = "test")
	
	public class Test {
	
	    @Id
	    private Integer id;
	
	    @Column(name="test_key")
	    private String key;
	
	    @Column(name="test_value")
	    private String value;
	
	    public Test() {
	        super();
	    }
	
	    public Test(Integer id, String key, String value) {
	        super();
	        this.id = id;
	        this.key = key;
	        this.value = value;
	    }
	
	    public Integer getId() {
	        return id;
	    }
	
	    public void setId(Integer id) {
	        this.id = id;
	    }
	
	    public String getKey() {
	        return key;
	    }
	
	    public void setKey(String key) {
	        this.key = key;
	    }
	
	    public String getValue() {
	        return value;
	    }
	
	    public void setValue(String value) {
	        this.value = value;
	    }
	 }

##### controller

	@RestController(value ="test")
	
	public class TestController {
	
	    @Autowired
	    private TestService testService;
	
	    @RequestMapping(method= RequestMethod.GET)
	    public List<Test> all(){
	        return testService.quertTest();
	    }
	}
##### service

	public interface TestService {
		List<Test> quertTest();
	}

#####serviceImpl

	@Service
	public class TestServiceImpl implements TestService{
		@Autowired
	    private TestMapper testMapper;
	
	    @Override
	    public List<Test> quertTest() {
	        List<Test> list = testMapper.selectAll();
	        return list;
	    }
	}
##### Mapper.java

```
@Mapper   // 添加@Mapper注解 直接扫描
public interface TestMapper extends tk.mybatis.mapper.common.Mapper<Test>{  // 使用通用mapper

}

```

##### Mapper.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.example.covet.app.test.mapper.TestMapper">

</mapper>
```

##### 测试

