FROM centos:7
MAINTAINER Christoph Wiechert <wio@psitrax.de>
ENV REFRESHED_AT="2016-10-31"
ENV TIMEZONE="Europe/Berlin" \
    RUN_ID="" \
    XDEBUG="false"

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
      php70u-bcmath \
      php70u-cli \
      php70u-fpm \
      php70u-fpm-httpd \
      php70u-gd \
      php70u-pecl-imagick \
      php70u-intl \
      php70u-json \
      php70u-mbstring \
      php70u-mcryp \
      php70u-mysqlnd \
      php70u-snmp \
      php70u-soap \
      php70u-xml \
      php70u-pecl-xdebug \
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

CMD ["/init"]
