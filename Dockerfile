FROM centos:7

MAINTAINER KeepWalking

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

# Remove the default configuration file
RUN rm -v /etc/httpd/conf/httpd.conf

# Copy a configuration file from the current directory
ADD etc/httpd.conf /etc/httpd/conf/

####Installing & configuring MongoDB-3.4
#Add mongodb.repo
ADD etc/mongodb.repo /etc/yum.repos.d/
#Install MongoDB
RUN yum install mongodb-org -y
#Create DB storage
RUN mkdir -p /data/db && chown -R mongod:mongod /data
#Remove the default configuration file
RUN rm -v /etc/mongod.conf
#Copy a new configuration file from current directory
ADD etc/mongod.conf /etc/
#Install mongo-php-library
RUN yum -y install php71w-pecl-mongodb

####Installing & Configuring Nginx
#Install Nginx
RUN yum install -y nginx  

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD etc/nginx.conf /etc/nginx/

#Copy proxy params configuration file
ADD etc/proxy_params /etc/nginx/

# Installing & Configuring Supervisord
#Install supervisord
RUN yum -y install python-setuptools
RUN easy_install supervisor
#Copy a new configuration file
ADD etc/supervisord.conf /etc/supervisord.conf

# Expose ports
EXPOSE 80 8080 27017

## Set the default command to execute
CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]
