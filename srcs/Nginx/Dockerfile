############# NGINX IAGE

FROM ft_service_alpine:latest 

MAINTAINER bvalette <bvalette@student.42.fr>

LABEL project=ft_service
LABEL service=nginx

EXPOSE 80
EXPOSE 443
EXPOSE 22

# INSTALL ALL PACKAGED
RUN apk update && apk upgrade && apk add nginx openssh

#SSL CERTIFICATE
RUN openssl req -x509 \
-subj "/C=FR/ST=PARIS/L=Paris/O=42_Corp/OU=bvalette/CN=bvalette@student.42.fr"	\
-nodes				\
-days 7300 			\
-newkey rsa:2048 	\
-keyout /etc/ssl/private/nginx-selfsigned.key		\
-out /etc/ssl/certs/nginx-selfsigned.crt 			\
&& chmod 600 /etc/ssl/private/nginx-selfsigned.key 	\	
&& openssl dhparam -out /etc/ssl/certs/dhparam.pem 128 

# ADD CONFIG FILE FOR NGNINX
RUN mkdir -p /etc/nginx/includes
RUN sed -i "s/ssl_session_cache shared:SSL:2m/ssl_session_cache shared:SSL:10m/" /etc/nginx/nginx.conf 
COPY ssl-params.conf ssl-self-signed.conf /etc/nginx/includes/ 
COPY site.conf /etc/nginx/conf.d/default.conf

# ADD SUPERVISOR CONFIG FILE
COPY supervisord.conf /etc/supervisord.conf

# CREATE A BASIC WEBPAGE
RUN mkdir /tmp/mynginx
COPY webpage.tar.gz /tmp/mynginx/
RUN cd /tmp/mynginx && tar -xf /tmp/mynginx/webpage.tar.gz

# CREATE DIRECTORY TO BE ABLE TO EXECUTE NGINX
RUN mkdir /run/nginx

COPY sshd_config /etc/ssh/
COPY start.sh /bin/start.sh
COPY ssh_banner /etc/issue

RUN ssh-keygen -A && chmod 700 /bin/start.sh

# DEFAULT COMMAND :
CMD ["./bin/start.sh"]
