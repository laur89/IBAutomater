#!/bin/bash

export JAVA_TOOL_OPTIONS=$2

ps -AFH

pkill -9 Xvfb
#pkill -9 java

# TODO: is this change stil needed how that we're launcing pycharm & rider via
#       binary launchers as opposed to from shell wrappers? think
# note --no-run-if-empty is a GNU extension
ps --no-headers -eo 'pid,comm,command' \
    | awk '{ if ($2 == "java" && $3 !~ /\/(Rider|PyCharm(CE)?)20[0-9]+\.[0-9]+/) {print $1} }' \
    | xargs --no-run-if-empty -- kill -9

sleep 5

rm /tmp/.X1-lock
ps -AFH

unset DISPLAY
Xvfb :1 -screen 0 1024x768x24 2>&1 >/dev/null &
export DISPLAY=:1

ibgatewayExecutable=$1
shift

$ibgatewayExecutable "$@"
