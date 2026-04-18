#!/bin/sh

source ./bar_util.sh
source ./bar_modules.sh

bar_watchers &
bar_sandbar &

# initial run
bar_refresh
sleep 1 # to somewhat avoid race condition
bar_sound

wait
