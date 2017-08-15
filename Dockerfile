FROM ubuntu:16.04

RUN apt-get clean && apt-get update \
    && apt-get install -qy locales tzdata apt-utils \
    && locale-gen en_US.UTF-8 \
    && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update -qy \
    && apt-get upgrade -qy --force-yes \
    && apt-get dist-upgrade -qy --force-yes \
    && apt-get install -qy curl wget zip unzip git software-properties-common build-essential perl cpanminus \
    && cpanm Term::ReadLine DateTime Time::Local Net::LDAP Net::LDAP::Util Test::Class Test::Base Test::More Test::Net::LDAP::Mock \
    && apt-get remove -qy --purge software-properties-common \
    && apt-get autoclean -qy \
    && apt-get autoremove -qy --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf $HOME/.cpanm/work/* $HOME/.cpanm/build.log

ENTRYPOINT ["/usr/bin/perl"]
