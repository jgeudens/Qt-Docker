FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get -y install \
        git \
        wget \
        cmake \
        python3 \
        python3-pip \
        python3-venv \
        build-essential \
        ninja-build \
        curl \
        file \
        gcovr \
        mesa-common-dev \
        libglu1-mesa-dev \
        libglib2.0-0 \
        fontconfig \
        libxcb-* \
        libxkbcommon-x11-0 \
        libegl-dev \
        libcups2 \
        latexmk \
        texlive-latex-recommended \
        texlive-latex-extra \
    && apt-get -yq autoremove \
    && apt-get -yq autoclean \
    && apt-get -yq clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Configure important environment variables required for the application under test
# to access the virtual display created by Xvfb.
ENV DISPLAY=:0
ENV QT_QPA_PLATFORM=offscreen

RUN pip3 install aqtinstall

ARG QT=6.5.3
ARG QT_MODULES="qtserialbus qtserialport"
ARG QT_HOST=linux
ARG QT_TARGET=desktop
ARG QT_ARCH=gcc_64
RUN aqt install-qt --outputdir /opt/qt ${QT_HOST} ${QT_TARGET} ${QT} ${QT_ARCH} -m ${QT_MODULES}

ENV PATH /opt/qt/${QT}/${QT_ARCH}/bin:$PATH
ENV QT_PLUGIN_PATH /opt/qt/${QT}/${QT_ARCH}/plugins/
ENV QML_IMPORT_PATH /opt/qt/${QT}/${QT_ARCH}/qml/
ENV QML2_IMPORT_PATH /opt/qt/${QT}/${QT_ARCH}/qml/

COPY start.sh start.sh

CMD ./start.sh
