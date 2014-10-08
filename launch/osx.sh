#!/bin/bash

cd "$(dirname "$0")"

echo "    Installing Scheduled Tasks"

mkdir -p ~/Library/LaunchAgents

for i in *.plist; do
    cp $i ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/$i
done
