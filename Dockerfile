FROM nginx:alpine

RUN apk add --update curl git make gcc musl-dev pcre-dev zlib-dev

RUN git clone https://github.com/simplresty/ngx_devel_kit.git
RUN git clone https://github.com/openresty/lua-nginx-module.git
RUN git clone http://luajit.org/git/luajit-2.0.git && cd luajit-2.0 && make && make install && cd ..

RUN curl -o nginx-1.15.1.tar.gz http://nginx.org/download/nginx-1.15.1.tar.gz && tar xfz nginx-1.15.1.tar.gz

RUN cd nginx-1.15.1 && ./configure --with-compat --add-dynamic-module=../ngx_devel_kit --add-dynamic-module=../lua-nginx-module && make modules && cp objs/*.so /etc/nginx/modules
COPY configs/nginx.conf /etc/nginx/nginx.conf
COPY configs/default.conf /etc/nginx/conf.d/default.conf
