#! /usr/bin/env python3

from subprocess import Popen
import i3ipc

def on_shutdown(conn):
    # A nasty way to clean up my scripts...
    Popen('pkill -9 lemonbar; rm -f ~/.fifo/lemonbar; rm -f ~/.fifo/lemonbar.lock', shell=True)

i3 = i3ipc.Connection()

i3.on('ipc_shutdown', on_shutdown)

i3.main()
