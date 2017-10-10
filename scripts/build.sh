#!/bin/bash 
set -ex
groupadd -g 200 rails && useradd --create-home -s /bin/bash -u 200 -g 200 rails 
echo 'umask 002' > /etc/profile.d/umask.sh

cp /tmp/scripts/dinit /tmp/scripts/dget /usr/local/bin

apt-get update

# install default package 
apt-get install -y --no-install-recommends  \
  unattended-upgrades \
  locales \
  realpath \
  zip \
  iproute2 \
  vim \
  lsof \
  strace\
  less  \
  unzip \
  bzip2 \
  ca-certificates \
  curl \
  libgdbm3 \
  procps \
  wget \
  sudo \
  python-pip \
  python-setuptools \
  tzdata \
  libcurl3 \
  libcurl4-openssl-dev \
  libffi-dev \
  libssl-dev \
  libyaml-dev \
  zlib1g-dev 

unattended-upgrades -d  

echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen 

# install EntryKit
wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz
tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz 
rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz 
mv entrykit /bin/entrykit 
chmod +x /bin/entrykit 
entrykit --symlink

# install Sigil 
wget https://github.com/gliderlabs/sigil/releases/download/v${SIGIL_VERSION}/sigil_${SIGIL_VERSION}_Linux_x86_64.tgz
tar -xvzf sigil_${SIGIL_VERSION}_Linux_x86_64.tgz 
rm sigil_${SIGIL_VERSION}_Linux_x86_64.tgz 
mv sigil /bin/sigil
chmod +x /bin/sigil

# time zone
rm /etc/localtime
ln -s  /usr/share/zoneinfo/Japan /etc/localtime

# install aws cli
pip install awscli

apt-get purge -y --auto-remove libssl-dev  libyaml-dev  zlib1g-dev libcurl4-openssl-dev  libffi-dev 
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

