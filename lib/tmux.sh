#!/bin/bash

# Force tmux to use 256 colors
test -n "$TMUX" && export TERM=screen-256color || true
