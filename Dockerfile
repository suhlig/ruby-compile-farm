FROM --platform=linux/arm/v7 debian:trixie

# 1. Update package lists and install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    libyaml-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. Download and extract Ruby 4.0.1
WORKDIR /tmp
RUN curl -O https://cache.ruby-lang.org/pub/ruby/4.0/ruby-4.0.1.tar.gz && \
    tar -xzf ruby-4.0.1.tar.gz

# 3. Configure the build
WORKDIR /tmp/ruby-4.0.1
RUN ./configure --host=arm-linux-gnueabihf --prefix=/opt/ruby --disable-install-doc

# 4. Compile
RUN make -j$(nproc) && make install

# 5. Package the compiled installation into a tarball
RUN tar -czvf /ruby-4.0.1-armhf-debian13.tar.gz -C / opt/ruby

CMD ["/bin/bash"]
