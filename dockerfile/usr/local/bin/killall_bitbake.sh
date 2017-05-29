#!/bin/bash
for pid in $(ps -ef | awk '/bitbake/ {print $2}'); do kill -9 $pid; done
