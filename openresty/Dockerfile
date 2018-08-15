FROM alpine

RUN apk add curl make gcc perl musl-dev pcre-dev openssl-dev

RUN curl -o openresty-1.13.6.2.tar.gz https://openresty.org/download/openresty-1.13.6.2.tar.gz && tar -xvf openresty-1.13.6.2.tar.gz && cd openresty-1.13.6.2/ && ./configure -j2 && make -j2 && make install && export PATH=/usr/local/openresty/bin:$PATH

RUN rm -rf openresty-1.13.6.2.tar.gz openresty-1.13.6.2
