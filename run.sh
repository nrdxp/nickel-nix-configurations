#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nickel

nickel export "$1/final.ncl" | nix-instantiate --eval ninject.nix --arg-from-stdin jsonStr --json
