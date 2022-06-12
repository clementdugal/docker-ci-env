FROM ubuntu:20.04

MAINTAINER clement@dugal.net

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -qqy \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    locales \
    software-properties-common

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -qqy \
    curl \
    openssh-client \
    lxc \
    iptables \
    xz-utils \
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
    apt-transport-https \
    gnupg2 \
    sudo \
    dmsetup

RUN locale-gen en_US.UTF-8
RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh && \
    apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -s -L https://github.com/docker/compose/releases/latest | \
    egrep -o '/docker/compose/releases/download/[0-9.]*/docker-compose-Linux-x86_64' | \
    wget --base=http://github.com/ -i - -O /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    /usr/local/bin/docker-compose --version

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Node install
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# PHP install
RUN add-apt-repository ppa:ondrej/php && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    php7.4 \
    php7.4-curl \
    php7.4-ldap \
    php7.4-mbstring \
    php7.4-mcrypt \
    php7.4-mysql \
    php7.4-phpdbg \
    php7.4-xml \
    php7.4-zip \
    php7.4-soap \
    php7.4-gd \
    php-memcached && \
    update-alternatives --set php /usr/bin/php7.4

# Composer install
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

# Python install
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python3 \
    python3-pip \
    python3-virtualenv

VOLUME /var/lib/docker
ENV LOG=file
ENTRYPOINT ["wrapdocker"]
CMD []
