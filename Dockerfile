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
WORKDIR /tmp
RUN curl -O https://cache.ruby-lang.org/pub/ruby/4.0/ruby-4.0.1.tar.gz && tar -xzf ruby-4.0.1.tar.gz
WORKDIR /tmp/ruby-4.0.1
RUN ./configure --host=arm-linux-gnueabihf --prefix=/opt/ruby-4.0.1 --disable-install-doc
RUN make -j$(nproc) && make install
RUN tar -czvf /ruby-4.0.1-armhf-debian13.tar.gz -C / opt/ruby-4.0.1
CMD ["/bin/true"]
