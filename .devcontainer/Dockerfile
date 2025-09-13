# Use the official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    build-essential \
    gdb \
    pkg-config \
    xz-utils \
    sudo \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install D compiler (DMD) and DUB package manager
RUN wget https://netcologne.dl.sourceforge.net/project/d-apt/files/d-apt.list -O /etc/apt/sources.list.d/d-apt.list \
    && apt-get update --allow-insecure-repositories \
    && apt-get -y --allow-unauthenticated install --reinstall d-apt-keyring \
    && apt-get update \
    && apt-get install -y dmd-compiler dub \
    && rm -rf /var/lib/apt/lists/*

# Install LDC (LLVM-based D compiler) as an alternative
RUN apt-get update \
    && apt-get install -y ldc \
    && rm -rf /var/lib/apt/lists/*

# Install DCD (D Completion Daemon) for better IDE support
RUN git clone https://github.com/dlang-community/DCD.git /tmp/DCD \
    && cd /tmp/DCD \
    && git submodule update --init --recursive \
    && dub build --config=client \
    && dub build --config=server \
    && cp bin/dcd-client /usr/local/bin/ \
    && cp bin/dcd-server /usr/local/bin/ \
    && chmod +x /usr/local/bin/dcd-* \
    && rm -rf /tmp/DCD

# Install dfmt (D formatter)
RUN git clone https://github.com/dlang-community/dfmt.git /tmp/dfmt \
    && cd /tmp/dfmt \
    && dub build \
    && cp bin/dfmt /usr/local/bin/ \
    && chmod +x /usr/local/bin/dfmt \
    && rm -rf /tmp/dfmt

# Install dscanner (D static analysis tool)
RUN git clone https://github.com/dlang-community/D-Scanner.git /tmp/dscanner \
    && cd /tmp/dscanner \
    && git submodule update --init --recursive \
    && dub build \
    && cp bin/dscanner /usr/local/bin/ \
    && chmod +x /usr/local/bin/dscanner \
    && rm -rf /tmp/dscanner

# Set the default user
USER $USERNAME

# Set working directory
WORKDIR /workspace

# Verify installation
RUN dmd --version && dub --version && ldc2 --version