########
FROM golang:1.19 as builder

RUN git clone https://github.com/xpladev/xpla.git ~/xpla 

RUN cd ~/xpla && \
    git checkout v1.0.0 && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.0.0

RUN cd ~/xpla && \
    git checkout v1.1.0 && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.1.0

RUN cd ~/xpla && \
    git checkout v1.1.2 && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.1.2

RUN cd ~/xpla && \
    git checkout v1.1.3 && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.1.3

RUN cd ~/xpla && \
    git checkout v1.2.0 && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.2.0

RUN cp /go/pkg/mod/github.com/!cosm!wasm/wasmvm@v1.0.0/api/libwasmvm.x86_64.so /usr/local/lib && \
    ldconfig


########
FROM ubuntu:22.10 AS runner

RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && \
    apt-get install -y vim bash-completion wget sysstat dstat net-tools curl tmux jq dnsutils liblz4-tool pv git

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

COPY --from=builder /usr/local/bin/xplad_* /usr/local/bin/
COPY --from=builder /usr/local/lib/libwasmvm.x86_64.so /usr/local/lib/
RUN ldconfig
COPY xpla-* /root/
RUN chmod +x /root/xpla-*


# RUN apt-get install -y apt-transport-https ca-certificates gnupg
# RUN (echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list)
# RUN apt-key list
   
# RUN (curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.gpg)
# RUN apt-get update && apt-get -y install google-cloud-cli


# xplad_v1.0.0 start --home=/data/xplad-default @0
# xplad_v1.1.0 start --home=/data/xplad-default @755000

# 
# 2022-09-01 00:00:00.000000 UTC	1661990400
# 2022-10-01 00:00:00.000000 UTC	1664582400
# 2022-11-01 00:00:00.000000 UTC	1667260800
# 2022-12-01 00:00:00.000000 UTC	1669852800

# time tar -c -I 'zstd -T8' -f /arch/lib/xpla/xpla__archive__dimension_37-1__data__0001900000.tar.zst ./data
# time tar -c -I 'zstd -T8' -f /arch/lib/xpla/xpla__archive__dimension_37-1__data__0002100000.tar.zst ./data
