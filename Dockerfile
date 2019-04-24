FROM centos:7
MAINTAINER Christoph Wiechert <wio@psitrax.de>
ENV REFRESHED_AT="2019-04-24"
ENV TIMEZONE="Europe/Berlin" \
    RUN_UID="" \
    XDEBUG="false" \
    PHP_VALUE="" \
    PHP_ADMIN_VALUE=""

RUN yum install epel-release yum-utils -y \
  && yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
  && yum-config-manager --enable remi-php73 \
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
      unzip \
      httpd \
      mod_php \
      php-bcmath \
      php-cli \
      php-gd \
      php-pecl-imagick \
      php-intl \
      php-json \
      php-mbstring \
      php-mcryp \
      php-mysqlnd \
      php-opcache \
      php-snmp \
      php-soap \
      php-xml \
      php-pecl-zip \
      php-pecl-xdebug \
  && curl -sSL https://getcomposer.org/download/1.8.5/composer.phar -o /usr/local/bin/composer-bin \
  && chmod +x /usr/local/bin/composer-bin \
  && rm -rf /var/www/* \
  && chsh -s /bin/bash apache \
  && yum clean all \
  && localedef -i en_US -f UTF-8 en_US.UTF-8

ADD rootfs /

EXPOSE 80
VOLUME ["/var/www"]
WORKDIR /var/www

CMD ["/init"]
