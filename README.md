# Qt-Docker
Dockerfile configuration for Qt build environment on Linux and Windows specific for ModbusScope.

## Environment

Some paths are already configured for this specific toolchain.

* Folder for Qt binaries is added to path

  `ENV PATH /opt/qt/${QT}/${QT_ARCH}/bin:$PATH`

* Some Qt specific paths

  ```bash
  ENV QT_PLUGIN_PATH /opt/qt/${QT}/${QT_ARCH}/plugins/
  ENV QML_IMPORT_PATH /opt/qt/${QT}/${QT_ARCH}/qml/
  ENV QML2_IMPORT_PATH /opt/qt/${QT}/${QT_ARCH}/qml/
  ```

* Configure CMake to find correct Qt installation

  `ENV CMAKE_PREFIX_PATH /opt/qt/${QT}/${QT_ARCH}/lib/cmake/Qt5`

## Docker

### Install and setup

https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

* Add ppa and install

  * Check website

* Test:

  * ```bash
    sudo docker run hello-world
    ```

### Basic info

Older: https://www.guru99.com/docker-tutorial.html

New command style: https://medium.com/swlh/setting-up-an-ubuntu-20-04-docker-container-c74a873d26c8

* Start docker container of latest ubuntu

  * ```bash
    sudo docker run --name ubuntu-build -it --entrypoint "/bin/bash" ubuntu:22.04
    ```

* Show saved docker containers

  * ```bash
    sudo docker ps -a
    ```

* Remove container
  
  * ```bash
    sudo docker rm [container name]
    ```

### Checkout source of project

```bash
cd /home/
git clone --depth=50 --branch=master https://github.com/ModbusScope/ModbusScope.git ModbusScope
cd ModbusScope
```

## Docker hub

https://docs.docker.com/docker-hub/

```bash
# Build
sudo docker build -t jgeudens/qt-linux .

# Test
sudo docker run --name qt-linux -it --entrypoint "/bin/bash" jgeudens/qt-linux

# Tag
sudo docker image tag jgeudens/qt-linux jgeudens/qt-linux:6.2.2_build_2

# Push with version tag
sudo docker push jgeudens/qt-linux:6.2.2_build_2

```

## Troubleshooting

### Python package system-wide

https://leimao.github.io/blog/Docker-Python-Setup/

### Track down missing dependencies:

Error shows libqxcb.so

```bash
ldd /opt/qt/5.15.2/gcc_64/plugins/platforms/libqxcb.so  | grep "not found"
```
