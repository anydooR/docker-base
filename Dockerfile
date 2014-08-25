FROM ubuntu:trusty

# time zone
RUN cp -rf  /usr/share/zoneinfo/Japan /etc/localtime

# locale
RUN locale-gen ja_JP.UTF-8 && \
    locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nodejs
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN apt-get install -y npm
