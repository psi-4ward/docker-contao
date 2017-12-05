FROM centos:7
MAINTAINER Christoph Wiechert <wio@psitrax.de>
ENV REFRESHED_AT="2017-12-05"
ENV TIMEZONE="Europe/Berlin" \
    RUN_ID="" \
    XDEBUG="false" \
    PHP_VALUE="" \
    PHP_ADMIN_VALUE=""

RUN yum install epel-release -y \
  && yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
  && yum upgrade -y \
  && yum install -y \
      git \
      less \
      vim \
      wget \
      net-tools \
      locales \
      sendmail \
      openssl \
      ca-certificates \
      bzip2 \
      httpd \
      php71u-bcmath \
      php71u-cli \
      php71u-fpm \
      php71u-fpm-httpd \
      php71u-gd \
      php71u-pecl-imagick \
      php71u-intl \
      php71u-json \
      php71u-mbstring \
      php71u-mcryp \
      php71u-mysqlnd \
      php71u-snmp \
      php71u-soap \
      php71u-xml \
      php71u-pecl-xdebug \
  && wget https://getcomposer.org/download/1.2.1/composer.phar -O /usr/bin/composer \
  && chmod +x /usr/bin/composer \
  && rm -rf /var/www/* \
  && chsh -s /bin/bash apache \
  && yum clean all

ADD rootfs /
RUN chown apache /usr/share/httpd

EXPOSE 80
VOLUME ["/var/www"]
WORKDIR /var/www
HEALTHCHECK CMD curl -f http://localhost/ || exit 1

CMD ["/init"]
