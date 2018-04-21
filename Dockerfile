FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    curl ca-certificates xz-utils locales

RUN locale-gen en_US.UTF-8
RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8

# Tools install
RUN apt-get update && apt-get install -y \
    software-properties-common \
    openssh-client \
    rsync \
    bzip2 \
    git \
    sass \
    libmcrypt-dev \
    wget \
    screen \
    libffi-dev \
    build-essential \
    redis-server \
    unzip \
    zip \
    ruby-compass \
    apt-transport-https \
    gnupg2 \
    sudo

# Node install
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

# PHP install
RUN add-apt-repository ppa:ondrej/php && \
    apt-get update && apt-get install -y \
    php7.1 \
    php7.1-curl \
    php7.1-ldap \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-mysql \
    php7.1-phpdbg \
    php7.1-xml \
    php7.1-zip \
    php7.1-soap \
    php7.1-gd \
    php-memcached \
    composer && \
    update-alternatives --set php /usr/bin/php7.1

# Python install
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-virtualenv \
    python-virtualenv

# Docker install
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#RUN apt-get update && apt-get install -y docker-ce    

RUN composer global require hirak/prestissimo

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y mysql-server mysql-client libmysqlclient-dev --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
