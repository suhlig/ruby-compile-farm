FROM --platform=linux/arm/v7 debian:trixie
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
WORKDIR /tmp
RUN curl -O https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION%.*}/ruby-${RUBY_VERSION}.tar.gz && tar -xzf ruby-${RUBY_VERSION}.tar.gz
WORKDIR /tmp/ruby-${RUBY_VERSION}
RUN ./configure --host=arm-linux-gnueabihf --prefix=/opt/ruby-${RUBY_VERSION} --disable-install-doc
RUN make -j$(nproc) && make install
RUN tar -czvf /ruby-${RUBY_VERSION}-armhf-debian13.tar.gz -C / opt/ruby-${RUBY_VERSION}
CMD ["/bin/true"]
