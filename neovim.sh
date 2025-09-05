#!/bin/bash

input="/workspace$(realpath $1)"

docker exec -it neovim nvim $input
