FROM ubuntu:groovy
LABEL maintainer "WalkingDead :3 <lexaxx14@gmail.com>"

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_OPTS=" -Xmx7G "
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

ENV TZ=Europe/Samara
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV target_repo="https://github.com/akhilnarang/scripts"
RUN apt-get update -qqy && \
    apt-get install --no-install-recommends -y \
        adb \
        autoconf \
        automake \
        axel \
        aria2 \
        bc \
        bison \
        build-essential \
        curl \
        ca-certificates ca-certificates-java \
        ccache \
        clang \
        cmake \
        expat \
        fastboot \
        flex \
        ffmpeg \
        gcc gcc-multilib \
        gawk \
        g++ g++-multilib \
        git \
        gnupg \
        glibc-doc \
        gperf \
        htop \
        imagemagick \
        jq \
        libxml2 \
        libtinfo5 \
        libc6-dev libcap-dev libexpat1-dev libgmp-dev libmpc-dev libmpfr-dev libncurses5-dev  libsdl1.2-dev libssl-dev \
        libtool \
        libxml-simple-perl libxml2 libxml2-utils \
        lsb-core \
        lzip '^lzma.*' lzop '^liblz4-.*' '^liblzma.*' \
        libssl-dev \
        libstdc++6 \
        lib32z1-dev \
        libncurses5 lib32ncurses5-dev ncurses-dev \
        locales \
        lzip \
        lzop \
        make \
        maven \
        nodejs \
        ncftp \
        openssl openssh-server \
        openjdk-8-jdk openjdk-8-jre \
        python2.7 python-is-python3 python-all-dev \
        pigz pixz \
        patch patchelf \
        p7zip-full p7zip-rar \
        pkg-config \
        pngcrush pngquant \
        re2c \
        rclone \
        rsync \
        ssh \
        sshpass \
        sudo \
        schedtool \
        squashfs-tools \
        subversion \
        tar \
        texinfo \
        tmate \
        tzdata \
        wget \
        w3m \
        xzdec \
        xz-utils \
        xsltproc \
        zlib1g-dev \
        zram-config \
        zstd libzstd-dev \
        zip unzip && \
    apt-get autoremove -qqy && \
    apt-get autoclean -qqy && \
    git clone -q $target_repo s && \
    rm -rf s/.git && \
    bash s/setup/android_build_env.sh

RUN echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen
RUN /usr/sbin/locale-gen
RUN rm -rf /var/lib/apt/lists/* /root/s
RUN git config --global user.name "WalkingDead3"
RUN git config --global user.email lexaxx14@gmail.com
RUN git config --global color.ui "true"
ENV USE_CCACHE=1

CMD ["/bin/bash"]
