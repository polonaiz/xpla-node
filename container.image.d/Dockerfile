########
FROM golang:1.19.8 as builder

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
    git checkout v1.1.0-cube && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.1.0-cube

RUN cd ~/xpla && \
    git checkout v1.1.2 && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.1.2

RUN cd ~/xpla && \
    git checkout v1.1.2-cube && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.1.2-cube

RUN cd ~/xpla && \
    git checkout v1.1.3 && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.1.3

RUN cd ~/xpla && \
    git checkout v1.2.0 && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.2.0

RUN cd ~/xpla && \
    git checkout v1.2.1 && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.2.1

RUN cd ~/xpla && \
    git checkout v1.2.2 && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.2.2
        # cosmwasm 1.0.0 -> 1.0.1

RUN cd ~/xpla && \
    git checkout v1.2.3 && \
    make install && \
    mv /go/bin/xplad /usr/local/bin/xplad_v1.2.3

# RUN cp /go/pkg/mod/github.com/!cosm!wasm/wasmvm@v1.0.0/api/libwasmvm.x86_64.so /usr/local/lib && \
RUN cp /go/pkg/mod/github.com/!cosm!wasm/wasmvm@v1.0.1/api/libwasmvm.x86_64.so /usr/local/lib/libwasmvm.x86_64.so.1.0.1 && \
    ldconfig


########
FROM ubuntu:22.04 AS runner

RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && \
    apt-get install -y vim bash-completion wget sysstat dstat net-tools curl tmux jq dnsutils liblz4-tool pv git

COPY --from=builder /usr/local/bin/xplad_* /usr/local/bin/
COPY --from=builder /usr/local/lib/libwasmvm.x86_64.so.1.0.1 /usr/local/lib/
RUN ln -s /usr/local/lib/libwasmvm.x86_64.so.1.0.1 /usr/local/lib/libwasmvm.x86_64.so
RUN ldconfig
