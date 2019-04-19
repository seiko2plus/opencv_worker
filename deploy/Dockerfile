FROM ubuntu:cosmic

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# add xenial for gcc-4.9
RUN echo "deb http://ports.ubuntu.com/ubuntu-ports xenial main universe" >> /etc/apt/sources.list
# add bionic for clang-5.0
RUN echo "deb http://ports.ubuntu.com/ubuntu-ports bionic main universe" >> /etc/apt/sources.list

RUN apt-get update \
 && apt-get install -y apt-utils build-essential gdb valgrind cmake git pkg-config curl \
                       g++-4.9 g++-5 g++-6 g++-7 g++-8 clang-4.0 clang-5.0 clang-6.0 ccache \
 && apt-get clean

WORKDIR /usr/src

# build ffmpeg
RUN apt-get update \
 && apt-get install -y libpng-dev libjpeg-dev libvpx-dev libx264-dev libx265-dev \
 && apt-get clean

ARG FFMPEG_VER=3.4.2
ARG FFMPEG_DEBUG_LEVEL=0

RUN git clone -b n${FFMPEG_VER} --single-branch --depth 1 git://source.ffmpeg.org/ffmpeg.git

# worker around ffmpeg color space issue
# disable PPC/Altivec YUV-RGB color space conversion optimization
ENV THE_PATCH=https://raw.githubusercontent.com/seiko2plus/just4share/master/opencv/issue11034/libswscale-disable-ppc-yuv2rgb.diff

RUN cd ffmpeg \
 && curl $THE_PATCH | git apply -v --whitespace=fix --no-index --directory libswscale \
 && ./configure --prefix=/usr --extra-libs="-lpthread -lm" --enable-gpl \
                --enable-libvpx --enable-libx264 --enable-nonfree \
                --enable-shared --enable-avresample \
                --enable-debug=${FFMPEG_DEBUG_LEVEL} \
                --disable-doc --disable-static \
 && make -j$(nproc) install

# Opencv build-dependencies
RUN apt-get update \
 && apt-get install -y python-dev python-numpy python3-dev python3-numpy \
                       ant default-jdk libeigen3-dev liblapack-dev libopenexr-dev \
                       libjasper-dev libwebp-dev libprotobuf-dev libtiff-dev \
 && apt-get clean

ENTRYPOINT ["/worker/deploy/entrypoint.sh"]
