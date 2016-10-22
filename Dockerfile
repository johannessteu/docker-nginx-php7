FROM alpine:edge
MAINTAINER Johannes Steu <js@johannessteu.de>

RUN apk --update add php7 php7-fpm nginx supervisor bash vim --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/

RUN mkdir -p /data/www/vhost \
    && mkdir -p /data/logs \
    && mkdir -p /data/tmp/nginx \
    && mkdir -p /data/tmp/php \
    && mkdir -p /data/tmp/php/uploads \
    && mkdir -p /data/tmp/php/sessions

RUN rm -rf /etc/nginx/*.d /etc/nginx/*_params

RUN deluser nginx
RUN addgroup -g 8080 -S www
RUN adduser -u 8080 -D -S -h /data/www -G www www

RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

ADD /container-files/etc /etc

EXPOSE 80 443

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]