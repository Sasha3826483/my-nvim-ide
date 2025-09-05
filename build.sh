#!/bin/bash

echo "Сброка образа..."
docker build -t neovim:v1.0 . &>./log && \
    { echo "Образ успешно собран"; echo "Запуск котнейнера..."; \
        docker run -it -d --name neovim --restart=unless-stopped -v /:/workspace neovim:v1.0 &>./log &&  \
        echo "Котйнер успешно запущен" || { echo "Ошибка запуска контейнера (см. логи)"; exit 1; } } \
            || { echo "Ошибка сборки образа (см. логи)"; exit 2; }

echo "Сброка алиаса..."
echo "alias neovim='/home/user/nvim-docker/neovim.sh'" >> ~/.bashrc && echo "Алиас успешно создан" \
    || echo "Ошибка при создании алиаса (см лог)"
