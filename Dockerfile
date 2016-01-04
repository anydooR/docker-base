FROM ubuntu:14.04.3

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
RUN echo 'umask 002' > /etc/profile.d/umask.sh

# apt
#RUN sed -i~ -e 's;http://archive.ubuntu.com/ubuntu;http://ftp.jaist.ac.jp/pub/Linux/ubuntu;' /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y --no-install-recommends  && apt-get -y install --no-install-recommends  \
    git curl wget \
    build-essential libtool \
    ca-certificates bzip2\
    openssl ssl-cert libssl-dev \
    libreadline6 libreadline6-dev \
    zlib1g zlib1g-dev \
    lsof strace ltrace \
    libsqlite3-0 libsqlite3-dev sqlite3 \
    vim unzip \
    libxml2-dev libxslt1-dev libc6-dev mysql-client-5.6 mysql-client-core-5.6 libmysqlclient-dev \
    libmagick++-dev && apt-get clean &&  rm -rf /var/lib/apt/lists/*

RUN   ln -s `which python3` /usr/local/bin/python  && curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" &&  unzip awscli-bundle.zip && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && rm -rf awscli-bundle*
