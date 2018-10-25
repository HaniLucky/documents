

```plsql
-- 字符串连接  ||
SELECT e.*,ENAME ||':'|| JOB FROM scott.emp e ;


--========== where条件查询
 -- 查询工资大于2000的员工
 SELECT e.* from scott.emp e where sal>2000;
 -- 对null值的判断 null使用is和is not来判断
    -- 查询没有奖金的用户
 SELECT * from scott.emp e where comm is null;
 SELECT * from scott.emp e where comm is not null;
 -- 判断多个条件
    -- 查询工资高于1200并且没有奖金的员工
 SELECT * FROM scott.emp e where sal>1200 and comm is null;
 --范围判断
    --查询“JONES”和“BLAKE”两个员工
  SELECT * FROM scott.emp e where ename in ('JONES','BLAKE');
    -- 区分大小写
  SELECT * FROM scott.emp e where ename in ('jones','BLAKE');
  -- 模糊查询 like    _:占一个字符 %:占任意字符
   -- 查询名字中第二位是M的员工
 SELECT * FROM scott.emp e WHERE ename like '_M%';
   -- 查询名字中M的员工
 SELECT * FROM scott.emp e WHERE ename like '%M%';
 
 
 -- 排序 order by 升序 asc(默认) 倒叙 desc
   -- 查询员工按照工资升序
 SELECT * FROM scott.emp e  order by sal asc;
 SELECT * FROM scott.emp e  order by sal desc;
 
 
 
-- null值得排序  nulls first(讲null值放在前面) nulls last(将last放在后面)
  -- 对奖金进行排序同时对null值也进行排序
 SELECT * FROM scott.emp e order by comm asc nulls first;
 SELECT * FROM scott.emp e order by comm asc nulls last;
 SELECT * FROM scott.emp e order by comm desc nulls first;
 SELECT * FROM scott.emp e order by comm desc nulls last;
 
 -- 字符截取
     -- strsub('要截取的字符串','截取的启示')
SELECT substr('Hello World',0,5) from dual;
SELECT substr('Hello World',1,5) from dual;
SELECT substr('Hello World',3,5) from dual
        --concat(p1,p2)字符串连接
SELECT concat('Hello ','World') from dual;
	-- 字符串长度
SELECT length('Hello World') from dual;
      --replace(将要替换的字符串，替换那个字符，换成啥)字符串替换
SELECT replace('Hello','ll','zz') from dual;


 --round()--四舍五入
SELECT round(15.493) from dual;  -- 默认小数点后以为  取整
SELECT round(15.493,0) from dual; --  默认取证  四舍五入
SELECT round(15.493,1) from dual; -- 小数点后保留一位 
SELECT round(15.193,-1) from dual; -- 小数点前一位四舍五入
SELECT round(55.193,-2) from dual; -- 小数点前两位四舍五入

-- 截取字符串 trunc() -- 不四舍五入
SELECT trunc(15.493) from dual; -- 15
SELECT trunc(15.493,0) from dual; -- 15
SELECT trunc(15.493,1) from dual; -- 15.4
SELECT trunc(16.493,-1) from dual; -- 10
SELECT trunc(95.493,-2) from dual; -- 0


-- 截取日期 "TRUNC"(date, fmt)  
SELECT trunc(to_date('2017-06-29 14:25:55','yyyy-mm-dd hh24:mi:ss'),'yyyy') FROM dual;   -- 返回当前日期年的第一天
SELECT trunc(to_date('2017-06-29 14:25:55','yyyy-mm-dd hh24:mi:ss'),'mm') FROM dual;   -- 返回当前日期月的第一天
SELECT trunc(to_date('2017-06-29 14:25:55','yyyy-mm-dd hh24:mi:ss'),'dd') FROM dual;   -- 返回当前日期的年月日
SELECT trunc(to_date('2017-06-29 14:25:55','yyyy-mm-dd hh24:mi:ss'),'d') FROM dual;   -- 返回当前日期的星期的第一天
SELECT trunc(to_date('2017-06-29 14:25:55','yyyy-mm-dd hh24:mi:ss'),'hh') FROM dual;   -- 返回当前日期的小时
SELECT trunc(sysdate,'hh') FROM dual;   -- 返回当前日期的小时




-- 取余 mod()
SELECT mod(10,4) from dual;
-- 日期类型 sysdate
SELECT sysdate from dual;
-- 日期+1 加到天数上
SELECT sysdate+1 from dual;
-- 日期-日期=天数
SELECT  sysdate-1 from dual;
-- 求天数
SELECT sysdate-hiredate from scott.emp;
-- 求周数
SELECT (sysdate-hiredate)/7 from SCOTT.emp;

-- 求两个时间相差的月数  MONTHS_BETWEEN
SELECT MONTHS_BETWEEN(sysdate,hiredate) FROM SCOTT.emp;
SELECT MONTHS_BETWEEN(TO_DATE('2013-12-12', 'yyyy-mm-dd'), TO_DATE('2012-12-12', 'yyyy-mm-dd')) FROM SCOTT.emp;
-- 加月数  "ADD_MONTHS"(date, int)
SELECT add_months(sysdate,1) from dual;


-- 转换函数  "TO_CHAR"(x)  转换为字符
SELECT to_char('132') from dual;
SELECT to_char(123) from dual;


	-- 日期转换为字符
SELECT to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;
SELECT to_char(sysdate,'yyyy-mm-dd') from dual;
SELECT sysdate from dual;
			-- 格式化数字
SELECT to_char(333333333,'$999,999,999') from dual;   -- $333,333,333
SELECT to_char(1234567.23,'999999999.0000') from dual;   -- 1234567.2300

select to_char(0.123,'99999999.9900') from dual;  -- .1230
select to_char(0.123,'99999990.9900') from dual;  -- 0.1230


-- 字符转换为数字
SELECT to_number('123') from dual;
-- 将字符转换为日期
SELECT to_date('2011-11-11','yyyy-mm-dd') from dual;
-- 将日期转换为字符
select to_char(hiredate,'yyyy-MM-dd') from SCOTT.emp;


-- 通用函数
-- nvl(p1,p2) 如果p1为null,，则返回p2
SELECT nvl(null,0) from dual;   -- 0 
SELECT nvl(0,null) from dual;   -- 1
SELECT e.*,nvl(comm,0) FROM SCOTT.EMP e;

-- sign(n) 若n=0,则返回0,否则,n>0,则返回1,n<0,则返回-1 
select sign(12) from dual; 1



-- nvl2(p1,p2,p3) 如果p1为null返回p3,否者返回p3
SELECT nvl2(1,10,100) FROM dual;   -- 10
SELECT nvl2(null,10,100) FROM dual;  -- 100


-- "NULLIF"(expr1, expr2) 比较expr1,expr2,如果expr1=expr2则返回null,  否则返回p1
SELECT NULLIF(100, 100) FROM dual;   -- NULL
SELECT NULLIF(99, 100) FROM dual;    -- 99 



-- "COALESCE"(expr1, ... exprn)  返回第一个不为null的值
SELECT coalesce(1,2,2,null) from dual;		-- 1
SELECT coalesce(null,null,100) from dual;	-- 100
SELECT coalesce(null,100,null) from dual;	-- 100


-- case when
/*
	case 字段
	when 条件1 then 值1
	when 条件2 then 值2
	else 值
    end
*/
-- 实例1
SELECT
	E .*, CASE ename
WHEN 'SMITH' THEN
	'张三'
WHEN 'ALLEN' THEN
	'李四'
END
FROM
	SCOTT.emp E;

-- 实例2
SELECT
	E .*, CASE ename
WHEN 'SMITH' THEN
	'张三'
WHEN 'ALLEN' THEN
	'李四'
ELSE '无名'
END
FROM
	SCOTT.emp E;
	
	
	
 --decode(字段,条件1，值1，条件2，值2.....[值])  只在oracle中使用
SELECT e.*,decode(ENAME,'SMITH','张三','ALLEN','李四','无名') FROM SCOTT.EMP e;



-- 多行(聚合函数，组函数)
		-- 计数 count()
SELECT count(1) from SCOTT.emp;
		-- 求和 sum()
SELECT sum(sal) from SCOTT.emp;
		-- 求平均数 avg()
SELECT avg(sal) FROM SCOTT.emp;
		-- 最大值 max()
SELECT max(sal) FROM SCOTT.emp;
		-- 最小值 min()
SELECT min(sal) FROM SCOTT.emp;


-- 分组 GROUP BY
      --注意：select 后如果出现普通字段，则这个普通字段，必须要在group by后出现
		-- 求各组的平均工资
SELECT deptno,avg(SAL) FROM SCOTT.EMP e GROUP BY e.deptno;
  -- 统计各部门人数
SELECT count(1) from SCOTT.EMP e GROUP BY e.DEPTNO;


--筛选having
      --统计各部门平均工资,并且查询出平均工资>2000的部门编号
        --统计各部门平均工资
        --筛选
SELECT DEPTNO,avg(sal) FROM SCOTT.emp e GROUP BY e.DEPTNO  HAVING avg(sal)>2000;
/*
	where与having的区别
		位置:where 在group by之前  having在group by 之后
		执行顺序：where在分组之前执行 having在分组之后执行
		where后面不能跟聚合函数，having后面能跟聚合函数
*/


-- 分组排序
SELECT * FROM SCOTT.EMP ; 
SELECT EMPNO,ENAME,SAL,DEPTNO,Row_number() over( order by sal) rs FROM SCOTT.EMP;
SELECT EMPNO,ENAME,SAL,DEPTNO,Row_number() over(partition by DEPTNO order by sal) rs FROM SCOTT.EMP;


-- 行转列
-- listagg() WITHIN GROUP ()
SELECT
	T .DEPTNO,
	listagg (T .ENAME, ',') WITHIN GROUP (ORDER BY T .ENAME) names
FROM
	SCOTT.EMP T
-- WHERE
-- 	 T .DEPTNO = '20'
GROUP BY
	T .DEPTNO;

SELECT
	T .DEPTNO,
	listagg (T .ENAME, ',') WITHIN GROUP (ORDER BY T .ENAME) names
FROM
	SCOTT.EMP T
GROUP BY
	T .DEPTNO;
-- listagg() within GROUP () over
SELECT
	T .DEPTNO,
	listagg (T .ENAME, ',') WITHIN GROUP (ORDER BY T .ENAME)  over(PARTITION BY T .DEPTNO)
FROM
	SCOTT.EMP T
WHERE
	T .DEPTNO = '20' 


-- 使用虚表演示
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




```

