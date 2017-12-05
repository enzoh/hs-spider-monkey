# File       : Dockerfile
# Copyright  : Copyright (c) 2017 DFINITY Stiftung. All rights reserved.
# License    : GPL-3
# Maintainer : Enzo Haussecker <enzo@dfinity.org>
# Stability  : Experimental

FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive
ENV PATH /root/.local/bin:${PATH}
ENV PREFIX /usr/local
ENV SHELL /bin/bash

RUN apt-get update
RUN apt-get install -y autoconf2.13 bzip2 g++-multilib make python wget

### Install SpiderMonkey
WORKDIR /tmp
RUN wget https://queue.taskcluster.net/v1/task/e8X3tKITQTeSFhtdirD7Xg/runs/0/artifacts/public/build/mozjs-57.0.1.tar.bz2
RUN tar xf mozjs-57.0.1.tar.bz2
RUN mkdir mozjs-57.0.1/js/src/obj
WORKDIR /tmp/mozjs-57.0.1/js/src/obj
RUN sh ../configure --disable-jemalloc --disable-shared-js --disable-tests --enable-install-strip --without-intl-api
RUN make
RUN make install
RUN mv mozglue/build/libmozglue.a ${PREFIX}/lib
RUN mv ${PREFIX}/lib/libjs_static.ajs ${PREFIX}/lib/libmozjs.a
RUN mv ${PREFIX}/include/mozjs-57 ${PREFIX}/include/mozjs

### Install Stack
WORKDIR /tmp
RUN mkdir -p /root/.local/bin
RUN wget -O - https://get.haskellstack.org | sh
RUN stack setup --resolver lts-9.17

### Create workspace
RUN mkdir /workspace
WORKDIR /workspace
