***查看日志***

`tail -f logName.log`

***vi/vim命令***

```
vi fileName
	i 进入编辑模式
	ctrl+c 退出编辑模式
	:wq 退出并保存
	:q! 退出不保存
```

***关闭一个进程***

```
# 根据应用名查询pid  返回pid
ps -ef | grep applicationName
# 杀死一个进程
kill -9 [pid]
```

***脚本添加可执行权限***

```
chmod是权限管理命令change the permissions mode of a file的缩写。。
u代表所有者，x代表执行权限。 + 表示增加权限。
chmod u+x file.sh 就表示对当前目录下的file.sh文件的所有者增加可执行权限。
```

##### 查看ip地址

`ifconfig`

##### 使用less查看文件文件内容

`less 文件名`

##### 查看文件类型

`file 文件名`

##### 全局查找文件

 `find -name 文件名`

#####  防火墙命令

```
service iptables status   查看防火墙状态 
service iptables start    启动防火墙
service iptables stop     关闭防火墙
```

