#!/bin/bash

source $HOME/.scripts/utilities.sh

icon="$HOME/Pictures/Backgrounds/SummerFallSplit.png"

(( $# )) && { icon=$1; }

exec i3lock -u -i "$icon"
