##### 1 执行 yum -y install python-setuptools 安装python的包管理工具

##### 2 执行easy_install pip #安装pip  安装python的包管理工具 

##### 3 安装 shadowsocks

​	easy_install  shadowsocks

##### 4配置

```
{
	"server": "144.34.172.160",
	"server_port": 8989,
	"local_address": "127.0.0.1",
	"local_port": 1080,
	"password": "123456789",
	"timeout": 600,
	"method": "aes-256-cfb",
	"fast_open": false,
	"workers": 1
}

```

#####  启动

```
ssserver -c /etc/shadowsocks.json -d start #启动
ssserver -c /etc/shadowsocks.json -d stop #停止
```

日志文件路径：**/var/log/shadowsocks.log** 

参考[1].https://blog.csdn.net/gekkoou/article/details/50839785