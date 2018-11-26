##### 1.创建mybatis拦截器

	import java.sql.Connection;
	import java.text.SimpleDateFormat;
	import java.util.ArrayList;
	import java.util.Date;
	import java.util.List;
	import java.util.Properties;
	import org.apache.ibatis.executor.statement.StatementHandler;
	import org.apache.ibatis.mapping.BoundSql;
	import org.apache.ibatis.mapping.ParameterMapping;
	import org.apache.ibatis.mapping.ParameterMode;
	import org.apache.ibatis.plugin.Interceptor;
	import org.apache.ibatis.plugin.Intercepts;
	import org.apache.ibatis.plugin.Invocation;
	import org.apache.ibatis.plugin.Plugin;
	import org.apache.ibatis.plugin.Signature;
	import org.apache.ibatis.reflection.MetaObject;
	import org.apache.ibatis.reflection.SystemMetaObject;
	import org.apache.ibatis.session.Configuration;
	import org.apache.ibatis.type.TypeHandlerRegistry;
	import org.slf4j.Logger;
	import org.slf4j.LoggerFactory;
	import org.springframework.stereotype.Component;
	@Component
	@Intercepts({
		@Signature(type = StatementHandler.class, method = "prepare", args = { Connection.class, Integer.class }) })
	public class SqlStatementInterceptor implements Interceptor {
	private static final Logger logger = LoggerFactory.getLogger(SqlStatementInterceptor.class);
		private Configuration configuration;
		private TypeHandlerRegistry typeHandlerRegistry;
		private static ThreadLocal<SimpleDateFormat> dateTimeFormatter=new ThreadLocal<SimpleDateFormat>(){@Override protected SimpleDateFormat initialValue(){return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");}};
	
	public Object intercept(Invocation invocation) {
		StatementHandler stmtHandler = (StatementHandler) invocation.getTarget();
		MetaObject metaStmtHandler = SystemMetaObject.forObject(stmtHandler);
		BoundSql boundSql = (BoundSql) metaStmtHandler.getValue("delegate.boundSql");
		String sql = "\r\n" + boundSql.getSql();
		// String sql = boundSql.getSql();
		List<String> parameters = new ArrayList<>();
		// Object parameterObject2 = boundSql.getParameterObject();
		Object parameterObject = metaStmtHandler.getValue("delegate.boundSql.parameterObject");
		List<ParameterMapping> parameterMappings = boundSql.getParameterMappings();
		if (parameterMappings != null) { // [ParameterMapping{property='name',
											// mode=IN, javaType=class
											// java.lang.String, jdbcType=null,
											// numericScale=null,
											// resultMapId='null',
											// jdbcTypeName='null',
											// expression='null'}]
			// MetaObject metaObject = parameterObject == null ? null :
			// configuration.newMetaObject(parameterObject);
			for (int i = 0; i < parameterMappings.size(); i++) {
				ParameterMapping parameterMapping = parameterMappings.get(i);
				if (parameterMapping.getMode() != ParameterMode.OUT) {
					// 参数值
					Object value;
					String propertyName = parameterMapping.getProperty();
					// 获取参数名称
					if (boundSql.hasAdditionalParameter(propertyName)) {
						// 获取参数值
						value = boundSql.getAdditionalParameter(propertyName);
					} else if (parameterObject == null) {
						value = null;
					} else {
						// value = metaObject == null ? null :
						// metaObject.getValue(propertyName);
						value = parameterObject;
					}
	
					if (value instanceof Number) {
						parameters.add(String.valueOf(value));
					} else {
						StringBuilder builder = new StringBuilder();
						builder.append("'");
						if (value instanceof Date) {
							builder.append(dateTimeFormatter.get().format((Date) value));
						} else if (value instanceof String) {
							builder.append(value);
						}
						builder.append("'");
						parameters.add(builder.toString());
					}
				}
			}
		}
	
		for (String value : parameters) {
			sql = sql.replaceFirst("\\?", value);
		}
		logger.info(sql);
		Object proceed = null;
		long startTime = System.currentTimeMillis();
		try {
			proceed = invocation.proceed();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("SQL执行耗时[" + (System.currentTimeMillis() - startTime) + "ms]");
		}
		return proceed;
	}
	
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}
	
	public void setProperties(Properties properties) {
	}
	
	public Configuration getConfiguration() {
		return configuration;
	}
	
	public void setConfiguration(Configuration configuration) {
		this.configuration = configuration;
	}
	
	public void setTypeHandlerRegistry(TypeHandlerRegistry typeHandlerRegistry) {
		this.typeHandlerRegistry = typeHandlerRegistry;
	}
	}

##### 2.配置拦截器

```
package com.covet.crmapp.config;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;

import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.boot.autoconfigure.MybatisProperties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import com.covet.crmapp.filter.SqlStatementInterceptor;

@Configuration
@ConditionalOnClass({ SqlSessionFactory.class, SqlSessionFactoryBean.class })
@EnableConfigurationProperties(MybatisProperties.class)
@AutoConfigureAfter(DataSourceAutoConfiguration.class)
public class MybatisAutoConfiguration {
	private static final Logger LOGGER = LoggerFactory.getLogger(MybatisAutoConfiguration.class);
	@Autowired
	private MybatisProperties properties;
	@Autowired
	private ResourceLoader resourceLoader = new DefaultResourceLoader();

	@PostConstruct
	public void checkConfigFileExists() {
		if (this.properties.isCheckConfigLocation()) {
			Resource resource = this.resourceLoader.getResource(this.properties.getConfig());
			Assert.state(resource.exists(), "Cannot find config location: " + resource
					+ " (please add config file or check your Mybatis " + "configuration)");
		}
	}

	@Bean(name = "sqlSessionFactory")
	@ConditionalOnMissingBean
	public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
		SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
		bean.setDataSource(dataSource);
		if (StringUtils.hasText(this.properties.getConfig())) {
			bean.setConfigLocation(this.resourceLoader.getResource(this.properties.getConfig()));
		} else { // 加入sql语句拦截器
			bean.setPlugins(new Interceptor[] { new SqlStatementInterceptor() });
			bean.setTypeAliasesPackage(this.properties.getTypeAliasesPackage());
			bean.setTypeHandlersPackage(this.properties.getTypeHandlersPackage());
			// bean.setMapperLocations(this.properties.getMapperLocations());
			bean.setMapperLocations(this.properties.resolveMapperLocations());
		}
		return bean.getObject();

	}
}

```

**参考[1]**:https://www.jianshu.com/p/bfabc155060f

​	git地址:https://github.com/Azhenge32/MyBatisLearn.git

**参考[2]:**https://www.cnblogs.com/Darlin356230410/p/7071159.html

**idea插件地址:**https://github.com/kookob/mybatis-log-plugin.git