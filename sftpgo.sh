#! /bin/bash

if [ ! -d ./sftpgo ]; then
    echo "Creating directories"
    mkdir sftpgo
    mkdir ./sftpgo/data
    chown -R 1000:1000 ./sftpgo/data
    mkdir ./sftpgo/home
    chown -R 1000:1000 ./sftpgo/home
fi

docker run --name sandbox-sftpgo \
    -p 8080:8080 \
    -p 2022:2022 \
    --mount type=bind,source=./sftpgo/data,target=/srv/sftpgo \
    --mount type=bind,source=./sftpgo/home,target=/var/lib/sftpgo \
    -d "drakkan/sftpgo:latest"
