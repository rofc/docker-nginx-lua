FROM nginx:alpine

ENV NGINX_VER=1.15.1

RUN apk add --update curl git make gcc musl-dev pcre-dev zlib-dev

RUN git clone https://github.com/simplresty/ngx_devel_kit.git
RUN git clone https://github.com/openresty/lua-nginx-module.git
RUN git clone http://luajit.org/git/luajit-2.0.git && cd luajit-2.0 && make && make install && cd ..

RUN curl -o nginx-${NGINX_VER}.tar.gz http://nginx.org/download/nginx-${NGINX_VER}.tar.gz && tar xfz nginx-${NGINX_VER}.tar.gz

RUN cd nginx-${NGINX_VER} && ./configure --with-compat --add-dynamic-module=../ngx_devel_kit --add-dynamic-module=../lua-nginx-module && make modules && cp objs/*.so /etc/nginx/modules

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf

RUN rm -rf ngx_devel_kit* lua-nginx-module* luajit-2.0* nginx-${NGINX_VER}*
