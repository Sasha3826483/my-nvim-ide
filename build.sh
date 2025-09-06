#!/bin/bash

echo "Сборка образа..."
docker build -t neovim . && echo "OK: Образ успешно создан" || { echo "ERROR: Ошибка сборки образа"; exit 1; }

echo "Запуск контейнера..."
docker run -it -d --name neovim --restart=unless-stopped -v /:/workspace neovim \
    && echo "OK: Контейнер успешно запущен" \
    || { echo "ERROR: Ошибка запуска контейнера"; exit 2; }

./creat-alias.sh
