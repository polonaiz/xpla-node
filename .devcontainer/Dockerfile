ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && \
    apt-get install -y make vim bash-completion

# nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - && \
    apt-get install -y nodejs 

# docker-ce-cli
# https://docs.docker.com/engine/install/ubuntu/
RUN apt-get update && \
    sudo apt-get install ca-certificates curl gnupg lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    (curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg) && \
    (echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null) && \
    apt-get update && \
    apt-get install -y docker-ce-cli

