#!/usr/bin/env bash

nickel export "$1/final.ncl" | nix-instantiate --eval ninject.nix --arg-from-stdin jsonStr --json
