# Используем Alpine Linux как базовый образ для минимального размера контейнера
FROM alpine:latest

# Устанавливаем пакеты, необходимые для работы Neovim и его плагинов
# - neovim: текстовый редактор
# - git: для установки плагинов через менеджеры (например, lazy.nvim)
# - curl: для загрузки внешних ресурсов
# - build-base: для компиляции нативных расширений
# - python3, py3-pip: для поддержки Python-плагинов
# - nodejs, npm: для поддержки LSP и других инструментов
RUN apk add --no-cache \
    neovim \
    git \
    curl \
    build-base \
    python3 \
    py3-pip \
    nodejs \
    npm \
    clang \
    clang-extra-tools

# Python LSP
RUN npm install -g pyright bash-language-server

# Устанавливаем рабочую директорию
# /workspace будет точкой монтирования для корневой директории хоста (или другой)
WORKDIR /workspace

# Создаём директорию для конфигурации Neovim
RUN mkdir -p /root/.config/nvim

# Копируем пользовательский конфигурационный файл init.lua
# Предполагается, что init.lua находится в той же директории, где Dockerfile
COPY ./nvim-config/init.lua /root/.config/nvim/init.lua

# Устанавливаем переменную окружения для корректной работы терминала
ENV TERM=xterm-256color

#ENTRYPOINT ["nvim"]

#CMD ["/workspace"]
