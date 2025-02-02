#!/bin/bash

export JAVA_TOOL_OPTIONS=$2

ps -AFH

pkill -9 Xvfb
#pkill -9 java

# note --no-run-if-empty is a GNU extension
ps --no-headers -eo 'pid,comm,command' \
    | awk '{ if ($2 == "java" && $3 !~ /\/(Rider|PyCharm(CE)?)20[0-9]+\.[0-9]+/) {print $1} }' \
    | xargs --no-run-if-empty -- kill -9

sleep 5

ps -AFH

Xvfb :1 -screen 0 1024x768x24 2>&1 >/dev/null &
export DISPLAY=:1
$1/ibgateway
