# Dockerfile for running CI checks locally
# Replicates the GitHub Actions CI environment for tw-idrinth mod

FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install base dependencies
RUN apt-get update && apt-get install -y \
    lua5.1 \
    liblua5.1-dev \
    python3 \
    curl \
    unzip \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Luarocks 3.13.0 (matching CI version)
RUN wget -q https://luarocks.org/releases/luarocks-3.13.0.tar.gz \
    && tar zxpf luarocks-3.13.0.tar.gz \
    && cd luarocks-3.13.0 \
    && ./configure --with-lua=/usr \
    && make \
    && make install \
    && cd .. \
    && rm -rf luarocks-3.13.0 luarocks-3.13.0.tar.gz

# Install Luacheck via Luarocks
RUN luarocks install luacheck

# Install Selene 0.29.0 (matching CI version)
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then \
        SELENE_URL="https://github.com/Kampfkarren/selene/releases/download/0.29.0/selene-0.29.0-linux-aarch64.zip"; \
    else \
        SELENE_URL="https://github.com/Kampfkarren/selene/releases/download/0.29.0/selene-0.29.0-linux.zip"; \
    fi && \
    curl -L "$SELENE_URL" -o /tmp/selene.zip \
    && unzip /tmp/selene.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/selene \
    && rm /tmp/selene.zip

# Set working directory
WORKDIR /workspace

# Copy entrypoint script
COPY ci-entrypoint.sh /usr/local/bin/ci-entrypoint.sh
RUN chmod +x /usr/local/bin/ci-entrypoint.sh

# Default command runs all CI checks
ENTRYPOINT ["/usr/local/bin/ci-entrypoint.sh"]
