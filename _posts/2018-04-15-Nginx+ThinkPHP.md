---
title: Nginx+ThinkPHP配置
type: Nginx
date: 2018-04-15 18:22:49
category: 
- 后端开发
tags:
- Nginx
- ThinkPHP
---

### 修改配置文件
```shell
sudo vim /etc/nginx/nginx.conf
```

### 配置文件内容
```ini
# http://wiki.nginx.org/Pitfalls
# http://wiki.nginx.org/QuickStart
# http://wiki.nginx.org/Configuration

server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /var/www/html;

	index index.php index.html index.htm index.nginx-debian.html;

	server_name _;
	location / {
        if (!-e $request_filename) {
	        rewrite ^/index.php(.*)$ /index.php?s=$1 last;
	        rewrite ^(.*)$ /index.php?s=$1 last;
        	break;
	    }
	}
	sendfile off;
	client_max_body_size 100m;

	location ~ \.php$ {
		root    /var/www/html/;                           #php文件所在的根目录
		index index.html index.htm index.php;
        fastcgi_pass 127.0.0.1:9000;                      #fpm监听的IP和端口
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;

	}
	location ~ .*\.(gif|jpg|jpeg|png)$ {  
	    expires 24h;  
	}

}
```