FROM ubuntu:24.04

ARG PYTHON_VENV_PATH=/python/venv

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    git \
    wget \
    cmake \
    python3-full \
    build-essential \
    ninja-build \
    curl \
    unzip \
    file \
    gcovr \
    mesa-common-dev \
    libglu1-mesa-dev \
    libglib2.0-0 \
    fontconfig \
    libxcb-* \
    libxkbcommon-x11-0 \
    libegl-dev \
    libcups2-dev \
    && apt-get -yq autoremove \
    && apt-get -yq autoclean \
    && apt-get -yq clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN mkdir -p ${PYTHON_VENV_PATH} && \
    python3 -m venv ${PYTHON_VENV_PATH}

ENV PATH=${PYTHON_VENV_PATH}/bin:$PATH

RUN cd ${PYTHON_VENV_PATH}/bin && \
    pip install --upgrade pip setuptools wheel

RUN pip install aqtinstall==3.3.0

ARG QT=6.8.3
ARG QT_MODULES="qtserialbus qtserialport"
ARG QT_HOST=linux
ARG QT_TARGET=desktop
ARG QT_ARCH=linux_gcc_64
ARG QT_ARCH_PATH=gcc_64
RUN aqt install-qt --outputdir /opt/qt ${QT_HOST} ${QT_TARGET} ${QT} ${QT_ARCH} -m ${QT_MODULES}

ENV PATH=/opt/qt/${QT}/${QT_ARCH_PATH}/bin:$PATH
ENV QT_PLUGIN_PATH=/opt/qt/${QT}/${QT_ARCH_PATH}/plugins/
ENV QML_IMPORT_PATH=/opt/qt/${QT}/${QT_ARCH_PATH}/qml/
ENV QML2_IMPORT_PATH=/opt/qt/${QT}/${QT_ARCH_PATH}/qml/

# Configure important environment variables required for the application under test
# to access the virtual display created by Xvfb.
ENV DISPLAY=:0
ENV QT_QPA_PLATFORM=offscreen

COPY start.sh start.sh
RUN chmod +x start.sh

CMD ["./start.sh"]
