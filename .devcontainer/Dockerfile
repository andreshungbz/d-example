# Use the official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Create a non-root user first
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install system dependencies and D toolchain in one layer
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
    && wget https://netcologne.dl.sourceforge.net/project/d-apt/files/d-apt.list -O /etc/apt/sources.list.d/d-apt.list \
    && apt-get update --allow-insecure-repositories \
    && apt-get -y --allow-unauthenticated install --reinstall d-apt-keyring \
    && apt-get update \
    && apt-get install -y dmd-compiler dub ldc \
    && rm -rf /var/lib/apt/lists/*

# Install D development tools (DCD, dfmt, dscanner) as non-root user
USER $USERNAME
WORKDIR /tmp

# Install DCD (D Completion Daemon)
RUN git clone https://github.com/dlang-community/DCD.git \
    && cd DCD \
    && git submodule update --init --recursive \
    && dub build --config=client \
    && dub build --config=server \
    && sudo cp bin/dcd-client /usr/local/bin/ \
    && sudo cp bin/dcd-server /usr/local/bin/ \
    && sudo chmod +x /usr/local/bin/dcd-* \
    && cd .. && rm -rf DCD

# Install dfmt (D formatter)
RUN git clone https://github.com/dlang-community/dfmt.git \
    && cd dfmt \
    && dub build \
    && sudo cp bin/dfmt /usr/local/bin/ \
    && sudo chmod +x /usr/local/bin/dfmt \
    && cd .. && rm -rf dfmt

# Install dscanner (D static analysis tool)
RUN git clone https://github.com/dlang-community/D-Scanner.git dscanner \
    && cd dscanner \
    && git submodule update --init --recursive \
    && dub build \
    && sudo cp bin/dscanner /usr/local/bin/ \
    && sudo chmod +x /usr/local/bin/dscanner \
    && cd .. && rm -rf dscanner

# Set working directory
WORKDIR /workspace

# Verify installation
RUN dmd --version && dub --version && ldc2 --version