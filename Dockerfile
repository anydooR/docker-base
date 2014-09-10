FROM ubuntu:trusty

# time zone
RUN cp -rf  /usr/share/zoneinfo/Japan /etc/localtime

# add user
RUN groupadd -g 200 rails && useradd --create-home -s /bin/bash -u 200 -g 200 rails ;\
 adduser rails sudo

ADD dinit /usr/sbin/dinit

# locale
RUN locale-gen ja_JP.UTF-8 && \
    locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# apt
RUN sed -i~ -e 's;http://archive.ubuntu.com/ubuntu;http://ftp.jaist.ac.jp/pub/Linux/ubuntu;' /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y && apt-get -y install \
    git curl wget \
    build-essential libtool \
    openssl libssl-dev ssl-cert \
    libreadline6 libreadline6-dev \
    zlib1g zlib1g-dev \
    lsof strace ltrace \
    libsqlite3-0 libsqlite3-dev sqlite3 \
    unzip \
    vim \
    libxml2-dev libxslt1-dev libc6-dev mysql-client libmysqlclient-dev libmagick++-dev && apt-get clean
