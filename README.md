# Dockerfile for stack Nginx-Apache-PHP7-MongoDB3

Nginx proxy + Apache-2.4 + PHP7 + MongoDB + supervisord on CentOS 7

`Build image`
```
docker build -t keepwalking/leamp-stack .
```

`Run container`
```
docker run -d -p 80:80 keepwalking/leamp-stack
```
