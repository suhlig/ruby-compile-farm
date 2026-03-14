ARG DOCKER_PLATFORM=linux/arm/v7
ARG BASE_IMAGE=debian:13
FROM --platform=${DOCKER_PLATFORM} ${BASE_IMAGE}
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    libyaml-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*
ARG RUBY_VERSION=4.0.1
ARG GNU_HOST=arm-linux-gnueabihf
ARG PLATFORM_LABEL=armhf-debian-13
WORKDIR /tmp
RUN curl -O https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION%.*}/ruby-${RUBY_VERSION}.tar.gz && tar -xzf ruby-${RUBY_VERSION}.tar.gz
WORKDIR /tmp/ruby-${RUBY_VERSION}
RUN ./configure --host=${GNU_HOST} --prefix=/opt/ruby-${RUBY_VERSION} --disable-install-doc
RUN make -j$(nproc) && make install
RUN tar -czvf /ruby-${RUBY_VERSION}-${PLATFORM_LABEL}.tar.gz -C / opt/ruby-${RUBY_VERSION}
CMD ["/bin/true"]
