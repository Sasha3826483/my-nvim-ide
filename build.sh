#!/bin/bash

echo "Остановка и удаление контейнера ..."
docker stop neovim 1>/dev/null 2>log && docker rm neovim 1>/dev/null 2>>log && \
    echo "OK: Контейнер успешно удален" || \
    { echo "ERROR: Ошибка остановки контейнера"; exit 1; }

sleep 3

echo "Удаление образа ..."
docker rmi neovim 1>/dev/null 2>>log && echo "OK: Контейнер успешно удален" || { echo "ERROR: Ошибка удаления контейнера"; exit 1; }

sleep 3

echo "Сборка образа..."
docker build -t neovim . && echo "OK: Образ успешно создан" || { echo "ERROR: Ошибка сборки образа"; exit 1; }

sleep 3

echo "Запуск контейнера..."
docker run -it -d --name neovim --restart=unless-stopped \
    --cap-add=SYS_PTRACE \
    --security-opt seccomp=unconfined \
    -v /:/workspace neovim \
    1>/dev/null 2>>log \
    && echo "OK: Контейнер успешно запущен" \
    || { echo "ERROR: Ошибка запуска контейнера"; exit 2; }

./creat-alias.sh
