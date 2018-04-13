#! /bin/bash

sleep 1

. $HOME/.config/pc/lemonbar.conf

if [ ! -p "$panel_fifo" ]; then
	echo "A reader is not active!"
	exit 1
fi

if [ -f "$panel_fifo_lock" ]; then
	echo "A writer is alaready running"
	echo "If this is not true, please remove the lock file: $panel_fifo_lock"
	exit 2
else
	trap "rm -rf $panel_fifo_lock" EXIT QUIT TERM
  trap "pkill -9 $(basename $0)" EXIT QUIT TERM
	touch $panel_fifo_lock
fi

((ctl_clock = upd_clock))
((ctl_batt = upd_batt))
((ctl_vol = upd_vol))
((ctl_cpu = upd_cpu))
((ctl_mem = upd_mem))

clock() {
  date '+%Y/%m/%d %H:%M:%S'
}

battery() {
	charging=$(acpi -a | tr -s ' ' | cut -d' ' -f3)
	if [[ "$charging" == "on-line" ]]; then
		echo -e "%{F$color_batt_charging}$icon_batt_charging%{F-}"
	else
		count=$(acpi -b | wc -l);
		sum=$(acpi -b | egrep -o '[0-9]{1,3}%' | tr -d '%' | xargs -I% echo -n '+%');
		percentage=$(( sum / count ))

		if (( percentage > 75 )); then
			# Full
			echo -e "%{F$color_batt_full}$icon_batt_full%{F-}"
		elif (( percentage > 50 )); then
			# 3/4
			echo -e "%{F$icolor_batt_three_fourths}$icon_batt_three_fourths%{F-}"
		elif (( percentage > 25 )); then
			# 2/4
			echo -e "%{F$color_batt_half}$icon_batt_half%{F-}"
		elif (( percentage > 10 )); then
			# 1/4
			echo -e "%{F$color_batt_one_fourth}$icon_batt_one_fourth%{F-}"
		else
			# Holyshit charge
			echo -e "%{F$color_batt_emergency}$icon_batt_emergency%{F-}"
		fi
	fi
}

volume() {
	volume=$(amixer sget Master | sed -n "0,/.*\[\([0-9]\+\)%\].*/s//\1/p")
	state=$(amixer sget Master | grep -Eoe '\[(on|off)\]' | head -n 1)

	if   [[ $state == '[off]' ]]; then
		token=$icon_volume_off
		volume='--'
	elif [[ $volume -gt 40 ]]; then
		token=$icon_volume_gt_40
	elif [[ $volume -gt 0 ]]; then
		token=$icon_volume_gt_0
	else
		token=$icon_volume
	fi

	echo -e "%{A3:amixer -q sset Master toggle:}%{A5:amixer -q sset Master 1%+:}%{A4:amixer -q sset Master 1%-:}$token $volume%{A}%{A}%{A}"
}

cpu() {
	# Get the first line with aggregate of all CPUs 
	 cpu_now=($(head -n1 /proc/stat)) 
	 # Get all columns but skip the first (which is the "cpu" string) 
	 cpu_sum="${cpu_now[@]:1}" 
	 # Replace the column seperator (space) with + 
	 cpu_sum=$((${cpu_sum// /+})) 
	 # Get the delta between two reads 
	 cpu_delta=$((cpu_sum - cpu_last_sum)) 
	 # Get the idle time Delta 
	 cpu_idle=$((cpu_now[4]- cpu_last[4])) 
	 # Calc time spent working 
	 cpu_used=$((cpu_delta - cpu_idle)) 
	 # Calc percentage 
	 cpu_usage=$((100 * cpu_used / cpu_delta)) 
	 
	 # Keep this as last for our next read 
	 cpu_last=("${cpu_now[@]}") 
	 cpu_last_sum=$cpu_sum 
	 
	 echo "CPU:$cpu_usage%" 
}

mem() {
	mem=`free | grep Mem: | awk '{ print 100 - ((($2 - $3) / $2) * 100) }' | cut -d'.' -f1`
	swap=`free | grep Swap: | awk '{ print 100 - ((($2 - $3) / $2) * 100) }' | cut -d'.' -f1`
	total_mem=`free -h | grep Mem: | awk '{ print $2 }'`
	total_swap=`free -h | grep Swap: | awk '{ print $2 }'`

	echo -e "$total_mem:$mem%||$total_swap:$swap%"
}

while :; do
  if (( ctl_clock == upd_clock )); then
    echo "CLK:`clock`" > $panel_fifo
    ((ctl_clock = 0))
  fi

  if (( ctl_batt == upd_batt )); then
    echo "BAT:`battery`" > $panel_fifo
    ((ctl_batt = 0))
  fi

  if (( ctl_vol == upd_vol )); then
    echo "VOL:`volume`" > $panel_fifo
    ((ctl_vol = 0))
  fi

  if (( ctl_cpu == upd_cpu )); then
    # this had to be done differently with a direct pip becuase
    # I could not get bash to recognize previously used vars.
    cpu > $panel_fifo
    ((ctl_cpu = 0))
  fi

  if (( ctl_mem == upd_mem )); then
    echo "MEM:`mem`" > $panel_fifo
    ((ctl_mem = 0))
  fi

  sleep 1
  ((ctl_clock++))
  ((ctl_bat++))
  ((ctl_vol++))
  ((ctl_cpu++))
  ((ctl_mem++))
done
exit 0
