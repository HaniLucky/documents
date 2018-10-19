#### nginx配置访问前端工程

##### 1.前端工程目录

```
crm-view
	|-- view
		|-- user.html
```

##### 2.工程位置

`C:\Users\Administrator\Desktop\CRM系统\crm-view`

##### 3.配置nginx

找到nginx安装目录打开conf/nginx.conf添加如下节点配置

```
#vue工程跳转
	server {
		#访问端口
        listen 8081;
        server_name localhost;


        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        root html;
        }

		# 页面跳转
        root C:\Users\Administrator\Desktop\CRM系统\crm-view;
        index index.html;


        location / {
        try_files $uri $uri/ @router;
        index index.html;
        }


        location @router {
        rewrite ^.*$ /index.html last;
        }
	}

```

##### 4.通过nginx访问页面

`http://127.0.0.1:8081/view/user.html`