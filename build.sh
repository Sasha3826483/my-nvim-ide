#!/bin/bash

docker run -it -d --restart=unless-stopped --name neovim-container -v /:/workspace neovim:v1.0
