# Dockerfile for stack Nginx-Apache-PHP7-MongoDB3

Nginx proxy + Apache-2.4 + PHP7 + MongoDB + supervisord on CentOS 7

`Build image`
```
docker build -t keepwalking/leamp-stack .
```

`Run container`
```
docker run -d -p 8088:80 -p 27017:27017 -v `pwd`/app:/var/www/html -v `pwd`/mongo:/data/db --name leamp-stack keepwalking/leamp-stack
```
