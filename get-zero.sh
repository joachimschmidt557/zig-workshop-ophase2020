#!/usr/bin/env bash

[ -f zero.svg ] || nix-shell -p wget --run 'wget https://github.com/ziglang/logo/raw/master/zero.svg'
[ -f zero.png ] || nix-shell -p inkscape --run 'inkscape zero.svg -w 500 -h 500 --export-filename zero.png'
