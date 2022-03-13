FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04

ARG NODEJS_VERSION=14.x
ARG GOLANG_VERSION=1.15.8
ARG GOOFYS_VERSION=0.24.0

ENV DEBIAN_FRONTEND=nointeractive \
    TZ=Asia/Tokyo \
    PATH=${PATH}:/usr/local/go/bin \
    GOPATH=/usr/local/go \
    GO111MODULE=on

RUN \
    # Install build modules
    sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
    build-essential git curl wget tar unzip python3 python3-pip s3fs fuse \
    dirmngr apt-transport-https lsb-release ca-certificates \
    zlib1g-dev libjpeg-dev graphviz && \
    #
    # Install aws-cli
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    #
    # Install nodejs
    curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION} | bash - && \
    apt-get install -y nodejs && \
    # #
    # # Install golang
    # wget https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    # tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    # #
    # # Install goofys
    # go get -d github.com/kahing/goofys@v${GOOFYS_VERSION} && \
    # go install github.com/kahing/goofys@v${GOOFYS_VERSION}
    #
    # Install goofys from binary
    wget https://github.com/kahing/goofys/releases/download/v${GOOFYS_VERSION}/goofys -P /usr/local/bin/

RUN \
    # Install jupyter lab
    python3 -m pip install \
    jupyterlab \
    jupyterlab-git \
    jupyterlab-lsp \
    jupyterlab_code_formatter \
    ipython-sql bash_kernel \
    yapf isort \
    numpy pandas matplotlib \
    --no-cache-dir && \
    # Setting jupyter lab configurations
    python3 -m jupyter labextension install --no-build '@krassowski/jupyterlab-lsp@3.9.1' && \
    python3 -m jupyter lab build --dev-build=False && \
    python3 -m bash_kernel.install

# Install python libraries
ADD requirements.txt requirements.txt
RUN python3 -m pip install -r requirements.txt --no-cache-dir
