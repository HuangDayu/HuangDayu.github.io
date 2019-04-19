---
title: Nginx反向代理Tomcat
type: Nginx
date: 2018-02-20 10:24:14
category: 
- 后端开发
tags:
- Nginx
- Apache
- Tomcat
---

### 修改配置文件
```shell
sudo vim /etc/nginx/nginx.conf
```

<!-- more -->

### 配置文件内容
```ini
server {
        root /var/www/html;
        server_name yibuwulianwang.com;
        listen 443;
        ssl on;
        ssl_certificate    cert/yibuwulianwang.com.crt;
        ssl_certificate_key   cert/yibuwulianwang.com.key;
        ssl_session_timeout 5m;
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    	ssl_prefer_server_ciphers on;

        location / {
                index index.html index.htm;
                proxy_pass https://yibuwulianwang.com:8443;
        }

        location ~ \.jsp$ {
                proxy_pass https://yibuwulianwang.com:8443;
        }

        location ~ \.(html|js|css|png|gif|jpg)$ {
                root /opt/tomcat/9.0.2/webapps/ROOT;
        }

}

server {
        listen 80;
        server_name yibuwulianwang.com;
        rewrite ^(.*)$ https://$server_name$1 permanent;
}
```