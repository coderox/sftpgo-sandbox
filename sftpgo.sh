#! /bin/bash

if [ ! -d ./sftpgo ]; then
    echo "Creating directories"
    mkdir -p ./sftpgo/{remote,local}/{home,data}
    chown -R 1000:1000 ./sftpgo
fi

docker run --name remote-sftpgo \
    -p 8080:8080 \
    -p 2022:2022 \
    --mount type=bind,source=./sftpgo/remote/data,target=/srv/sftpgo \
    --mount type=bind,source=./sftpgo/remote/home,target=/var/lib/sftpgo \
    -d "drakkan/sftpgo:latest"

# docker run --name local-sftpgo \
#     -p 8081:8080 \
#     -p 2023:2022 \
#     --mount type=bind,source=./sftpgo/local/data,target=/srv/sftpgo \
#     --mount type=bind,source=./sftpgo/local/home,target=/var/lib/sftpgo \
#     -d "drakkan/sftpgo:latest"
