FROM ubuntu:16.04

MAINTAINER clement.dugal@gmail.com

RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables \
    xz-utils \
    locales \
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
    sudo \
    dmsetup

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y docker-ce && \
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

VOLUME /var/lib/docker
ENV LOG=file
ENTRYPOINT ["wrapdocker"]
CMD []