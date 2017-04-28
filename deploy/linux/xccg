#!/bin/sh

RET=5

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export DISPLAY=:0

while [ $RET -eq 5 ]
do
  LD_LIBRARY_PATH=lib nice -20 bin/casparcg "$@"
  RET=$?
done

