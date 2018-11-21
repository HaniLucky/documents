##### 解决使用工具无法连接mysql的问题

mysql -u root -p  
mysql;use mysql;  
mysql;select 'host' from user where user='root';  
mysql;update user set host = '%' where user ='root';  
mysql;flush privileges;  
mysql;select 'host'   from user where user='root'; 

 第一句是以权限用户root登录 

第二句：选择mysql库

 第三句：查看mysql库中的user表的host值（即可进行连接访问的主机/IP名称）

 第四句：修改host值（以通配符%的内容增加主机/IP地址），当然也可以直接增加IP地址 

第五句：刷新MySQL的系统权限相关表

 第六句：再重新查看user表时，有修改。。

 重启mysql服务即可完成。

