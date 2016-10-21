FROM alpine:latest
MAINTAINER Johannes Steu <js@johannessteu.de>

# Install packages
RUN apk --update add php7 php7-fpm nginx supervisor bash vim --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/

# Add application
RUN mkdir -p /data/www/vhost
RUN mkdir -p /data/logs
RUN mkdir -p /data/tmp/nginx
RUN rm -rf /etc/nginx/*.d /etc/nginx/*_params

RUN deluser nginx

RUN  addgroup -g 8080 -S www
RUN adduser -u 8080 -D -S -h /data/www -G www www

RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

ADD docker-files /

EXPOSE 80 443

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]