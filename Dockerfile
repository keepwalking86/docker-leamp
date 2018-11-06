FROM centos:7

MAINTAINER KeepWalking86

#Installing repo epel, webstatic
RUN yum -y install epel-release && \
    rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

#Installing PHP7
RUN yum install -y php71w php71w-common php71w-gd php71w-phar \
    php71w-xml php71w-cli php71w-mbstring php71w-tokenizer \
    php71w-openssl php71w-pdo php71w-devel && \
    yum -y install php71w-opcache php71w-pear

####Installing & configuring Apache-2.4
#Install Apache
RUN yum -y install httpd

# Copy a configuration file from the current directory
COPY etc/httpd.conf /etc/httpd/conf/

#Installing & configuring MongoDB-3X
COPY etc/mongodb.repo /etc/yum.repos.d/
RUN yum update -y
RUN yum install mongodb-org -y
#Create DB storage
RUN mkdir -p /data/db && chown -R mongod:mongod /data
#Copy a new configuration file from current directory
COPY etc/mongod.conf /etc/

###Installing & Configuring Nginx
RUN yum install -y nginx
COPY etc/nginx.conf /etc/nginx/
#Copy proxy params configuration file
COPY etc/proxy_params /etc/nginx/

# Installing & Configuring Supervisord
#Install supervisord
RUN yum -y install python-setuptools
RUN easy_install supervisor
#Copy a new configuration file
COPY etc/supervisord.conf /etc/supervisord.conf
## Set the default command to execute
CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]

##Clearing the yum caches
RUN yum clean all

# Expose ports
EXPOSE 80 8080 27017


