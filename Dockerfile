FROM debian:jessie
ENV LANG=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive 
ENV ENTRYKIT_VERSION=0.4.0
ENV SIGIL_VERSION=0.4.0

COPY scripts   /tmp/scripts
RUN bash -x  /tmp/scripts/build.sh

ENV HOME /home/rails
