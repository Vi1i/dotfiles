#!/bin/sh
#TODO:
#  * Check out https://raw.githubusercontent.com/onespaceman/dotfiles/158a49ab84b92e9653b476b5964e71d411e49ecc/lemonbar/.config/lemonbar/bar
#    * This has a nice inplementation of a fifo
#  * WiFi
#  * Ethernet
#  * Workspaces
#  * CPU
#  * Memory

. $HOME/.config/pc/lemonbar.conf

if [ $(pgrep -cx $(basename $0)) -gt 1 ] ; then
  printf "%s\n" "The status bar is already running." >&2
  exit 1
fi

FONT1=""
FONT2="Font Awesome 5 Pro Regular:size=18"

clock() {
	date '+%Y-%m-%d %H:%M:%S'
}

battery() {
	charging=$(acpi -a | tr -s ' ' | cut -d' ' -f3)
	if [[ "$charging" == "on-line" ]]; then
		echo -e "%{F#FFFF00}\uf376%{F-}"
	else
		count=$(acpi -b | wc -l);
		sum=$(acpi -b | egrep -o '[0-9]{1,3}%' | tr -d '%' | xargs -I% echo -n '+%');
		percentage=$(( sum / count ))

		if (( percentage > 75 )); then
			# Full
			echo -e "%{F#00FF00}\uf240%{F-}"
		elif (( percentage > 50 )); then
			# 3/4
			echo -e "%{F#39C408}\uf241%{F-}"
		elif (( percentage > 25 )); then
			# 2/4
			echo -e "%{F#738910}\uf242%{F-}"
		elif (( percentage > 10 )); then
			# 1/4
			echo -e "%{F#AC4E18}\uf243%{F-}"
		else
			# Holyshit charge
			echo -e "%{F#E61321}\uf377%{F-}"
		fi
	fi
}

volume() {
	volume=$(amixer sget Master | sed -n "0,/.*\[\([0-9]\+\)%\].*/s//\1/p")
	state=$(amixer sget Master | grep -Eoe '\[(on|off)\]' | head -n 1)

	if   [[ $state == '[off]' ]]; then
		token='\uf2e2'
		volume='--'
	elif [[ $volume -gt 40 ]]; then
		token='\uf028'
	elif [[ $volume -gt 0 ]]; then
		token='\uf027'
	else
		token='\uf026'
	fi

	echo -e "%{A3:amixer -q sset Master toggle:}%{A5:amixer -q sset Master 1%+:}%{A4:amixer -q sset Master 1%-:}$token $volume%{A}%{A}%{A}"
}

cpuload() {
	LINE=`ps -eo pcpu |grep -vE '^\s*(0.0|%CPU)' |sed -n '1h;$!H;$g;s/\n/ +/gp'`
	bc <<< $LINE
}

memused() {
	read t f <<< `grep -E 'Mem(Total|Free)' /proc/meminfo |awk '{print $2}'`
	bc <<< "scale=2; 100 - $f / $t * 100" | cut -d. -f1
}

network() {
	read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p'`
	if iwconfig $int1 >/dev/null 2>&1; then
		wifi=$int1
		eth0=$int2
	else
		wifi=$int2
		eth0=$int1
	fi
	ip link show $eth0 | grep 'state UP' >/dev/null && int=$eth0 ||int=$wifi

	#int=eth0

	ping -c 1 8.8.8.8 >/dev/null 2>&1 && 
		echo "$int connected" || echo "$int disconnected"
}

groups() {
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

	for w in `seq 0 $((cur - 1))`; do line="${line}="; done
	line="${line}|"
	for w in `seq $((cur + 2)) $tot`; do line="${line}="; done
	echo $line
}

nowplaying() {
	cur=`mpc current`
	# this line allow to choose whether the output will scroll or not
	test "$1" = "scroll" && PARSER='skroll -n20 -d0.5 -r' || PARSER='cat'
	test -n "$cur" && $PARSER <<< $cur || echo "- stopped -"
}

# This loop will fill a buffer with our infos, and output it to stdout.
while :; do
	right="$(volume)%{O10}$(battery)%{O10}$(clock)"
	center=""
	left=""

	echo "%{l}$left%{c}$center%{r}$right"


	# use `nowplaying scroll` to get a scrolling output!
	sleep 1 # The HUD will be updated every second
done | lemonbar -f "$FONT1" -f "$FONT2" -p | while :; do read line; eval $line; done &
