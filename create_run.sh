#!/bin/bash

sudo docker rm qt-linux

sudo docker build -t jgeudens/qt-linux .

sudo docker run --name qt-linux -it --entrypoint "/bin/bash" jgeudens/qt-linux
