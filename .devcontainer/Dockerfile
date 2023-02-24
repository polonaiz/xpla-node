ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && \
    apt-get install -y make vim bash-completion

# kubectl
# https://kubernetes.io/ko/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
RUN sudo apt-get update && \
    sudo apt-get install -y apt-transport-https ca-certificates curl
RUN sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
RUN sudo apt-get update && \
    sudo apt-get install -y kubectl
RUN kubectl completion bash > ./kubectl
RUN sudo mv ./kubectl /etc/bash_completion.d/

# gcloud cli
RUN apt-get install -y apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | \
    apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && \
    apt-get install -y google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin

# docker-ce-cli
# https://docs.docker.com/engine/install/ubuntu/
RUN apt-get update
RUN sudo apt-get install ca-certificates curl gnupg lsb-release
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get install -y docker-ce-cli

#k9s
RUN mkdir /tmp/k9s && \
    cd /tmp/k9s && \
    wget https://github.com/derailed/k9s/releases/download/v0.27.2/k9s_Linux_amd64.tar.gz && \
    tar zxvf k9s_Linux_amd64.tar.gz && \
    mv k9s /usr/local/bin && \
    rm -rf /tmp/k9s
