#!/usr/bin/env bash

[ -f zig-logo-dark.svg ] || nix-shell -p wget --run 'wget https://github.com/ziglang/logo/raw/master/zig-logo-dark.svg'
[ -f zig-logo-dark.png ] || nix-shell -p inkscape --run 'inkscape zig-logo-dark.svg -w 1600 -h 560 --export-filename zig-logo-dark.png'
