Oracle常用函数
-- 判断
nvl(expr1,expr2);
	如果expr1为null,则返回expr2
nvl2(expr1,expr2,expr3)
	如果expr1为null,则返回expr3,否则返回expr2


-- 分组排序
Row_number()over(partition by expr1 order by expr2)
 例子：
 SELECT EMPNO,ENAME,SAL,DEPTNO,Row_number() over( order by sal) rs FROM SCOTT.EMP;
 SELECT EMPNO,ENAME,SAL,DEPTNO,Row_number() over(partition by DEPTNO order by sal) rs FROM SCOTT.EMP;

	分组排序,根据expr1进行分组,根据expr2对结果集进行排序.执行顺序晚于group by order by的执行
	partition by 是可选的,可以直接进行分组直接进行排序


-- 行转列
(1):listagg(expr1,expr2) within GROUP(order by expr3) 
	例子:
		SELECT
			T .DEPTNO,
			listagg (T .ENAME, ',') WITHIN GROUP (ORDER BY T .ENAME) names
		FROM
			SCOTT.EMP T
		GROUP BY
			T .DEPTNO;

	执行步骤:先根据GROUP BY 进行条件筛选,筛选完成之后. expr1要进行行转列的字段,expr2分隔符,expr3行转列之后的排序规则()
(2):listagg(expr1,expr2) within GROUP(order by expr3) over(partition by expr4)
	 例子:
	 SELECT
		T .DEPTNO,
		listagg (T .ENAME, ',') WITHIN GROUP (ORDER BY T .ENAME)  over(PARTITION BY T .DEPTNO)
	 FROM
		SCOTT.EMP T
	 WHERE
		T .DEPTNO = '20' ;
	执行步骤:先查询所有数据,然后根据条件进行分组排序.expr1要进行行转列的字段,expr2分隔符,expr3行转列之后的排序规则(),expr4 排序规则

区别:返回的数据条数不同,先根据外部的分组条件进行筛选筛选数据,over后面的分组条件只会对行转类的字段(对那个字段进行行转列)有影响不会对数据进行实质性的筛选
注意:over 的分组条件不能和GROUP BY 同时出现


-- DECODE函数
	"DECODE"(expr, [search, result]*, default)
	例子:SELECT "DECODE"(T1.DEPTNO,10,'第一组',20,'第二组',30,'第三组', 'null') FROM SCOTT.EMP T1;
	解释说明：expr为条件 如果search等于expr则返回result，如果都不能匹配上则显示default   default是可选的

	结合sign（）函数使用
		select sign( 100 ),sign(- 100 ),sign( 0 ) from dual;   1  -1 0
		select sign( 1-2) from dual;   -1
		select sign( 1-1) from dual;   0 
		select sign( 1-0) from dual;   1

	给职员加工资，其标准是：工资在8000元以下的将加20％；工资在8000元以上的加15％，8000 元的不加。实现： 
	select decode(sign(salary - 8000),1,salary*1.15,-1,salary*1.2,salary from employee 


-- CASE WHEN
CASE expr WHEN expr1 THEN value1 WHEN expr2 THEN value2 END
CASE WHEN expr1 THEN value1 WHEN expr2 THEN value2 END
	select ename,(case comm when null then 0 else comm end) comm from SCOTT.emp;   -- 为null不是用0填充
	SELECT ename,CASE WHEN comm is null then 0 ELSE comm END comm FROM SCOTT.emp   -- 为null会使用0填充
两者的区别
	  1.DECODE 只有Oracle 才有，其它数据库不支持;
      2.CASE WHEN的用法， Oracle、SQL Server、 MySQL 都支持;
      3.DECODE 只能用做相等判断,但是可以配合sign函数进行大于，小于，等于的判断,CASE when可用于=,>=,<,<=,<>,is null,is not null 等的判断;
      4.DECODE 使用其来比较简洁，CASE 虽然复杂但更为灵活;
      5.另外，在decode中，null和null是相等的，但在case when中，只能用is null来判断，示例如下：


构建临时表并查询
	with temp as(
	  select 'China' nation ,'Guangzhou' city from dual union all
	  select 'China' nation ,'Shanghai' city from dual union all
	  select 'China' nation ,'Beijing' city from dual union all
	  select 'USA' nation ,'New York' city from dual union all
	  select 'USA' nation ,'Bostom' city from dual union all
	  select 'Japan' nation ,'Tokyo' city from dual 
	)
	select nation,listagg(city,',') within GROUP (order by city desc)
	from temp
	group by nation;

	with temp as(
	  select 500 population, 'China' nation ,'Guangzhou' city from dual union all
	  select 1500 population, 'China' nation ,'Shanghai' city from dual union all
	  select 500 population, 'China' nation ,'Beijing' city from dual union all
	  select 1000 population, 'USA' nation ,'New York' city from dual union all
	  select 500 population, 'USA' nation ,'Bostom' city from dual union all
	  select 500 population, 'Japan' nation ,'Tokyo' city from dual 
	)
	select population,
	       nation,
	       listagg(city,',') within GROUP (order by city) over (partition by nation) rank
	from temp;

	
	
	
-- 获取一个32位的uuid
SELECT sys_guid() FROM dual;   -- 可能会乱码
SELECT rawtohex(sys_guid()) FROM dual;  -- 将乱码转换