#!/bin/bash

cd "$(dirname "$0")"

echo "    Installing Scheduled Tasks"

for i in *.plist; do
    cp $i ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/$i
done
