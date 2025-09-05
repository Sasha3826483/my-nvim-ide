#!/bin/bash

input="/workspace$(realpath $1)"

docker exec -it neovim-container nvim $input
