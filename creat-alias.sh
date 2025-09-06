#!/bin/bash

shl="$HOME/.$(echo "$SHELL" | sed 's|/bin/||')rc"
cat $shl | grep "alias neovim" &>/dev/null && { echo "OK: Алиас уже создан"; exit 0; }

echo "Сброка алиаса..."; sleep 1
echo 'alias neovim="$HOME/nvim-docker/neovim.sh"' >> $shl && echo "OK: Алиас 'neovim' успешно создан"
