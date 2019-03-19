FROM gcc:7.2

#ARG FFMD_REPO=https://github.com/FreifunkMD/site-ffmd.git
#ARG FFMD_VERSION=tags/v0.39
ARG FFMUC_REPO=https://github.com/freifunkMUC/site-ffm.git
ARG FFMUC_VERSION=release-v2019.0
ARG GLUON_REPO=git://github.com/freifunk-gluon/gluon.git
ARG GLUON_VERSION=v2016.2.x
ARG BUILD_SH=https://raw.githubusercontent.com/FreifunkMD/site-ffmd/master/build.sh

# Update & install packages & cleanup afterwards
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
        build-essential \
        gawk \
        git \
        libncurses-dev \
        libssl-dev \
        libz-dev \
        python-pip \
        python3-pip \
        subversion \
        unzip \
        wget && \
    apt-get clean autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN git clone $GLUON_REPO gluon
WORKDIR gluon
RUN git checkout $GLUON_VERSION

RUN git clone $FFMUC_REPO site
WORKDIR site
RUN git checkout $FFMUC_VERSION
RUN wget $BUILD_SH

WORKDIR /gluon
RUN pwd

# RUN make update

ENV FORCE_UNSAFE_CONFIGURE=1

ENTRYPOINT ["/bin/bash","-c"]
#CMD ["cd /gluon && make update && for i in ar71xx-generic ar71xx-tiny; do GLUON_TARGET=$i make -j4 || make V=s && break; done"]
CMD ["cd /gluon && make update && site/build.sh -y"]
