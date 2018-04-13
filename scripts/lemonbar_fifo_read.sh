#! /bin/bash

. $HOME/.config/pc/lemonbar.conf

if [ -p "$panel_fifo" ]; then
	echo "A reader is active!"
	echo "If this is not true, please remove the fifo: $panel_fifo"
	exit 1
else
	trap "pkill -9 $(basename $0)" EXIT QUIT TERM
	trap "pkill -9 lemonbar" EXIT QUIT TERM
	trap "rm -rf $panel_fifo" EXIT QUIT TERM
	mkfifo "$panel_fifo"
fi

CLK=""
BAT=""
VOL=""
CPU=""
MEM=""
while :; do
  while read -r line; do
    if [ "$line" = 'quit' ]; then
      printf "%s: Exiting...\n" "$panel_fifo"
      exit 0
    fi

    data_type="$(cut -d ':' -f 1 <<< $line)"
    data="$(cut -d ':' -f 2- <<< $line)"
    case $data_type in
    	"CLK")
			CLK="$data"
			;;
    	"BAT")
			BAT="$data"
			;;
    	"VOL")
			VOL="$data"
			;;
    	"MEM")
			MEM="$data"
			;;
    	"CPU")
			CPU="$data"
			;;
		*)
			echo $data_type
			;;
	esac

	right="$VOL%{O10}$BAT%{O10}$CLK"
	center="$CPU%{O10}$MEM"
	left=""

    #printf "%%{l}%s%%{c}%s%%{r}%s" "$left" "$center" "$right"
    echo "%{l}$left%{c}$center%{r}$right"
  done < $panel_fifo
 done | lemonbar -f "$font" -f "$icon_font" -p | while :; do read line; eval $line; done
exit 0
